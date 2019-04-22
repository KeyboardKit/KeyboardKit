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
            
            it("is only specified for image action with existing image") {
                let imageInExampleApp = "base"
                expect(image(for: .none)).to(beNil())
                expect(image(for: .backspace)).to(beNil())
                expect(image(for: .character("a"))).to(beNil())
                expect(image(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: "image name"))).to(beNil())
                expect(image(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: imageInExampleApp))).toNot(beNil())
                expect(image(for: .newLine)).to(beNil())
                expect(image(for: .nextKeyboard)).to(beNil())
                expect(image(for: .shift)).to(beNil())
                expect(image(for: .space)).to(beNil())
            }
        }
        
        describe("image name") {
            
            func imageName(for action: KeyboardAction) -> String? {
                return action.imageName
            }
            
            it("is only specified for image action") {
                expect(imageName(for: .none)).to(beNil())
                expect(imageName(for: .backspace)).to(beNil())
                expect(imageName(for: .character("a"))).to(beNil())
                expect(imageName(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: "image name"))).to(equal("image name"))
                expect(imageName(for: .newLine)).to(beNil())
                expect(imageName(for: .nextKeyboard)).to(beNil())
                expect(imageName(for: .shift)).to(beNil())
                expect(imageName(for: .space)).to(beNil())
            }
        }
        
        describe("keyboard image") {
            
            func image(for action: KeyboardAction) -> UIImage? {
                return action.keyboardImage
            }
            
            it("is only specified for image action with existing image") {
                let imageInExampleApp = "base"
                expect(image(for: .none)).to(beNil())
                expect(image(for: .backspace)).to(beNil())
                expect(image(for: .character("a"))).to(beNil())
                expect(image(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: "image name"))).to(beNil())
                expect(image(for: .image(description: "image", keyboardImageName: imageInExampleApp, imageName: "image name"))).toNot(beNil())
                expect(image(for: .newLine)).to(beNil())
                expect(image(for: .nextKeyboard)).to(beNil())
                expect(image(for: .shift)).to(beNil())
                expect(image(for: .space)).to(beNil())
            }
        }
        
        describe("keyboard image name") {
            
            func imageName(for action: KeyboardAction) -> String? {
                return action.keyboardImageName
            }
            
            it("is only specified for image action") {
                expect(imageName(for: .none)).to(beNil())
                expect(imageName(for: .backspace)).to(beNil())
                expect(imageName(for: .character("a"))).to(beNil())
                expect(imageName(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: "image name"))).to(equal("keyboard image"))
                expect(imageName(for: .newLine)).to(beNil())
                expect(imageName(for: .nextKeyboard)).to(beNil())
                expect(imageName(for: .shift)).to(beNil())
                expect(imageName(for: .space)).to(beNil())
            }
        }
        
        describe("title") {
            
            func title(for action: KeyboardAction) -> String? {
                return action.title
            }
            
            it("is only specified for character action") {
                expect(title(for: .none)).to(beNil())
                expect(title(for: .backspace)).to(beNil())
                expect(title(for: .character("a"))).to(equal("a"))
                expect(title(for: .image(description: "image", keyboardImageName: "keyboard image", imageName: "image name"))).to(beNil())
                expect(title(for: .newLine)).to(beNil())
                expect(title(for: .nextKeyboard)).to(beNil())
                expect(title(for: .shift)).to(beNil())
                expect(title(for: .space)).to(beNil())
            }
        }
    }
}
