//
//  MigrationManager.swift
//  Baller
//
//  Created by Богдан Ткаченко on 15.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RealmSwift

struct MigrationManager {

    private let answerType = String(describing: RealmAnswer.self)

    // MARK: - Public:

    func migrationBlock(migration: Migration, oldVersion: UInt64) {
        if oldVersion < 1 {
            migrateFrom0To1(migration)
        }
        if oldVersion < 2 {
            migrateFrom1to2(migration)
        }
        if oldVersion < 3 {
            migrateFrom2to3(migration)
        }
    }

    // MARK: - Private:

    private func migrateFrom0To1(_ migration: Migration) {
        debugPrint(L10n.Migration.from0to1)

        migration.renameProperty(onType: answerType,
                                 from: "title",
                                 to: RealmAnswer.Property.text.rawValue)
    }

    private func migrateFrom1to2(_ migration: Migration) {
        debugPrint(L10n.Migration.from1to2)

        migration.enumerateObjects(ofType: answerType) { _, newObject in

            guard let newObject = newObject,
                let oldText = newObject[RealmAnswer.Property.text.rawValue] as? String
                else { return }

            newObject[RealmAnswer.Property.text.rawValue] = "\(oldText).."
        }
    }

    private func migrateFrom2to3(_ migration: Migration) {
        debugPrint(L10n.Migration.from2to3)

        migration.enumerateObjects(ofType: answerType) { _, newObject in

            guard let newObject = newObject else { return }
            newObject[RealmAnswer.Property.date.rawValue] = Date()
        }
    }
}
