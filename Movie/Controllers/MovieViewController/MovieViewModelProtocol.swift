//
//  MovieViewModelProtocol.swift
//  Movie
//
//  Created by Admin on 16.10.2023.
//

import Foundation

protocol MovieViewModelProtocol {
    
    var movieModels: [MovieModel] { get }
    
    func setUp()
    
    func loadNextPage(completion: @escaping () -> Void)
    
    func loadMovieAM(pageNumber: Int, callBack: @escaping (Result<Void, ApplicationError>) -> Void)
    
}
