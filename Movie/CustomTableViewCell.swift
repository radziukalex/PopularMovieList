//
//  CustomTableViewCell.swift
//  Movie
//
//  Created by Admin on 05.03.2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
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
        lbl.textAlignment = .left
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
        imgView.layer.cornerRadius = 10
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        
    }
    
    public func configure(overview: String, title: String, poster: UIImage) {
        self.movieOverview.text = overview
        self.movieOriginalTitle.text = title
        self.movieBackdropPath.image = poster
    }
    
    func setupUI() {
//        self.contentView.addSubview(movieOriginalTitle)
        contentView.addSubview(movieBackdropPath)
        contentView.addSubview(movieOriginalTitle)
        contentView.addSubview(movieOverview)
        contentView.addSubview(buttonMoreInformation)
        
        movieBackdropPath.translatesAutoresizingMaskIntoConstraints = false
        movieOriginalTitle.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        buttonMoreInformation.translatesAutoresizingMaskIntoConstraints = false
    
        movieBackdropPath.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        movieBackdropPath.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        movieBackdropPath.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        movieBackdropPath.heightAnchor.constraint(equalToConstant: 80).isActive = true
        movieBackdropPath.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        movieOriginalTitle.leadingAnchor.constraint(equalTo: self.movieBackdropPath.trailingAnchor, constant: 16).isActive = true
        movieOriginalTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50).isActive = true
        movieOriginalTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        movieOriginalTitle.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        movieOverview.leadingAnchor.constraint(equalTo: self.movieBackdropPath.trailingAnchor, constant: 16).isActive = true
        movieOverview.topAnchor.constraint(equalTo: self.movieOriginalTitle.bottomAnchor, constant: 5).isActive = true
        movieOverview.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        movieOverview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        movieOverview.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        buttonMoreInformation.leadingAnchor.constraint(equalTo: movieOriginalTitle.trailingAnchor, constant: 10).isActive = true
        buttonMoreInformation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
        buttonMoreInformation.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
