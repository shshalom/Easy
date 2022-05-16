#
#  Be sure to run `pod spec lint EasyUIKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "EasyUIKit"
  spec.version      = "0.0.1"
  
  spec.summary      = "EasyUIKit is a helper that aims to create a clean UI."
  spec.description  = "A quick helper to create and adjust UIViews"

  spec.homepage     = "https://github.com/shshalom/Easy"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Shalom & eliransha88" => "shalom.shwaitzer@gmail.com eliransha88@gmail.com" }
  
  #spec.platform     = :ios, "5.0"
  spec.swift_version = '5.0'
  spec.ios.deployment_target = '13.0'
  spec.source       = { :git => "https://github.com/shshalom/Easy.git", :tag => "#{spec.version}" }
  spec.dependency 'SnapKit', '~> 5.6.0'
  spec.subspec "Core" do |ss|
    ss.source_files = "EasyUIKit/Source/**/*.swift"
    ss.exclude_files = "EasyUIKit/SupportingFiles/*.plist"
  end
end 