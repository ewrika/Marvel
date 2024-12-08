//
//  HeroCoordinator.swift
//  Marvel
//
//  Created by Георгий Борисов on 18.11.2024.
//

import Foundation
import UIKit

class HeroCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = HeroViewModel()
        let heroViewController = HeroViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(heroViewController, animated: true)
    }

}
