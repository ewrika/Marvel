//
//  HeroViewModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 18.11.2024.
//

import Foundation
import UIKit

class HeroViewModel {
    private(set) var heroes: [HeroModel] = []
    private let networkManager: NetworkManager
    
    var onHeroesUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func hero(at index: Int) -> HeroModel {
        return heroes[index]
    }
    
    func loadHeroes() {
        networkManager.fetchCharacters { [weak self] result in
            switch result {
            case .success(let fetchedHeroes):
                print("Ответ получен: \(fetchedHeroes.count) героев")
                self?.heroes = fetchedHeroes
                DispatchQueue.main.async {
                    self?.onHeroesUpdated?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error)
                }
            }
        }
    }
    
    func loadImage(for hero: HeroModel) async -> UIImage? {
        guard let url = URL(string: hero.imageURL) else { return nil }
        return await ImageLoader.shared.loadImage(from: url)
    }
}
