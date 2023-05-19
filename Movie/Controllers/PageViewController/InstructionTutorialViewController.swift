//
//  InstructionTutorialViewController.swift
//  Movie
//
//  Created by Admin on 12.05.2023.
//

import UIKit

class InstructionTutorialViewController: UIViewController {
    
    let successCallBack: () -> Void
    
    init(successCallBack: @escaping () -> Void) {
        self.successCallBack = successCallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bottonToApp: UIButton = {
        let button = UIButton()
        button.setTitle("Tap to start", for: .normal)
        button.addTarget(self, action: #selector(tapToButton), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func tapToButton() {
        successCallBack()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(bottonToApp)
        bottonToApp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottonToApp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
