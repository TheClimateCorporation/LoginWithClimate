#
# Be sure to run `pod lib lint LoginWithClimate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LoginWithClimate"
  s.version          = "0.1.0"
  s.summary          = "A short description of LoginWithClimate."

  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/LoginWithClimate"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Tommy Rogers" => "tommy.rogers@climate.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/LoginWithClimate.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'LoginWithClimate' => ['Pod/Assets/*.png', 'Pod/Resources/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
