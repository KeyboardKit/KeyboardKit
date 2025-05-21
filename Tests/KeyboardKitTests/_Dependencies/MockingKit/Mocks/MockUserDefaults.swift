//
//  MockReference.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2020-07-17.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This class can be used to mock `UserDefaults`.
open class MockUserDefaults: UserDefaults, Mockable {
    
    public lazy var boolRef = MockReference(bool)
    public lazy var arrayRef = MockReference(array)
    public lazy var dataRef = MockReference(data)
    public lazy var doubleRef = MockReference(double)
    public lazy var floatRef = MockReference(float)
    public lazy var integerRef = MockReference(integer)
    public lazy var objectRef = MockReference(object)
    public lazy var stringRef = MockReference(string)
    public lazy var stringArrayRef = MockReference(stringArray)
    public lazy var urlRef = MockReference(url)
    
    public lazy var setBoolRef = MockReference(set as (Bool, String) -> Void)
    public lazy var setDoubleRef = MockReference(set as (Double, String) -> Void)
    public lazy var setIntegerRef = MockReference(set as (Int, String) -> Void)
    public lazy var setFloatRef = MockReference(set as (Float, String) -> Void)
    public lazy var setUrlRef = MockReference(set as (URL?, String) -> Void)
    public lazy var setValueRef = MockReference(setValueWithInstance as (Any?, String) -> Void)
    
    public var mock = Mock()
    
    
    open override func array(forKey defaultName: String) -> [Any]? {
        mock.call(arrayRef, args: defaultName)
    }
    
    open override func bool(forKey defaultName: String) -> Bool {
        mock.call(boolRef, args: defaultName)
    }
    
    open override func data(forKey defaultName: String) -> Data? {
        mock.call(dataRef, args: defaultName)
    }
    
    open override func double(forKey defaultName: String) -> Double {
        mock.call(doubleRef, args: defaultName)
    }
    
    open override func float(forKey defaultName: String) -> Float {
        mock.call(floatRef, args: defaultName)
    }
    
    open override func integer(forKey defaultName: String) -> Int {
        mock.call(integerRef, args: defaultName)
    }
    
    open override func object(forKey defaultName: String) -> Any? {
        mock.call(objectRef, args: defaultName)
    }
    
    open override func string(forKey defaultName: String) -> String? {
        mock.call(stringRef, args: defaultName)
    }
    
    open override func stringArray(forKey defaultName: String) -> [String]? {
        mock.call(stringArrayRef, args: defaultName)
    }
    
    open override func url(forKey defaultName: String) -> URL? {
        mock.call(urlRef, args: defaultName)
    }
    
    open override func set(_ value: Bool, forKey defaultName: String) {
        mock.call(self.setBoolRef, args: (value, defaultName))
    }
    
    open override func set(_ value: Double, forKey defaultName: String) {
        mock.call(self.setDoubleRef, args: (value, defaultName))
    }
    
    open override func set(_ value: Float, forKey defaultName: String) {
        mock.call(self.setFloatRef, args: (value, defaultName))
    }
    
    open override func set(_ value: Int, forKey defaultName: String) {
        mock.call(self.setIntegerRef, args: (value, defaultName))
    }
    
    open override func set(_ url: URL?, forKey defaultName: String) {
        mock.call(self.setUrlRef, args: (url, defaultName))
    }
    
    open override func set(_ value: Any?, forKey defaultName: String) {
        setValueWithInstance(value, forKey: defaultName)
    }
    
    open override func setValue(_ value: Any?, forKey key: String) {
        setValueWithInstance(value, forKey: key)
    }
}

private extension MockUserDefaults {
    
    func setValueWithInstance(_ value: Any?, forKey key: String) {
        mock.call(self.setValueRef, args: (value, key))
    }
}
