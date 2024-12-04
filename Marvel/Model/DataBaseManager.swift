//
//  DataBaseManager.swift
//  Marvel
//
//  Created by Георгий Борисов on 04.12.2024.
//

import Foundation
import RealmSwift

class RealmBaseManager {
    private let realm = try? Realm()
    // SAVE HERO
    func saveHero(hero: RealmHeroListModel) {
        guard let realm = realm else {
            print("Fail realm")
            return
        }

        do {
            try realm.write {
                realm.add(hero, update: .modified)
            }
            print("Hero saved successfully!")
        } catch {
            print("Error saving hero: \(error)")
        }
    }

    // GET HERO BY ID
    func getHeroById(id: Int) -> RealmHeroListModel? {
        guard let realm = realm else {
            print("fail realm")
            return nil
        }

        return realm.object(ofType: RealmHeroListModel.self, forPrimaryKey: id)
    }

    // GET HEROES
    func getAllHeroes() -> [HeroModel] {
        guard let realm = realm else {
            print("Failed to initialize Realm")
            return []
        }

        let realmHeroes = realm.objects(RealmHeroListModel.self)

        let heroes = realmHeroes.compactMap { realmHero -> HeroModel? in
            guard let thumbnail = parseThumbnail(from: realmHero.thumbnail) else {
                print("Failed to parse thumbnail for hero \(realmHero.name)")
                return nil
            }
            return HeroModel(
                id: realmHero.heroID,
                name: realmHero.name,
                description: realmHero.descript,
                thumbnail: thumbnail
            )
        }
        return Array(heroes)
    }
}
    // Helper method to parse the Thumbnail object from a string
    private func parseThumbnail(from thumbnailString: String) -> Thumbnail? {
        let components = thumbnailString.split(separator: ".")
        guard components.count >= 2 else { return nil }
        let path = components.dropLast().joined(separator: ".")
        let ext = components.last?.description ?? ""
        return Thumbnail(path: path, extension: ext)
    }
