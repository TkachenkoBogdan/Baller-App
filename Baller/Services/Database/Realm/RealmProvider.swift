//
//  BallView.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/8/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider {

    private let configuration: Realm.Configuration
    private let migrationManager: MigrationManager

    // MARK: - Init:

    init(configuration: Realm.Configuration, migrationManager: MigrationManager) {
        self.configuration = configuration
        self.migrationManager = migrationManager
        setupRealm()
    }

    // MARK: - Public:

    var realm: Realm {
        do {
            return try Realm(configuration: configuration)
        } catch {
            fatalError(L10n.FatalErrors.Realm.failedToInitialize)
        }
    }

    // MARK: - Private:

    private func setupRealm() {

        if !AnswersRealm.main.fileExists {
            try? FileManager.default.copyItem(
                at: AnswersRealm.bundle.url, to: AnswersRealm.main.url)
        }
    }

    enum AnswersRealm {

        case bundle
        case main

        var url: URL {
            do {
                switch self {
                case .main: return try Path.inDocuments(L10n.Filenames.Realm.main)
                case .bundle: return try Path.inBundle(L10n.Filenames.Realm.bundled)

                }
            } catch let error {
                fatalError("\(L10n.FatalErrors.failedToFindPath) + \(error)")
            }
        }

        var fileExists: Bool {
            return FileManager.default.fileExists(atPath: path)
        }

        var path: String {
            return url.path
        }
    }
}

// MARK: - Default Provider:

extension RealmProvider {

    public static let `default`: RealmProvider = {
        return RealmProvider(configuration: defaultConfiguration, migrationManager: defaultMigrationManager)
    }()

    private static let defaultConfiguration = Realm.Configuration(
        fileURL: try? Path.inDocuments(L10n.Filenames.Realm.main),
        schemaVersion: AppConstants.appModelVersion,
        migrationBlock: defaultMigrationManager.migrationBlock,
        objectTypes: [RealmAnswer.self])

    private static let defaultMigrationManager = MigrationManager()
}
