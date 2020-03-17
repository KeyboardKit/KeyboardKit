//
//  PersistedKeyboardSetting.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-17.
//

import Foundation

/**
 This property wrapper can be used to store keyboard setting
 values to `UserDefaults`. You can use `KeyboardSetting`s or
 custom keys.
 */
@propertyWrapper
public struct PersistedKeyboardSetting<Value: Codable> {
    
    public init(
        _ setting: KeyboardSetting,
        default: Value,
        userDefaults: UserDefaults = .standard) {
        self.key = setting.key
        self.defaultValue = `default`
        self.userDefaults = userDefaults
    }
    
    public init(
        _ key: String,
        default: Value,
        userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = `default`
        self.userDefaults = userDefaults
    }
    
    private let key: String
    private let defaultValue: Value
    private let userDefaults: UserDefaults
    
    public var wrappedValue: Value {
        get {
            let persisted = userDefaults.object(forKey: key)
            return persisted as? Value ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
