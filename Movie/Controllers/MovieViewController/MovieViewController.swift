//
//  ViewController.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController {
    
    private let movieViewModel: MovieViewModelProtocol
    private let imageLoader: ImageLoaderProtocol
    private let tableView = UITableView()
    private let cellId = "mycell"
    private let startingPage = 1
    
    init(movieViewModel: MovieViewModelProtocol, imageLoader: ImageLoaderProtocol) {
        self.movieViewModel = movieViewModel
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        self.movieViewModel.loadMovieAM(pageNumber: startingPage) { [weak self] result in
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
    
    private func setupTableView() {
        self.view.backgroundColor = .white
        self.title = "Home"
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(self.view)
        }
        tableView.rowHeight = CGFloat(130)
        tableView.delegate = self
        tableView.dataSource = self
    }
 
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.movieViewModel.movieModels[indexPath.row]
        self.imageLoader.loadMovieImage(imagePath: item.posterPath) { [weak self] (image) in
            guard let self = self, let image = image else {
                return
            }
            let rootVC = InformationViewController(posterFromTable: image, movieOriginalTitleFromURL: item.originalTitle, movieOverviewFromURL: item.overview, voteAverageFromURL: item.voteAverage)
            self.navigationController?.pushViewController(rootVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieViewModel.movieModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        let item = self.movieViewModel.movieModels[indexPath.row]
        cell.configure(model: item, imageLoader: imageLoader)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            self.movieViewModel.loadNextPage(completion: { [weak self] in
                self?.tableView.reloadData()
            })
        }
    }
}
