Pod::Spec.new do |s|

  s.name         = "Easy"
  s.version      = "0.1.0"
  s.summary      = "UIKit helper"
  s.description  = "A quickly helper to create and adjust UIViews"
  s.homepage     = "https://github.com/shshalom/Easy"
  s.license      = "MIT"
  s.author       = { "Shalom & eliransha88" => "shalom.shwaitzer@gmail.com eliransha88@gmail.com" }
  s.platform =:ios, '1.0'
  s.source       = {:git => "https://github.com/shshalom/Easy.git",:tag => "#{s.version}" }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  
  s.subspec "Core" do |ss|
    ss.source_files = "Easy/Source/**/*"
  end
  
  s.subspec "EasySnap" do |ss|
    ss.source_files = "Easy/EasySnap/"
    ss.dependency "SnapKit"
  end
  
end