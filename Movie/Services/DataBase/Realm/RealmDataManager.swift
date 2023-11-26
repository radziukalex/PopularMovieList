//
//  RealmDataManager.swift
//  Movie
//
//  Created by Admin on 20.10.2023.
//

import RealmSwift

class RealmDataManager: DataBaseProtocol {
    
    private lazy var realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }()
    
    func saveRecord<T>(_ record: T) where T : Object {
        do {
            try realm.write {
                realm.add(record)
            }
        } catch {
            print("error")
        }
    }
    
    func saveMovie<T>(with model: T) where T : DataBaseRecord {
        let movieObject = model.transformToMovieObject()
        saveRecord(movieObject)
    }
    
    func getRecords<T>() -> [T] where T : DataBaseRecord {
        let objects: [MovieObject] = getObjects()
        return objects.compactMap { $0.transformToMovieModel() as? T }
    }
    
    private func getObjects<T: Object>() -> [T] {
        let objects = realm.objects(T.self)
        return objects.map { $0 }
    }
    
    func removeAll() {
        if let realm = try? Realm() {
            try? realm.write({
                realm.deleteAll()
            })
        }
    }
}
