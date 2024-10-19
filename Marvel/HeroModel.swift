//
//  HeroModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 20.10.2024.
//

import Foundation

struct HeroModel{
    var image: String
    var name : String
    var color : String
}


let HeroList : [HeroModel] = [ 
HeroModel(image: "deadpool", name: "Deadpool", color: "DeadPool"),
HeroModel(image: "starman", name: "Iron Man", color: "StarMan"),
HeroModel(image: "webman", name: "Spider Man", color: "SpiderMan")
]
