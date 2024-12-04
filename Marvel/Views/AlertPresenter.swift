//
//  AlertPresenter.swift
//  Marvel
//
//  Created by Георгий Борисов on 04.12.2024.
//

import Foundation
import UIKit

final class AlertPresenter {
    static func showError(
        on viewController: UIViewController,
        title: String = "Произошла ошибка",
        message: String = "Попробуйте повторить попытку позже."
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
}
