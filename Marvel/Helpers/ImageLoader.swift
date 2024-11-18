//
//  ImageLoader.swift
//  Marvel
//
//  Created by Георгий Борисов on 16.11.2024.
//

import Foundation
import UIKit
import Kingfisher

class ImageLoader {
    static let shared = ImageLoader()

    private init() {}

    func loadImage(from url: URL, placeholder: UIImage? = Constants.Photo.placeHolder) async -> UIImage? {
        return await withCheckedContinuation { continuation in
            let resource = KF.ImageResource(downloadURL: url)

            KingfisherManager.shared.retrieveImage(with: resource) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value.image)
                case .failure(let error):
                    print("Error loading image from \(url): \(error.localizedDescription)")
                    continuation.resume(returning: placeholder)
                }
            }
        }
    }
}
