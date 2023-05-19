//
//  CustomTableViewCell.swift
//  Movie
//
//  Created by Admin on 05.03.2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var movieModel: MovieModel? = nil
    
    private let movieOriginalTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let movieOverview: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .justified
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let buttonMoreInformation: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    let movieBackdropPath: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .clear
        imgView.clipsToBounds = true
//        imgView.layer.cornerRadius = 10
        return imgView
    }()
    
    var openMovieCompletion: ((MovieModel) -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        
    }
    
    func configure(
        model: MovieModel,
        loadImage: @escaping ((String, @escaping (UIImage?) -> Void) -> Void)
    ) {
        self.movieModel = model
        self.movieOverview.text = model.overview
        self.movieOriginalTitle.text = model.title
        let path = model.posterPath
        let imageURL = "https://image.tmdb.org/t/p/w300/" + path
        loadImage(imageURL) { [weak self] (image) in
            self?.movieBackdropPath.image = image
        }
    }
    
    func setupUI() {
        contentView.addSubview(movieBackdropPath)
        contentView.addSubview(movieOriginalTitle)
        contentView.addSubview(movieOverview)
        
        movieBackdropPath.translatesAutoresizingMaskIntoConstraints = false
        movieOriginalTitle.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        buttonMoreInformation.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        movieBackdropPath.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        movieBackdropPath.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        movieBackdropPath.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
//        movieBackdropPath.rightAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 80).isActive = true
        movieBackdropPath.heightAnchor.constraint(equalToConstant: 80).isActive = true
        movieBackdropPath.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        movieOriginalTitle.leftAnchor.constraint(equalTo: self.movieBackdropPath.rightAnchor, constant: 16).isActive = true
        movieOriginalTitle.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -50).isActive = true
        movieOriginalTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
//        movieOriginalTitle.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
//        movieOriginalTitle.widthAnchor.constraint(equalToConstant: 80).isActive = true
        movieOriginalTitle.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        movieOverview.leftAnchor.constraint(equalTo: self.movieBackdropPath.rightAnchor, constant: 16).isActive = true
        movieOverview.topAnchor.constraint(equalTo: self.movieOriginalTitle.bottomAnchor, constant: -5).isActive = true
        movieOverview.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20).isActive = true
        movieOverview.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        movieOverview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
//        movieOverview.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
