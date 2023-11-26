//
//  PopularMovie.swift
//  Movie
//
//  Created by Admin on 03.03.2023.
//

import Foundation
import RealmSwift

// MARK: - MovieJSON
struct MovieResult: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}

// MARK: - Result
struct MovieModel: Codable {
    
    let backdropPath: String?
    let id: Int
    let overview: String
    let originalTitle: String
    let posterPath: String
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        
        case backdropPath = "backdrop_path"
        case id
        case overview
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        
    }
}

extension MovieModel: DataBaseRecord {
    func transformToMovieObject() -> Object {
        return MovieObject(backdropPath: backdropPath, id: id, overview: overview, originalTitle: originalTitle, posterPath: posterPath, title: title, voteAverage: voteAverage)
    }
}
