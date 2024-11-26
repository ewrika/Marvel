//
//  Constants.swift
//  Marvel
//
//  Created by Георгий Борисов on 22.10.2024.
//

import Foundation
import UIKit

enum Constants {

    enum Color {
        static var backGround = UIColor(hex: "2B262B") ?? UIColor.black
    }

    enum Text {
        static let chooseHero = "Choose your hero"
    }

    enum Photo {
        static let marvelLogo = UIImage(named: "marvelLogo")
        static let arrowBack = UIImage(named: "arrowBack")
        static let placeHolder = UIImage(named:"placeholder")
    }

}
