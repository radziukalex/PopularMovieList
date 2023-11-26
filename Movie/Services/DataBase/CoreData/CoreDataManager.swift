//
//  CoreDataManager.swift
//  Movie
//
//  Created by Admin on 05.04.2023.
//

import Foundation
import CoreData
import UIKit
import RealmSwift

final class CoreDatManager: DataBaseProtocol {
    
    func saveRecord<T>(_ record: T) where T : Object {
        print("aa")
    }
    
    func saveMovie<T>(with model: T) where T : DataBaseRecord {
        print("dd")
    }
    
    func getRecords<T>() -> [T] where T : DataBaseRecord {
        return []
    }
    
    func removeAll() {
        print("ds")
    }
    
    //Получение доступа к области памяти
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("error")
            }
        })
        return container
    }()
    
    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveMovie(with model: MovieModel) {
        let context = persistentContainer.viewContext
        //Создаем описание объекта
        guard let movieEntityDescription = NSEntityDescription.entity(forEntityName: "Movie", in: context) else {
            return
        }
        //Создаем сам объект
        let managedObject = Movie(entity: movieEntityDescription, insertInto: context)
        managedObject.overview = model.overview
        managedObject.title = model.title
        managedObject.id = Int64(model.id)
        managedObject.originalTitle = model.originalTitle
        managedObject.backdropPath = model.backdropPath
        managedObject.posterURL = model.posterPath
        managedObject.voteAverage = model.voteAverage
        saveContext(context: context)
    }
    
    func fetchMovies() -> [MovieModel] {
        return fetchMovies(context: persistentContainer.viewContext).map { $0.transformToMovieModel() }

    }
    
    func fetchMovies(context: NSManagedObjectContext) -> [Movie] {
        //СОздаем запрос к базе данных, который получит все объекты с типом Movie
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do {
            return try context.fetch(fetchRequest) as! [Movie]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deleteAllMovies(context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do {
            let movies = try? context.fetch(fetchRequest) as? [Movie]
            movies?.forEach { context.delete($0) }
        }
        saveContext(context: context)
    }
}







