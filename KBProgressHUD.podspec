#
# Be sure to run `pod lib lint KBProgressHUD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KBProgressHUD'
  s.version          = '0.0.3'
  s.summary          = 'KBProgressHUD shows default loading indicator with ease'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
KBProgressHUD show an dismiss default loading indicator with ease. This can be great for showing some task is running in the background.
                       DESC

  s.homepage         = 'https://github.com/kbokdia/KBProgressHUD'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kbokdia' => 'kbokdia@gmail.com' }
  s.source           = { :git => 'https://github.com/kbokdia/KBProgressHUD.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kbokdia'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KBProgressHUD/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KBProgressHUD' => ['KBProgressHUD/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.swift_version = "4.0"
  # s.dependency 'AFNetworking', '~> 2.3'
end
