//
//  RealmBase.swift
//  Marvel
//
//  Created by Георгий Борисов on 02.12.2024.
//

import Foundation
import RealmSwift

class RealmHeroListModel: Object {
    @Persisted(primaryKey: true) var heroID: Int
    @Persisted var name: String = ""
    @Persisted var descript: String = ""
    @Persisted var thumbnail: String = ""
    convenience init(id: Int, name: String, descript: String, thumbnail: String) {
        self.init()
        self.heroID = id
        self.name = name
        self.descript = descript
        self.thumbnail = thumbnail
    }
}

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
    func getAllHeroes() -> [RealmHeroListModel] {
        guard let realm = realm else {
            print("Failed to initialize Realm")
            return []
        }

        let heroes = realm.objects(RealmHeroListModel.self)
        return Array(heroes)
    }

}
