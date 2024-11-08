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
}

let heroList: [HeroModel] = [
    HeroModel(image: "deadpool", name: "Deadpool", description: "Please don’t make the super suit green...or animated!"),
    HeroModel(image: "starman", name: "Iron Man", description: "I AM IRON MAN"),
    HeroModel(image: "webman", name: "Spider Man", description: "In iron suit")
]
