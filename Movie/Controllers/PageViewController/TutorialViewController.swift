//
//  TutorialViewController.swift
//  Movie
//
//  Created by Admin on 10.05.2023.
//

import Foundation
import UIKit

class TutorialViewController: UIPageViewController {
    
    private let tutorialArray: [UIViewController]
    
    init(viewControllers: [UIViewController]) {
        self.tutorialArray = viewControllers
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([tutorialArray[0]],
                                direction: .forward,
                                animated: true,
                                completion: nil)
        self.dataSource = self
        self.delegate = self
    }
}

extension TutorialViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = tutorialArray.firstIndex(of: viewController) {
            if index > 0 {
                return tutorialArray[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = tutorialArray.firstIndex(of: viewController) {
            if index < tutorialArray.count - 1 {
                return tutorialArray[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return tutorialArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
