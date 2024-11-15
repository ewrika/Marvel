//
//  PhotoViewModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 16.11.2024.
//

import Foundation
import UIKit

class PhotoViewModel {
    func loadImage(from url:URL) async -> UIImage? {
        return await ImageLoader.shared.loadImage(from: url)
    }
}
