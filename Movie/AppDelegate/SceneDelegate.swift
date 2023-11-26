//
//  SceneDelegate.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var dateBase: DataBaseProtocol = CoreDatManager()
    private lazy var imageLoader: ImageLoaderProtocol = ImageLoader(networking: MovieNetworking())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        if UserDefaults.standard.bool(forKey: "tutorial_shown") == true {
            self.window?.rootViewController = makeMainFlow()
        } else {
            self.window?.rootViewController = makeTutorialFlow()
        }
        window?.makeKeyAndVisible()
    }
}

private extension SceneDelegate {
    func makeMainFlow() -> UIViewController {
        let networking = MovieNetworking()
        let model = MovieViewModel(networking: networking, dataBase: dateBase)
        return TabBarController(model: model, imageLoader: imageLoader)
    }
    
    func makeTutorialFlow() -> UIViewController {
        let aboutApp = AboutAppTutorialViewController()
        let instructionApp = InstructionTutorialViewController { [weak self] in
            self?.window?.rootViewController = self?.makeMainFlow()
            UserDefaults.standard.set(true, forKey: "tutorial_shown")
        }
        return TutorialViewController(viewControllers: [aboutApp, instructionApp])
    }
    
}
