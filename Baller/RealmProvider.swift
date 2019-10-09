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

  init(config: Realm.Configuration) {
    self.configuration = config
  }

  var realm: Realm {
    do {
        return try Realm(configuration: configuration)
    } catch {
        fatalError("Failed to initialize Realm")
    }
  }

  // MARK: - Bundled Realm
//  private static let bundledConfig = Realm.Configuration(
//    fileURL: try! Path.inBundle("default.realm"),
//    readOnly: false,
//    objectTypes: [RealmAnswer.self])

//  public static var bundled: RealmProvider = {
//    return RealmProvider(config: bundledConfig)
//  }()

  // MARK: - Util

  /// Delete existing Realm files/folders

//    func removeFiles() throws {
//        guard let fileUrl = configuration.fileURL,
//            let files = FileManager.default.enumerator(at:
//    fileUrl.deletingLastPathComponent(), includingPropertiesForKeys: []),
//
//            let fileName = fileUrl.lastPathComponent.components(separatedBy: ".").first else {
//                return
//        }
//
//        for file in files.allObjects {
//            guard let url = file as? URL,
//                url.lastPathComponent.hasPrefix("\(fileName).") else { continue }
//            try FileManager.default.removeItem(at: url)
//        }
//    }
}
