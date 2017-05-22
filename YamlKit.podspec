#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'YamlKit'
  spec.version          = '0.1.6'
  spec.summary          = 'YAML support for Swift. Based on recommended libyaml.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  spec.description      = <<-DESC
                       A swifty yaml parser, provides support for YAML (de/)serialisation similarly to standard JSONSerialization.
                       DESC

  spec.homepage         = 'https://github.com/langyanduan/YamlKit'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'langyanduan' => 'langyanduan@gmail.com' }
  spec.source           = { :git => 'https://github.com/langyanduan/YamlKit.git', :tag => spec.version.to_s }
  spec.social_media_url = 'https://twitter.com/langyanduan'

  spec.ios.deployment_target = '8.0'
 
  spec.source_files = 'Sources/**/*.swift'
  spec.dependency 'libyaml'
end