//
//  SceneDelegate.swift
//  Movie
//
//  Created by Admin on 26.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
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
        let coreData = CoreDatManager()
        let model = MovieViewModel(networking: networking, dataBase: coreData)
        return TabBarController(model: model)
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
