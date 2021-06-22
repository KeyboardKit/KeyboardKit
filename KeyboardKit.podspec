# Run `pod lib lint' to ensure this is a valid spec.

Pod::Spec.new do |s|
  s.name             = 'KeyboardKit'
  s.version          = '4.5.4'
  s.swift_versions   = ['5.3']
  s.summary          = 'KeyboardKit helps you create keyboard extensions for iOS.'

  s.description      = <<-DESC
KeyboardKit is a Swift library that helps you create keyboard extensions for iOS.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/KeyboardKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/KeyboardKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.swift_version = '5.3'
  s.ios.deployment_target = '13.0'
  
  s.source_files = 'Sources/KeyboardKit/**/*.swift'
  s.resources = "Sources/KeyboardKit/Resources/*.xcassets"
end
