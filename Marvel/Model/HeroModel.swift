//
//  HeroModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 20.10.2024.
//

import Foundation
import UIKit

struct HeroModel{
    var image: String
    var name : String
    var color : UIColor
}


let HeroList : [HeroModel] = [ 
    HeroModel(image: "deadpool", name: "Deadpool", color: Constants.deadPool),
    HeroModel(image: "starman", name: "Iron Man",  color:Constants.ironMan),
    HeroModel(image: "webman", name: "Spider Man", color: Constants.spiderMan)
]
