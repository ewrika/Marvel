//
//  RealmDataBase.swift
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
