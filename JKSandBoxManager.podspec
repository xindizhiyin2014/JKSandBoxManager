#
# Be sure to run `pod lib lint JKSandBoxManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JKSandBoxManager'
  s.version          = '0.1.7.2'
  s.summary          = 'the manager of sandbox,it contain the operations of sandbox.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
the manager of sandbox,it contain the operations of sandbox.it will be update with demand.
                       DESC

  s.homepage         = 'https://github.com/xindizhiyin2014/JKSandBoxManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HHL110120' => '929097264@qq.com' }
  s.source           = { :git => 'https://github.com/xindizhiyin2014/JKSandBoxManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'JKSandBoxManager/Classes/**/*'
  
  #s.resource_bundles = {
  #    'JKSandBoxManager' => ['JKSandBoxManager/Assets/*.{bundle,png}']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
