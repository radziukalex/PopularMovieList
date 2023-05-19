//
//  ViewController.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import UIKit

class MovieViewController: UITableViewController {
    
    private let cellId = "mycell"
    private let movieViewModel: MovieViewModelProtocol
    
    init(movieViewModel: MovieViewModelProtocol) {
        self.movieViewModel = movieViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Home"
//        navigationController?.navigationBar.isHidden = true
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        
        movieViewModel.loadMovieAM { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movieModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        let item = movieViewModel.movieModels[indexPath.row]
        
        cell.configure(
            model: item,
            loadImage: { [weak self] imageURL, imageCompletion in
                self?.movieViewModel.loadMovieImage(url: imageURL, callBack: imageCompletion)
            })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = movieViewModel.movieModels[indexPath.row]
        let path = movieViewModel.movieModels[indexPath.row].posterPath
        let imageURL = "https://image.tmdb.org/t/p/w500/" + path
        movieViewModel.loadMovieImage(url: imageURL) { [weak self] (image) in
            guard let self = self, let image = image else {
                return
            }
            let rootVC = InformationViewController(posterFromTable: image, movieOriginalTitleFromURL: item.originalTitle, movieOverviewFromURL: item.overview, voteAvarageFromURL: item.voteAverage)
            self.navigationController?.pushViewController(rootVC, animated: true)
        }
    }
}
