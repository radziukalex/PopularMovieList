//
//  TabBarController.swift
//  Movie
//
//  Created by Admin on 08.05.2023.
//

import Foundation
import UIKit

private enum TabBarItem: Int {
    case movie
    case settings
    case profile
    
    var title: String {
        switch self {
        case .movie:
            return "Home"
        case .profile:
            return "Profile"
        case.settings:
            return "Settings"
        }
    }
        
    var iconName: String {
        switch self {
        case .movie:
            return "house.fill"
        case .profile:
            return "person.fill"
        case .settings:
            return "slider.horizontal.3"
            }
        }
    }

class TabBarController: UITabBarController {
    
    let model: MovieViewModelProtocol
    
    init (model: MovieViewModelProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        
        let dataSource: [TabBarItem] = [.movie, .profile, .settings]
        
        self.viewControllers = dataSource.map {
            switch $0 {
            case .movie:
                let movieVC = MovieViewController(movieViewModel: model)
                return self.wrappedVC(with: movieVC, title: $0.title)
            case .profile:
                let profileVC = ProfileViewController()
                return self.wrappedVC(with: profileVC, title: $0.title)
            case .settings:
                let settingsVC = SettingsViewController()
                return self.wrappedVC(with: settingsVC, title: $0.title)
            }
        }
        
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }
    
    private func wrappedVC(with: UIViewController, title: String) -> UINavigationController {
        return UINavigationController(rootViewController: with)
    }
}
