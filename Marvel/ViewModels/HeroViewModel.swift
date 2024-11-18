//
//  HeroViewModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 18.11.2024.
//

import Foundation
import UIKit

class HeroViewModel {
    private(set) var heroes: [HeroModel] = heroList

    func hero(at index: Int) -> HeroModel {
        return heroes[index]
    }

    func loadImage(for hero: HeroModel) async -> UIImage? {
        guard let url = URL(string: hero.url) else { return nil }
        return await ImageLoader.shared.loadImage(from: url)
    }
}
