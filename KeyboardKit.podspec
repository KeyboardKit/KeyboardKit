Pod::Spec.new do |s|
  s.name             = 'KeyboardKit'
  s.version          = '0.1.0'
  s.summary          = 'KeyboardKit simplifies creating keyboard extension apps for iOS.'

  s.description      = <<-DESC
KeyboardKit is a Swift library that simplifies creating keyboard extension apps for iOS.
It is currently limited to the functionality I need in my own keyboard apps.

                       DESC

  s.homepage         = 'https://github.com/danielsaidi/KeyboardKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/KeyboardKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KeyboardKit/Classes/**/*'
end
