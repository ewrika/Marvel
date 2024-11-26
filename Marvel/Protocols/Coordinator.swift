//
//  Coordinator.swift
//  Marvel
//
//  Created by Георгий Борисов on 18.11.2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
