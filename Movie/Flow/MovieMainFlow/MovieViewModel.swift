//
//  MovieViewModel.swift
//  Movie
//
//  Created by Admin on 15.04.2023.
//

import UIKit

protocol MovieViewModelProtocol {
    
    var movieModels: [MovieModel] { get }
    
    func setUp()
    
//    func loadMovie(callBack: @escaping (Result<Void, ApplicationError>) -> Void)
    
    func loadMovieAM(callBack: @escaping (Result<Void, ApplicationError>) -> Void)
    
    func loadMovieImage(url: String, callBack: @escaping (UIImage?) -> Void)
}

class MovieViewModel: MovieViewModelProtocol {
    
    private let networking: MovieNetworking
    private let dataBase: DataBaseProtocol
    var movieModels: [MovieModel] = []
    
    init(networking: MovieNetworking, dataBase: DataBaseProtocol) {
        self.networking = networking
        self.dataBase = dataBase
    }
    
    func setUp() {
//        movieModelsCoreData = dataBase.fetchMovies()
    }
    
    private func setNewMovieModels(models: [MovieModel]) {
        var newModels: [MovieModel] = []
        
        for newModel in models {
            var isExist = false
            for currentModel in movieModels {
                if !isExist, newModel.id == currentModel.id {
                    isExist = true
                }
            }
            if !isExist {
                newModels.append(newModel)
            }
        }
    }
    
    func loadMovieAM(callBack: @escaping (Result<Void, ApplicationError>) -> Void) {
        networking.getMoviesAM { [weak self] result in
            guard let self = self else {
                callBack(.failure(ApplicationError.unowned))
                return
            }
            switch result {
            case .succes(let popularMovie):
                self.movieModels = popularMovie.results
                DispatchQueue.main.async {
                    callBack(.success(()))
                    }
            case .error(let error):
                callBack(.failure(.network(.error(error))))
            }
        }
    }
    
    func loadMovieImage(url: String, callBack: @escaping (UIImage?) -> Void) {
        networking.getMovieImageAM(withURLString: url, completion: callBack)
    }
}


/*
func loadMovie(callBack: @escaping (Result<Void, ApplicationError>) -> Void) {
    networking.getMovies { [weak self] result in
        guard let self = self else {
            callBack(.failure(ApplicationError.unowned))
            return
        }
        switch result {
        case .succes(let popularMovie):
            self.movieModels = popularMovie.results
            DispatchQueue.main.async {
                popularMovie.results.forEach { model in
                    self.dataBase.saveMovie(with: model)
                }
                callBack(.success(()))
            }
        case .error(let error):
            DispatchQueue.main.async {
                
                callBack(.failure(.network(.error(error))))
            }
        }
    }
}*/
