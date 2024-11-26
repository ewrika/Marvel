//
//  HeroModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 20.10.2024.
//

import Foundation
import UIKit

struct HeroModel {
    let image: String
    let name: String
}

let heroList: [HeroModel] = [
    HeroModel(image: "deadpool", name: "Deadpool"),
    HeroModel(image: "starman", name: "Iron Man"),
    HeroModel(image: "webman", name: "Spider Man")
]
