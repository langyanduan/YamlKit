#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'YamlKit'
  spec.version          = '0.1.3'
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
  # spec.default_subspec = 'core'
  spec.default_subspec = 'libyaml'
 
  spec.subspec 'libyaml' do |libyaml|
    libyaml.public_header_files = 'libyaml/include/yaml.h'
    libyaml.source_files = 'libyaml/src/*.{h,c}', 'libyaml/include/yaml.h' 
    libyaml.preserve_paths = 'libyaml/include/*.h'
    libyaml.xcconfig = { 'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/YamlKit/libyaml/include"',
                         'GCC_PREPROCESSOR_DEFINITIONS' => 'HAVE_CONFIG_H' }
    libyaml.module_name = 'libyaml'
  end
  
  spec.subspec 'core' do |core|
    core.source_files = [
      'YamlKit/YAMLSerialization.swift'
    ]
    core.dependency 'YamlKit/libyaml'
  end 
end