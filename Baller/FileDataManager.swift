//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

/// A helper class responsible for performing disk-related operations.

enum Directory {
       case documents
       case caches
}

protocol FileDataManageable {
    func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String)
    func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T?
    func fileExists(_ fileName: String, in directory: Directory) -> Bool
    func pathInBundle(_ name: String) -> URL?
}

final class FileDataManager: FileDataManageable {

    /// Stores an encodable struct to the specified directory on a disk:
    func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
        let url = URL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    /// Retrieves and converts a struct from a file on a disk:
    func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        let url = URL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        if !FileManager.default.fileExists(atPath: url.path) {
            print("File at path \(url.path) does not exist!")
            return nil
        }

        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            print("No data at \(url.path)!")
            return nil
        }
    }

    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = URL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }

    /// Returns URL for a file name in main Bundle
    func pathInBundle(_ name: String) -> URL? {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            return nil
        }
        return url
    }

    /// Returns URL constructed from specified directory:
    private func URL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory

        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }

        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
}
