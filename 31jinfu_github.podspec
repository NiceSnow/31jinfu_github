
Pod::Spec.new do |spec|
spec.name         = '31jinfu_github'
spec.version      = '1.0.2'
spec.license      = { :type => 'MIT' }
spec.homepage     = 'https://github.com/NiceSnow/31jinfu_github'
spec.authors      = { 'madongdong' => 'madongdong@31jinfu.com' }
spec.summary      = 'ARC and GCD Compatible Reachability Class for iOS and OS X.'
spec.source       = { :git => 'https://github.com/NiceSnow/31jinfu_github.git', :tag => spec.version }
spec.source_files = '31jinfu/Header/*.{h,m}'
spec.framework    = 'SystemConfiguration'
end
