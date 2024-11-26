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
    let description: String
    let url: String
}

let heroList: [HeroModel] = [
    HeroModel(image: "deadpool", name: "Deadpool", description: "Please don’t make the super suit green...or animated!", url: "https://iili.io/JMnAfIV.png"),
    HeroModel(image: "starman", name: "Iron Man", description: "I AM IRON MAN", url: "https://iili.io/JMnuDI2.png"),
    HeroModel(image: "webman", name: "Spider Man", description: "In iron suit", url: "https://iili.io/JMnuyB9.png")
]
