Pod::Spec.new do |spec|
  spec.name         = "WTAlertController"
  spec.version      = "0.0.8"
  spec.summary      = "A custom AlertController similar to UIAlertController"
  spec.homepage     = "https://github.com/Sean-LWT/Alert"
  spec.license      = "MIT"
  spec.author       = { "Sean" => "820378591@qq.com" }
  spec.source       = { :git => "https://github.com/Sean-LWT/Alert.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = '11.0'
  spec.source_files  = 'Sources/WTAlertController/*.swift'
  spec.swift_version = '5.0'
end
