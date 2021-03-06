require 'json'
package = JSON.parse(File.read(File.join(__dir__, '../', 'package.json')))

Pod::Spec.new do |s|
  s.name          = 'react-native-google-cast'
  s.version       = package['version']
  s.summary       = package['description']

  s.author        = { 'petrbela' => 'github@petrbela.com' }
  s.homepage      = 'https://github.com/24i/react-native-google-cast.git'
  s.license       = package['license']
  s.platform      = :ios, '10.0'

  s.source        = { :git => 'https://github.com/24i/react-native-google-cast.git', :tag => s.version.to_s }
  s.source_files  = 'RNGoogleCast/**/*.{h,m}'
  s.default_subspec = 'Default'

  s.dependency      'React'

  s.subspec 'Default' do |ss|
    ss.dependency "react-native-google-cast/RNGoogleCast"
    ss.dependency 'google-cast-sdk', '<= 4.5.3'
  end

  s.subspec 'NoBluetooth' do |ss|
    ss.dependency "react-native-google-cast/RNGoogleCast"
    ss.dependency 'google-cast-sdk-no-bluetooth'
  end

  s.subspec 'Manual' do |ss|
    ss.dependency "react-native-google-cast/RNGoogleCast"
  end

  s.subspec 'RNGoogleCast' do |ss|
    ss.source_files = 'RNGoogleCast/**/*.{h,m}'
  end
end
