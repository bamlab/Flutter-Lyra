#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_lyra_ios'
  s.version          = '0.0.1'
  s.summary          = 'An iOS implementation of the flutter_lyra plugin.'
  s.description      = <<-DESC
  An iOS implementation of the flutter_lyra plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }  
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.platform = :ios, '15.1'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }  
  s.swift_version = '5.0'

  s.dependency 'LyraPaymentSDK', '~> 2.8.0'
  s.dependency 'LyraCardsRecognizer', '~> 2.0.2'
end
