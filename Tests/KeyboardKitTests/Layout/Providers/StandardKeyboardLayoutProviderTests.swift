//
//  StandardKeyboardLayoutProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class StandardKeyboardLayoutProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: StandardKeyboardLayoutProvider!
        var inputProvider: MockKeyboardInputSetProvider!
        var context: KeyboardContext!
        var device: MockDevice!
        
        beforeEach {
            device = MockDevice()
            context = KeyboardContext(device: device, controller: MockKeyboardInputViewController())
            inputProvider = MockKeyboardInputSetProvider()
            inputProvider.alphabeticInputSetValue = AlphabeticKeyboardInputSet(rows: KeyboardInputRows([["a", "b", "c"], ["a", "b", "c"], ["a", "b", "c"]]))
            inputProvider.numericInputSetValue = NumericKeyboardInputSet(rows: KeyboardInputRows([["1", "2", "3"], ["1", "2", "3"], ["1", "2", "3"]]))
            inputProvider.symbolicInputSetValue = SymbolicKeyboardInputSet(rows: KeyboardInputRows([[",", ".", "-"], [",", ".", "-"], [",", ".", "-"]]))
            provider = StandardKeyboardLayoutProvider(
                inputSetProvider: inputProvider,
                dictationReplacement: .primary(.go))
        }
        
        
        describe("keyboard layout provider for context") {
            
            it("is phone provider if context device is phone") {
                device.userInterfaceIdiomValue = .phone
                let result = provider.layoutProvider(for: context)
                expect(result).to(be(provider.iPhoneProvider))
            }
            
            it("is pad provider if context device is pad") {
                device.userInterfaceIdiomValue = .pad
                let result = provider.layoutProvider(for: context)
                expect(result).to(be(provider.iPadProvider))
            }
        }
        
        describe("keyboard layout for context (just testing this one)") {
            
            it("is phone layout if context device is phone") {
                device.userInterfaceIdiomValue = .phone
                let layout = provider.keyboardLayout(for: context)
                let phoneLayout = provider.iPhoneProvider.keyboardLayout(for: context)
                let padLayout = provider.iPadProvider.keyboardLayout(for: context)
                expect(layout.items).to(equal(phoneLayout.items))
                expect(layout.items).toNot(equal(padLayout.items))
            }
            
            it("is pad layout if context device is pad") {
                device.userInterfaceIdiomValue = .pad
                let layout = provider.keyboardLayout(for: context)
                let phoneLayout = provider.iPhoneProvider.keyboardLayout(for: context)
                let padLayout = provider.iPadProvider.keyboardLayout(for: context)
                expect(layout.items).toNot(equal(phoneLayout.items))
                expect(layout.items).to(equal(padLayout.items))
            }
        }
        
        describe("registering input set provider") {
            
            it("changes the provider instance for all providers") {
                let newInputProvider = MockKeyboardInputSetProvider()
                provider.register(inputSetProvider: newInputProvider)
                expect(provider.inputSetProvider).toNot(be(inputProvider))
                expect(provider.inputSetProvider).to(be(newInputProvider))
                expect(provider.iPhoneProvider.inputSetProvider).to(be(newInputProvider))
                expect(provider.iPadProvider.inputSetProvider).to(be(newInputProvider))
            }
        }
    }
}
