//
//  MovieDataModel.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import Foundation
import UIKit
import Alamofire

// TODO: вынести enum, extension в отдельные файлики

enum HandleRequest {
    case succes(popularMovie: MovieResult)
    case error(error: Error)
}

enum ApplicationError: Error {
    case network(Networking)
    case unowned
    case loadingInProcess
    
    enum Networking: Error {
        case emptyData
        case error(Error?)
    }
}

extension URLSessionConfiguration {
    static let movieConfiguration: URLSessionConfiguration = {
        var configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.timeoutIntervalForRequest = 30.0
        return configuration
    }()
}

class MovieNetworking {
    
    private let movieUrl = "https://api.themoviedb.org/3/movie/popular"
    private let imageMovieURL = "https://image.tmdb.org/t/p/w500/"
    private let decoder = JSONDecoder()
    private let session = URLSession(configuration: .movieConfiguration)
    private let sessionAF = Session(configuration: .movieConfiguration)
    
    func getMoviesAM(pageNumber: Int, completion: @escaping (HandleRequest) -> Void) {
        let parameters = Parameters(dictionaryLiteral: ("language", "en-US"), ("page", pageNumber), ("api_key", "ff583eecef0b8d51b43d55166fd50b9a"))
        sessionAF.request(movieUrl,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil).response {
            response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonDecoder = try JSONDecoder().decode(MovieResult.self, from: data!)
                    completion(.succes(popularMovie: jsonDecoder))
                } catch {
                    completion(.error(error: error))
                }
            case .failure(let error):
                completion(.error(error: error))
            }
        }
    }
    
    func getMovieImageAM(imagePath: String, completion: @escaping (UIImage?) -> Void) {
        let imageUrl = imageMovieURL + imagePath
        AF.request(
            imageUrl,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            interceptor: nil
        ).response { response in
            switch response.result {
            case .success(let data):
                let image = UIImage(data: data ?? Data())
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func taskLoadMovieImage(imagePath: String, callBack: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        
        guard let posterPath = URL(string: imagePath) else {
            DispatchQueue.main.async {
                callBack(nil)
            }
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: posterPath) { data, response, error in
            if error != nil {
                print("Error poster: \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    callBack(nil)
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Error poster: data not found")
                DispatchQueue.main.async {
                    callBack(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                callBack(image)
            }
        }
        return task
    }
    
    func getMovieImage(withURLString: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let posterPath = URL(string: withURLString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        let task = session.dataTask(with: posterPath) { data, response, error in
            if error != nil {
                print("Error poster: \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Error poster: data not found")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
    
    func getMovies(completion: @escaping (HandleRequest) -> Void) {
        
        guard let popularMovieUrl = URL(string: movieUrl) else { return }
    
        let task = session.dataTask(with: popularMovieUrl) { [weak self] data, response, error in
            
            guard let strongSelf = self else { return }
            
            if error != nil {
                print("Error: \(String(describing: error?.localizedDescription))")
                completion(.error(error: error!))
                return
            }
            
            guard data != nil else {
                completion(.error(error: ApplicationError.Networking.emptyData))
                return
            }
                
            do {
                let movieList = try strongSelf.decoder.decode(MovieResult.self, from: data!)
                completion(.succes(popularMovie: movieList))
                print(movieList.totalResults)
                print("\(movieList.totalResults)")
            } catch let error {
                print("Error: \(String(describing: error.localizedDescription))")
                completion(.error(error: error))
            }
        }
        task.resume()
    }
}





