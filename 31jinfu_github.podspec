Pod::Spec.new do |s|
s.name             = "31jinfu_github"
s.version          = "1.0.1"
s.summary          = "A short description of 31jinfu_github."
s.description      = <<-DESC
It is a marquee view used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/NiceSnow/31jinfu_github"
# s.screenshots      = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
s.license          = 'MIT'
s.author           = { "madongdong" => "madongdong@31jinfu.com" }
s.source           = { :git => "https://github.com/NiceSnow/31jinfu_github.git", :tag => s.version }
# s.social_media_url = "http://twitter.com/madongdong"

s.platform     = :ios
# s.ios.deployment_target = '5.0'
# s.osx.deployment_target = '10.7'
s.requires_arc = true

s.source_files = "31jinfu_github/**/*.{h,m}"
# s.resources = 'Assets'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'
s.vendored_frameworks = 'Framework.framework'
s.frameworks = 'Foundation'

end
