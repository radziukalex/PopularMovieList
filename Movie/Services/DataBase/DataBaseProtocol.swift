//
//  DataBaseProtocol.swift
//  Movie
//
//  Created by Admin on 15.04.2023.
//

import RealmSwift

protocol DataBaseRecord {
    
    func transformToMovieObject() -> Object
}

protocol DataBaseProtocol {
    
    func saveMovie<T>(with model: T) where T : DataBaseRecord
    
    func getRecords<T: DataBaseRecord>() -> [T]

    func saveRecord<T>(_ record: T) where T : Object

    func removeAll()
}
