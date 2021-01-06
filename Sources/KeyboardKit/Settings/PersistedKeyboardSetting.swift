//
//  PersistedKeyboardSetting.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This property wrapper can be used to store keyboard setting
 values to `UserDefaults`.
 
 You can use a `KeyboardSetting` case or custom keys to wrap
 a property in this behavior.
 
 Note that this wrapper persists *objects*, not *values*. It
 can't be used for
 requires the setting to be codable.
 */
@propertyWrapper
public struct PersistedKeyboardSetting<Value: Codable> {
    
    public init(
        _ setting: KeyboardSetting,
        default defaultValue: Value,
        userDefaults: UserDefaults = .standard) {
        self.key = setting.key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    public init(
        key: String,
        default defaultValue: Value,
        userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    private let key: String
    private let defaultValue: Value
    private let userDefaults: UserDefaults
    
    public var wrappedValue: Value {
         get {
            let object = userDefaults.object(forKey: key)
            guard let data = object as? Data else { return defaultValue }
            let value = try? JSONDecoder().decode(Value.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: key)
        }
    }
}
