//
//  DataBaseProtocol.swift
//  Movie
//
//  Created by Admin on 15.04.2023.
//

import Foundation

protocol DataBaseRecord {
    
}

protocol DataBaseProtocol {
    
    func saveMovie(with model: MovieModel)
    
    func fetchMovies() -> [Movie]
    
    func getRecords() -> [DataBaseRecord]
    
    func saveRecord(_ record: DataBaseRecord)
}

extension DataBaseProtocol {
    
    func getRecords() -> [DataBaseRecord] {
        return []
    }
    
    func saveRecord(_ record: DataBaseRecord) {
        
    }
}
