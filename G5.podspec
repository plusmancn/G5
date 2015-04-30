#
# Be sure to run `pod lib lint G5.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "G5"
  s.version          = "0.1.0"
  s.summary          = "A flexible framework of Hybrid App，which was more lighter than PhoneGap"
  s.description      = <<-DESC
                       A flexible framework of Hybrid App，which was more lighter than PhoneGap

                       ---

                       **use follow open source framework**

                       * Framework7
                       * Masonry
                       DESC
  s.homepage         = "https://github.com/plusmancn/G5"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "plusmancn" => "plusmancn@gmail.com" }
  s.source           = { :git => "https://github.com/plusmancn/G5.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.framework    = 'UIKit'
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.resource     = 'Pod/Classes/WebViewJavascriptBridge/WebViewJavascriptBridge.js.txt'
  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'G5' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'MBProgressHUD'
  s.dependency 'ZipArchive'
end
