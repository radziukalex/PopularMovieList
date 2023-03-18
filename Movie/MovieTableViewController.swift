//
//  ViewController.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    private let cellId = "mycell"
    private var movie = MovieNetworking()
    
    init (movie: MovieNetworking) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        title = "Popular movie"
        
        movie.getMovies { [weak self] result in
            switch result {
            case .succes(let popularMovie):
                self?.movie.moviesResult = popularMovie.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .error(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
//    @objc func tapToInformationController() {
//        let rootVC = InformationViewController()
//        navigationController?.pushViewController(rootVC, animated: true)
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.moviesResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        let item = movie.moviesResult[indexPath.row]
        let path = movie.moviesResult[indexPath.row].posterPath
        let imageURL = "https://image.tmdb.org/t/p/w300/" + path
        movie.getMovieImage(withURLString: imageURL) { (image) in
            cell.configure(overview: item.overview, title: item.originalTitle, poster: image)
//            cell.buttonMoreInformation.addTarget(self, action: #selector(self.tapToInformationController), for: .touchUpInside)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = movie.moviesResult[indexPath.row]
        let path = movie.moviesResult[indexPath.row].posterPath
        let imageURL = "https://image.tmdb.org/t/p/w500/" + path
        movie.getMovieImage(withURLString: imageURL) { (image) in
            let rootVC = InformationViewController(posterFromTable: image, movieOriginalTitleFromURL: item.originalTitle, movieOverviewFromURL: item.overview, voteAvarageFromURL: item.voteAverage)
            self.navigationController?.pushViewController(rootVC, animated: true)
        }
    }
}
