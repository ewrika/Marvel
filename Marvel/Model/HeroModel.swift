//
//  HeroModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 20.10.2024.
//

import Foundation
import UIKit

struct HeroModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail

    var imageURL: String {
        return thumbnail.fullPath
    }
}

struct Thumbnail: Decodable {
    let path: String
    let `extension`: String

    var fullPath: String {
        return "\(path).\(self.extension)"
    }
}
