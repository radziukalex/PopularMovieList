//
//  MovieManagedObject.swift
//  Movie
//
//  Created by Admin on 08.04.2023.
//

import Foundation
import CoreData

// TODO: rename to MovieManagedObject

@objc(Movie)
public class Movie: NSManagedObject {}

extension Movie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    
    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int64
    @NSManaged public var originalTitle: String
    @NSManaged public var overview: String
    @NSManaged public var posterURL: String
    @NSManaged public var title: String
    @NSManaged public var voteAverage: Double
    
}

extension Movie : Identifiable { }

extension Movie {
    func transformToMovieModel() -> MovieModel {
        return MovieModel(backdropPath: backdropPath, id: Int(id), overview: overview, originalTitle: originalTitle, posterPath: posterURL, title: title, voteAverage: voteAverage)
    }
}
