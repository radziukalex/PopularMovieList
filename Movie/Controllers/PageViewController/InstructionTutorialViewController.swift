//
//  InstructionTutorialViewController.swift
//  Movie
//
//  Created by Admin on 12.05.2023.
//

import UIKit
import SnapKit

class InstructionTutorialViewController: UIViewController {
    
    let successCallBack: () -> Void
    
    init(successCallBack: @escaping () -> Void) {
        self.successCallBack = successCallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private var buttonToApp: UIButton = {
        let button = UIButton()
        button.setTitle("Tap to start", for: .normal)
        button.addTarget(self, action: #selector(tapToButton), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func tapToButton() {
        successCallBack()
    }
}

extension InstructionTutorialViewController {
    
    private func setupUI() {
        self.view.addSubview(buttonToApp)
        self.view.backgroundColor = .systemRed
        buttonToApp.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
    }
}
