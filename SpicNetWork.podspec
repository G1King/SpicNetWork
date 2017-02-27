Pod::Spec.new do |s|
s.name                  = "SpicNetWork"
s.version               = "1.0"
s.ios.deployment_target = '8.0'
s.summary               = "SpicNetWof is used for resume from break point downloading."
s.homepage              = "https://github.com/Insfgg99x/FGGDownloader"
s.license               = "MIT"
s.authors               = { "Sunshinking" -> "G1King@163.com" }
s.source                = { :git => "https://github.com/G1King/SpicNetWork.git", :tag => "1.0" }
s.frameworks            = 'Foundation','UIKit'
s.source_files          = 'SpicNetWork/*.{h,m}'
s.requires_arc          = true
#s.dependency 'AFNetworking'
end
