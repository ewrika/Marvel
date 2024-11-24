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

    func showDetails(for hero: HeroModel) {
        let detailedViewController = DetailedViewController()
        detailedViewController.configure(
            with: UIImage(named: hero.imageURL) ?? UIImage(),
            name: hero.name,
            description: hero.description
        )
        navigationController.pushViewController(detailedViewController, animated: true)
    }
}
