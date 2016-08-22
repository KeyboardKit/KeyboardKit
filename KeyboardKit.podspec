Pod::Spec.new do |s|
  s.name             = 'KeyboardKit'
  s.version          = '0.2.1'
  s.summary          = 'KeyboardKit can be used to create keyboard extensions for iOS.'

  s.description      = <<-DESC
KeyboardKit is a Swift library that can be used to create keyboard extensions for iOS.
It has built-in support for creating an emoji keyboard, and for displaying the emojis
in a collection view in the main app as well.

                       DESC

  s.homepage         = 'https://github.com/danielsaidi/KeyboardKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/KeyboardKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KeyboardKit/Classes/**/*'
end
