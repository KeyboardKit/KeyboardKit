# Run `pod lib lint' to ensure this is a valid spec.

Pod::Spec.new do |s|
  s.name             = 'KeyboardKit'
  s.version          = '6.8.1'
  s.swift_versions   = ['5.6']
  s.summary          = 'KeyboardKit helps you create custom keyboard for iOS and iPadOS.'

  s.description      = <<-DESC
KeyboardKit is a Swift and library that helps you create custom keyboard for iOS and iPadOS, using SwiftUI.'
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/KeyboardKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/KeyboardKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.swift_version = '5.6'
  
  s.ios.deployment_target = '13.0'
  s.macos.deployment_target = '11.0'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  
  s.source_files = 'Sources/KeyboardKit/**/*.swift'
  s.resources = "Sources/KeyboardKit/Resources"
end
