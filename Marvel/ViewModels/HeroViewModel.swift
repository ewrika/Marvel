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
    var onStateChanged: ((HeroViewController.ViewState) -> Void)?

    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func hero(at index: Int) -> HeroModel {
        return heroes[index]
    }

    func loadHeroes() {
        onStateChanged?(.loading)
        networkManager.fetchCharacters { [weak self] result in
            switch result {
            case .success(let fetchedHeroes):
                print("Answer from server: \(fetchedHeroes.count) heroes")
                self?.heroes.append(contentsOf: fetchedHeroes)
                DispatchQueue.main.async {
                    self?.onHeroesUpdated?()
                    if InternetObserver.shared.isConnected == false {
                        self?.onStateChanged?(.offline)
                    } else {
                        self?.onStateChanged?(.loaded)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error)
                    self?.onStateChanged?(.error)
                }
            }
        }
    }

    func loadImage(for hero: HeroModel) async -> UIImage? {
        guard let url = hero.imageURL else {
            print("Failed to load image for \(hero.name)")
            return Constants.Photo.placeHolder
        }
        return await ImageLoader.shared.loadImage(from: url)
    }
}
