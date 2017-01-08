Pod::Spec.new do |s|
  s.name             = 'OnkyoSdk'
  s.version          = '0.1.0'
  s.summary          = 'SDK to send commands to Onkyo sound implemented in Swift.'
  s.description      = <<-DESC
SDK to send commands to Onkyo sound through the IDSP protocol implemented in Swift.
                       DESC
  s.homepage         = 'https://github.com/saviofigueiredo/OnkyoSdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Savio Mendes de Figueiredo' => 'saviofigueiredo@outlook.com' }
  s.source           = { :git => 'https://github.com/saviofigueiredo/OnkyoSdk.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.source_files = 'OnkyoSdk/Classes/**/*'
  
  # s.resource_bundles = {
  #   'OnkyoSdk' => ['OnkyoSdk/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
