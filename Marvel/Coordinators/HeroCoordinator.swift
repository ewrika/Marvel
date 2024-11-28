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
        Task {
            let image = await ImageLoader.shared.loadImage(from: hero.imageURL ?? URL(string: "")!) ?? UIImage()
            DispatchQueue.main.async {
                detailedViewController.configure(
                    with: image,
                    name: hero.name,
                    description: hero.description
                )
                self.navigationController.pushViewController(detailedViewController, animated: true)
            }
        }
    }
}
