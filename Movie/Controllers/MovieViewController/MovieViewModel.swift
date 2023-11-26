//
//  MovieViewModel.swift
//  Movie
//
//  Created by Admin on 15.04.2023.
//

import UIKit

class MovieViewModel: MovieViewModelProtocol {
    
    private let networking: MovieNetworking
    private let dataBase: DataBaseProtocol
    private let pageIncrementation = 1
    private var currentPage = 0
    private var maxPageCount = 0
    private var isLoading = false
    
    var movieModels: [MovieModel] = []
    
    init(networking: MovieNetworking, dataBase: DataBaseProtocol) {
        self.networking = networking
        self.dataBase = dataBase
    }
    
    func setUp() {
        self.movieModels = self.dataBase.getRecords()
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
        self.movieModels.append(contentsOf: newModels)
    }
    
    func loadMovieAM(pageNumber: Int, callBack: @escaping (Result<Void, ApplicationError>) -> Void) {
        guard isLoading == false else {
            return
        }
        isLoading = true
        self.networking.getMoviesAM(pageNumber: pageNumber) { [weak self] result in
            guard let self = self else {
                DispatchQueue.main.async {
                    callBack(.failure(ApplicationError.unowned))
                }
                return
            }
            switch result {
            case .succes(let popularMovie):
                self.setNewMovieModels(models: popularMovie.results)
                self.currentPage = popularMovie.page
                self.maxPageCount = popularMovie.totalPages
                DispatchQueue.main.async {
                    callBack(.success(()))
                }
            case .error(let error):
                DispatchQueue.main.async {
                    callBack(.failure(.network(.error(error))))
                }
            }
            self.isLoading = false
        }
    }
    
    func loadNextPage(completion: @escaping () -> Void) {
        let nextPage = currentPage + pageIncrementation
        if nextPage < maxPageCount {
            loadMovieAM(pageNumber: nextPage) { result in
                switch result {
                case .success:
                    print("Items loaded")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion()
            }
        } else {
            completion()
        }
    }
    
    func loadMovieImage(url: String, callBack: @escaping (UIImage?) -> Void) {
        self.networking.getMovieImageAM(imagePath: url, completion: callBack)
    }
}
