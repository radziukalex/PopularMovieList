//
//  InformationViewController.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import UIKit

class InformationViewController: UIViewController, UINavigationBarDelegate {

    private var posterFromTable = UIImage()
    private var movieOriginalTitleFromURL = String()
    private var movieOverviewFromURL = String()
    private var voteAvarageFromURL = Double()
    
    
    init (posterFromTable: UIImage, movieOriginalTitleFromURL: String, movieOverviewFromURL: String, voteAvarageFromURL: Double) {
        self.posterFromTable = posterFromTable
        self.movieOriginalTitleFromURL = movieOriginalTitleFromURL
        self.movieOverviewFromURL = movieOverviewFromURL
        self.voteAvarageFromURL = voteAvarageFromURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        setupNavBar()
        setupUI()
    }
    
    lazy var navBar = UINavigationBar()
    
    func setupNavBar() {
        view.addSubview(navBar)
        navigationController?.navigationBar.tintColor = .black
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -800).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBar.backgroundColor = .systemGray
    }
    
    func setupUI() {
        let posterPath = UIImageView()
        let movieOriginalTitle = UILabel()
        let movieOverview = UILabel()
        let voteAverage = UILabel()
        
        view.addSubview(posterPath)
        view.addSubview(movieOriginalTitle)
        view.addSubview(movieOverview)
        view.addSubview(voteAverage)
        
        posterPath.translatesAutoresizingMaskIntoConstraints = false
        movieOriginalTitle.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        voteAverage.translatesAutoresizingMaskIntoConstraints = false
        
        posterPath.contentMode = .scaleAspectFit
        posterPath.layer.masksToBounds = true
        posterPath.layer.cornerRadius = 30
        posterPath.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        posterPath.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        posterPath.heightAnchor.constraint(equalToConstant: 400).isActive = true
        posterPath.widthAnchor.constraint(equalToConstant: 267).isActive = true
        posterPath.image = posterFromTable
        
        voteAverage.textColor = .white
        voteAverage.font = UIFont.boldSystemFont(ofSize: 16)
        voteAverage.textAlignment = .center
        voteAverage.topAnchor.constraint(equalTo: posterPath.topAnchor, constant: 10).isActive = true
        voteAverage.centerXAnchor.constraint(equalTo: posterPath.centerXAnchor, constant: 100).isActive = true
        voteAverage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        voteAverage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        voteAverage.backgroundColor = .systemMint
        voteAverage.text = String(voteAvarageFromURL)
        voteAverage.layer.masksToBounds = true
        voteAverage.layer.cornerRadius = 10
        
        movieOriginalTitle.textColor = .black
        movieOriginalTitle.font = UIFont.systemFont(ofSize: 28)
        movieOriginalTitle.textAlignment = .center
        movieOriginalTitle.topAnchor.constraint(equalTo: posterPath.bottomAnchor, constant: 20).isActive = true
        movieOriginalTitle.centerXAnchor.constraint(equalTo: posterPath.centerXAnchor).isActive = true
        movieOriginalTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        movieOriginalTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        movieOriginalTitle.numberOfLines = 0
        movieOriginalTitle.text = movieOriginalTitleFromURL
        
        movieOverview.textColor = .black
        movieOverview.font = UIFont.systemFont(ofSize: 16)
        movieOverview.textAlignment = .justified
        movieOverview.topAnchor.constraint(equalTo: movieOriginalTitle.bottomAnchor, constant: 10).isActive = true
        movieOverview.centerXAnchor.constraint(equalTo: posterPath.centerXAnchor).isActive = true
        movieOverview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        movieOverview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        movieOverview.numberOfLines = 0
        movieOverview.text = movieOverviewFromURL
        
    }
    
}



