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
HeroModel(image: "deadpool", name: "Deadpool", color: UIColor(red: 0.6, green: 0.08, blue: 0.09, alpha: 1.00)),
HeroModel(image: "starman", name: "Iron Man", color: UIColor(red: 0.36, green: 0.78, blue: 0.98, alpha: 1.0)),
HeroModel(image: "webman", name: "Spider Man", color: UIColor(red: 0.29, green: 0.56, blue: 0.29, alpha: 1.0))
]
