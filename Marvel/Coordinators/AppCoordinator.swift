//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Георгий Борисов on 18.11.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let heroCoordinator = HeroCoordinator(navigationController: navigationController)
        heroCoordinator.start()
    }
}
