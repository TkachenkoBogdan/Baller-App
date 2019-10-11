//
//  BallView.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/8/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmProvider {

    private let configuration: Realm.Configuration

    // MARK: - Init:

    init(config: Realm.Configuration) {
        self.configuration = config
        setupRealm()
    }

    var realm: Realm {
        do {
            return try Realm(configuration: configuration)
        } catch {
            fatalError(L10n.FatalErrors.Realm.failedToInitialize)
        }
    }

    // MARK: - Default Realm:

    public static var `default`: RealmProvider = {
        return RealmProvider(config: defaultConfiguration)
    }()

    private static var defaultConfiguration = Realm.Configuration(
        fileURL: try? Path.inDocuments(L10n.Filenames.Realm.main),
        readOnly: false,
        objectTypes: [RealmAnswer.self])

    private func setupRealm() {
        SyncManager.shared.logLevel = .off

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
