//
//  CollectionViewCell.swift
//  Movie
//
//  Created by Admin on 06.10.2023.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    var movieModel: MovieModel? = nil
    
    private let movieOriginalTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let movieBackdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: MovieModel, imageloader: ImageLoaderProtocol) {
        self.movieModel = model
        self.movieOriginalTitle.text = model.title
        let path = model.posterPath
        let imageURL = "https://image.tmdb.org/t/p/w300/" + path
        imageloader.loadMovieImage(imagePath: imageURL, callBack: { [weak self] image in
            self?.movieBackdropImageView.image = image
        })
    }
    
    private func setupUI() {
        contentView.addSubview(movieBackdropImageView)
        contentView.addSubview(movieOriginalTitle)
        
        movieBackdropImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        movieOriginalTitle.snp.makeConstraints {
            $0.top.equalTo(movieBackdropImageView.snp.bottom).inset(-10)
            $0.centerX.equalTo(movieBackdropImageView.snp.centerX)
            $0.right.equalTo(movieBackdropImageView.snp.right)
        }
    }
}
