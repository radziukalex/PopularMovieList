//
//  AboutAppTutorialViewController.swift
//  Movie
//
//  Created by Admin on 12.05.2023.
//

import UIKit
import SnapKit

class AboutAppTutorialViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textAlignment = .center
        label.textColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension AboutAppTutorialViewController {
    private func setupUI() {
        self.view.addSubview(label)
        self.view.backgroundColor = .systemCyan
        self.label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(100)
        }
    }
}
