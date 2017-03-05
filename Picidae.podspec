#
# Be sure to run `pod lib lint Picidae.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Picidae'
  s.version          = '0.1.0'
  s.summary          = 'Picidae is a bridge for JavaScript interaction'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Picidae is a bridge for JavaScript interaction.You can check demo to learn the process of interaction between JavaScript and NativeCode.
                       DESC

  s.homepage         = 'https://github.com/Neojoke/Picidae.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Neo' => '394570610@qq.com' }
  s.source           = { :git => 'https://github.com/Neojoke/Picidae.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'Picidae/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Picidae' => ['Picidae/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'JavaScriptCore'
  # s.dependency 'AFNetworking', '~> 2.3'
end
