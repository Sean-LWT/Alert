Pod::Spec.new do |spec|
  spec.name         = "WTAlertController"
  spec.version      = "0.0.5"
  spec.summary      = "一款类似UIAlertController的自定义Alert样式"
  spec.homepage     = "https://github.com/Sean-LWT/Alert"
  spec.license      = "MIT"
  spec.author       = { "Sean" => "820378591@qq.com" }
  spec.source       = { :git => "https://github.com/Sean-LWT/Alert.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = '11.0'
  spec.source_files  = 'Source/*.swift'
  spec.swift_version = '5.0'
end
