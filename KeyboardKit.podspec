Pod::Spec.new do |s|
  s.name             = 'KeyboardKit'
  s.version          = '0.1.0'
  s.summary          = 'KeyboardKit simplifies creating keyboard extension apps.'

  s.description      = <<-DESC
KeyboardKit is a Swift library for iOS keyboard extension apps. It is currently
limited to the functionality I need in my own keyboard extension apps, but feel
free to extend it with more features.

KeyboardKit also contains functionality for creating a wrapper app, that can be
used to select emojis from a collection view. This is nice to have, if the user
doesn't want to give the keyboard extension full access.

                       DESC

  s.homepage         = 'https://github.com/danielsaidi/KeyboardKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/KeyboardKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KeyboardKit/Classes/**/*'
end
