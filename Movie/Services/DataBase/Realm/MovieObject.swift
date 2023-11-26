//
//  MovieObject.swift
//  Movie
//
//  Created by Admin on 29.04.2023.
//

import RealmSwift


class MovieObject: Object {

    dynamic var backdropPath: String? = ""
    dynamic var id: Int = 0
    dynamic var overview: String = ""
    dynamic var originalTitle: String = ""
    dynamic var posterPath: String = ""
    dynamic var title: String = ""
    dynamic var voteAverage: Double = 0.0
    
    convenience init(backdropPath: String?, id: Int, overview: String, originalTitle: String, posterPath: String, title: String, voteAverage: Double) {
        self.init()
        self.backdropPath = backdropPath
        self.id = id
        self.overview = overview
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.title = title
        self.voteAverage = voteAverage
    }
    
}

extension MovieObject {
    func transformToMovieModel() -> MovieModel {
        return MovieModel(backdropPath: backdropPath, id: id, overview: overview, originalTitle: originalTitle, posterPath: posterPath, title: title, voteAverage: voteAverage)
    }
}
