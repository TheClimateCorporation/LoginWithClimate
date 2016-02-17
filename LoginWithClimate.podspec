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
  s.summary          = "An OpenID connect implementation for integrating climate.com logins into third-party apps."

  s.description      = <<-DESC
                        An OpenID connect implementation for integrating climate.com logins into third-party apps.
                        Exports a "Login with Climate" button.
                       DESC

  s.homepage         = "https://github.com/TheClimateCorporation/LoginWithClimate"
  s.license          = 'Apache 2.0'
  s.author           = { "Tommy Rogers" => "tommy.rogers@climate.com" }
  s.source           = { :git => "https://github.com/TheClimateCorporation/LoginWithClimate.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'LoginWithClimate' => ['Pod/Assets/*.png', 'Pod/Resources/*']
  }
  s.resources = ['Pod/Resources/Media.xcassets']
end
