Pod::Spec.new do |s|
  s.name             = "NIMConfigManager"
  s.version          = "0.0.5"
  s.summary          = "A short description of NIMConfigManager."
  s.description      = <<-DESC
                       
                       DESC
  s.homepage         = "https://github.com/Nimbleworks/NIMConfigManager"
  s.license          = 'MIT'
  s.author           = { "John Nye" => "john@nimbleworks.co.uk" }
  s.source           = { :git => "https://github.com/Nimbleworks/NIMConfigManager.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nimbleworks'

  s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'NIMConfigManager'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
