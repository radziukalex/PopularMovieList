//
//  CustomTableViewCell.swift
//  Movie
//
//  Created by Admin on 05.03.2023.
//

import Foundation
import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    var movieModel: MovieModel? = nil
    var taskLoadImage: URLSessionDataTask? = nil
    
    private let movieOriginalTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let movieOverview: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    private let movieBackdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favoriteMoviesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "star"), for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieBackdropImageView.image = nil
        self.taskLoadImage?.cancel()
        self.taskLoadImage = nil
    }
    
    func configure(model: MovieModel, imageLoader: ImageLoaderProtocol) {
        self.movieModel = model
        self.movieOverview.text = model.overview
        self.movieOriginalTitle.text = model.title
        let path = model.posterPath
        let imageURL = "https://image.tmdb.org/t/p/w300/" + path
        self.taskLoadImage = imageLoader.taskLoadMovieImage(imagePath: imageURL) { [weak self] image in
            self?.movieBackdropImageView.image = image
        }
        self.taskLoadImage?.resume()
    }
    
    private func setupUI() {
        contentView.addSubview(movieBackdropImageView)
        contentView.addSubview(movieOriginalTitle)
        contentView.addSubview(movieOverview)
        contentView.addSubview(favoriteMoviesButton)
        
        movieBackdropImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(-100)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        movieOriginalTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.equalTo(movieBackdropImageView).inset(200)
            $0.right.equalToSuperview().inset(15)
        }
        
        movieOverview.snp.makeConstraints {
            $0.top.equalTo(movieOriginalTitle).inset(20)
            $0.left.equalTo(movieBackdropImageView).inset(200)
            $0.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(300)
        }
        
        favoriteMoviesButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
