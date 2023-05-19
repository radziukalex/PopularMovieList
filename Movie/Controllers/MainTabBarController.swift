//
//  MainTabBarController.swift
//  Movie
//
//  Created by Admin on 08.05.2023.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            
        ]
    }
    
    private func generateVC(VC: UIViewController, title: String, image: UIImage?) -> UIViewController {
        
        VC.tabBarItem.title = title
        VC.tabBarItem.image = image
        return VC
    }
}
