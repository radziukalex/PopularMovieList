//
//  ImageLoader.swift
//  Movie
//
//  Created by Admin on 04.10.2023.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func loadMovieImage(imagePath: String, callBack: @escaping (UIImage?) -> Void)
    
    func taskLoadMovieImage(imagePath: String, callBack: @escaping (UIImage?) -> Void) -> URLSessionDataTask?
}

class ImageLoader: ImageLoaderProtocol {

    private let networking: MovieNetworking
    private let imageURL = "https://image.tmdb.org/t/p/w300/"
    
    init(networking: MovieNetworking) {
        self.networking = networking
    }
    
    func loadMovieImage(imagePath: String, callBack: @escaping (UIImage?) -> Void) {
        self.networking.getMovieImageAM(imagePath: imagePath, completion: callBack)
    }
    
    func taskLoadMovieImage(imagePath: String, callBack: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        self.networking.taskLoadMovieImage(imagePath: imagePath, callBack: callBack)
    }
}
