//
//  KeyboardActionTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-04-22.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardActionTests: QuickSpec {
    
    override func spec() {
        
        describe("image") {
            
            func image(for action: KeyboardAction) -> UIImage? {
                return action.image
            }
            
            it("is specified for image action with existing image") {
                let imageInExampleApp = "base"
                expect(image(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: "image name"))).to(beNil())
                expect(image(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: imageInExampleApp))).toNot(beNil())
            }
        }
        
        describe("image name") {
            
            func imageName(for action: KeyboardAction) -> String? {
                return action.imageName
            }
            
            it("is specified for image action") {
                expect(imageName(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: "image name"))).to(equal("image name"))
            }
        }
        
        describe("keyboard image") {
            
            func image(for action: KeyboardAction) -> UIImage? {
                return action.keyboardImage
            }
            
            it("is specified for image action with existing image") {
                let imageInExampleApp = "base"
                expect(image(for: .image(description: "image", keyboardImageName: imageInExampleApp, imageName: "image name"))).toNot(beNil())
            }
        }
        
        describe("keyboard image name") {
            
            func imageName(for action: KeyboardAction) -> String? {
                return action.keyboardImageName
            }
            
            it("is specified for image action") {
                expect(imageName(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: "image name"))).to(equal("keyboard image"))
            }
        }
        
        describe("should repeat on long press") {
            
            func result(for action: KeyboardAction) -> Bool {
                return action.shouldRepeatOnLongPress
            }
            
            it("is only specified for certain actions") {
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .backspace)).to(beTrue())
                expect(result(for: .character("a"))).to(beTrue())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beFalse())
                expect(result(for: .moveCursorBack)).to(beTrue())
                expect(result(for: .moveCursorForward)).to(beTrue())
                expect(result(for: .newLine)).to(beTrue())
                expect(result(for: .nextKeyboard)).to(beFalse())
                expect(result(for: .shift)).to(beFalse())
                expect(result(for: .space)).to(beTrue())
            }
        }
        
        describe("title") {
            
            func title(for action: KeyboardAction) -> String? {
                return action.title
            }
            
            it("is specified for character action") {
                expect(title(for: .character("a"))).to(equal("a"))
            }
        }
    }
}
