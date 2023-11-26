//
//  ProfileViewController.swift
//  Movie
//
//  Created by Admin on 08.05.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    var movieViewModel: MovieViewModelProtocol
    private let imageLoader: ImageLoaderProtocol
    private let favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let profilePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .blue
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 70
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 1
        label.text = "Aliaksandr"
        return label
    }()
    
    private let favoritesMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Favorite movies"
        return label
    }()

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
        setupCollectionViewUI()
        setupUI()
    }
}

extension ProfileViewController {
    
    private func setupCollectionViewUI() {
        view.backgroundColor = .black
        favoritesCollectionView.contentInsetAdjustmentBehavior = .never
        favoritesCollectionView.showsHorizontalScrollIndicator = false
        favoritesCollectionView.showsVerticalScrollIndicator = false
        favoritesCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
        view.addSubview(favoritesCollectionView)
        favoritesCollectionView.backgroundColor = .black
        favoritesCollectionView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(200)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        let layout = favoritesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        view.addSubview(favoritesMovieLabel)
        favoritesMovieLabel.snp.makeConstraints {
            $0.bottom.equalTo(favoritesCollectionView.snp.top).inset(10)
            $0.left.equalTo(view.snp.left).inset(10)
        }
        
    }
    
    private func setupUI() {
        view.addSubview(profilePhoto)
        view.addSubview(profileName)
        
        profilePhoto.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(100)
            $0.height.equalTo(140)
            $0.width.equalTo(140)
        }
        
        profileName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profilePhoto.snp_bottomMargin).inset(-20)
        }
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieViewModel.movieModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let item = self.movieViewModel.movieModels[indexPath.row]
        cell.configure(model: item, imageloader: imageLoader)
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(100), height: CGFloat(130))
    }
    
    
}
