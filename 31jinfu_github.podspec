Pod::Spec.new do |s|
s.name         = '31jinfu_github'
s.version      = '1.0.2'
s.summary      = 'A short description of 31jinfu_github on iOS'
s.homepage     = 'https://github.com/NiceSnow/31jinfu_github'
s.description  = <<-DESC
It is a component for ios photo browser,written by Objective-C.
DESC
s.license      = 'MIT'
s.authors      = {'madongdong' => 'madongdong@31jinfu.com'}
s.platform     = :ios, '6.0'
s.source       = {:git => 'https://github.com/NiceSnow/31jinfu_github.git', :tag => s.version}
s.source_files = '31jinfu_github/**/*.{h,m}'
s.requires_arc = true
end
