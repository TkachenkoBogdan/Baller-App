//
//  SecureStorage.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/4/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol SecureStoring {
    func set(_ value: Int, forKey key: String)
    func value(forKey key: String) -> Int?

    func removeObject(forKey key: String)
}

class SecureStorage: SecureStoring {

    private let wrapper = KeychainWrapper.standard

    func set(_ value: Int, forKey key: String) {
        wrapper.set(value, forKey: key)
    }

    func value(forKey key: String) -> Int? {
        return wrapper.integer(forKey: key)
    }

    func removeObject(forKey key: String) {
        wrapper.removeObject(forKey: key)
    }
}
