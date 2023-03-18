//
//  MovieDataModel.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import Foundation
import UIKit
import Alamofire

enum HandleRequest {
    case succes(popularMovie: Movie)
    case error(error: Error)
}

enum MovieNetworkingError: Error {
    case emptyData
}

class MovieNetworking {
    
    var moviesResult: [Result] = []
    
    private let movieUrl = "https://api.themoviedb.org/3/movie/popular?api_key=ff583eecef0b8d51b43d55166fd50b9a&language=en-US&"
    private let decoder = JSONDecoder()
    
    
    func getMovies(completion: @escaping (HandleRequest) -> Void) {
        
        guard let popularMovieUrl = URL(string: movieUrl) else { return }
    
        let task = URLSession.shared.dataTask(with: popularMovieUrl) { [weak self] data, response, error in
            
            guard let strongSelf = self else { return }
            
            if error != nil {
                print("Error: \(String(describing: error?.localizedDescription))")
                completion(.error(error: error!))
                return
            }
            
            guard data != nil else {
                completion(.error(error: MovieNetworkingError.emptyData))
                return
            }
                
            do {
                let movieList = try strongSelf.decoder.decode(Movie.self, from: data!)
                completion(.succes(popularMovie: movieList))
                print("\(movieList.totalResults)")
            } catch let error {
                completion(.error(error: error))
            }
        }
        task.resume()
    }
    
    func getMovieImage(withURLString: String, completion: @escaping (UIImage) -> Void) {
        
        guard let posterPath = URL(string: withURLString) else { return print("ERROR")}
        
        let task = URLSession.shared.dataTask(with: posterPath) { data, response, error in
            
            if error != nil {
                print("Error poster: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard data != nil else {
                print("Error poster: data not found")
                return
            }
            
            DispatchQueue.main.async {
                completion(UIImage(data: data!)!)
            }
        }
        task.resume()
    }
    
}
   
