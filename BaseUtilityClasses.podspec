#
#  Be sure to run `pod spec lint BaseUtilityClasses.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.name         = "BaseUtilityClasses"
  s.version      = "0.1.0"
  s.summary      = "Utility Classes"
  s.description  = <<-DESC
A set of classes I have found useful when developing for ios
                   DESC


  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Etienne Goulet-Lang" => "" }
  s.source       = { :git => "https://github.com/egouletlang/ios-BaseUtilityClasses.git", :tag => "#{s.version}" }

  s.homepage = "https://github.com/egouletlang/ios-BaseUtilityClasses"

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
