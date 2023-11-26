//
//  InformationViewController.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import UIKit
import SnapKit

class InformationViewController: UIViewController, UINavigationBarDelegate {
    
    private var posterFromTable = UIImage()
    private var movieOriginalTitleFromURL = String()
    private var movieOverviewFromURL = String()
    private var voteAverageFromURL = Double()
    
    lazy var navBar = UINavigationBar()
    
    init(posterFromTable: UIImage, movieOriginalTitleFromURL: String, movieOverviewFromURL: String, voteAverageFromURL: Double) {
        self.posterFromTable = posterFromTable
        self.movieOriginalTitleFromURL = movieOriginalTitleFromURL
        self.movieOverviewFromURL = movieOverviewFromURL
        self.voteAverageFromURL = voteAverageFromURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray2
        setupNavBar()
        setupUI()
    }
    
}

extension InformationViewController {
    
    private func setupUI() {
        let moviePoster = UIImageView()
        let movieTitle = UILabel()
        let movieOverview = UILabel()
        let voteAverage = UILabel()
        
        setupMoviePosterUI(poster: moviePoster)
        setupVoteAverageUI(average: voteAverage, poster: moviePoster)
        setupMovieTitleUI(title: movieTitle, poster: moviePoster)
        setupMovieOverviewUI(overview: movieOverview, title: movieTitle)
    }
    
    private func setupMoviePosterUI(poster: UIImageView) {
        self.view.addSubview(poster)
        poster.contentMode = .scaleAspectFit
        poster.layer.masksToBounds = true
        poster.layer.cornerRadius = 30
        poster.image = posterFromTable
        poster.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.width.equalTo(267)
            make.top.equalTo(self.view).inset(120)
            make.centerX.equalTo(self.view)
        }
    }
    
    private func setupVoteAverageUI(average: UILabel, poster: UIImageView) {
        self.view.addSubview(average)
        average.textColor = .systemBackground
        average.font = UIFont.boldSystemFont(ofSize: 18)
        average.textAlignment = .center
        average.backgroundColor = .systemOrange
        average.text = String(voteAverageFromURL)
        average.layer.masksToBounds = true
        average.layer.cornerRadius = 20
        average.snp.makeConstraints { make in
            make.top.equalTo(poster).inset(370)
            make.left.equalTo(poster).inset(-10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
    private func setupMovieTitleUI(title: UILabel, poster: UIImageView) {
        self.view.addSubview(title)
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 28)
        title.textAlignment = .center
        title.text = movieOriginalTitleFromURL
        title.numberOfLines = 1
        title.text = movieOriginalTitleFromURL
        title.snp.makeConstraints { make in
            make.top.equalTo(poster).inset(420)
            make.left.equalTo(self.view).inset(20)
            make.right.equalTo(self.view).inset(20)
        }
    }
    
    private func setupMovieOverviewUI(overview: UILabel, title: UILabel) {
        self.view.addSubview(overview)
        overview.textColor = .black
        overview.font = UIFont.systemFont(ofSize: 16)
        overview.textAlignment = .justified
        overview.numberOfLines = 0
        overview.text = movieOverviewFromURL
        overview.snp.makeConstraints { make in
            make.top.equalTo(title).inset(40)
            make.left.equalTo(self.view).inset(20)
            make.right.equalTo(self.view).inset(20)
        }
    }
    
    private func setupNavBar() {
        self.view.addSubview(navBar)
        navigationController?.navigationBar.tintColor = .black
        navBar.backgroundColor = .systemGray
        navBar.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(810)
            $0.top.equalToSuperview()
        }
    }
}
