Pod::Spec.new do |spec|
  spec.name         = "GDTitlesHeadView"
  spec.version      = "0.0.1"
  spec.ios.deployment_target = '8.0'
  spec.summary      = "简介"
  spec.description  = "description一个简易的、具有公司自己风格的标题栏(同时也是私有库初次探索)"
  spec.homepage     = "https://github.com/JoyHuangbb/GDTitlesHeadView"
  spec.social_media_url = 'https://www.baidu.com'
  spec.license      = "MIT"
  spec.author       = { "黄彬彬" => "746978660@qq.com" }
  spec.source       = { :git => "https://github.com/JoyHuangbb/GDTitlesHeadView.git", :tag => spec.version}
  spec.requires_arc = true
  spec.source_files = 'GDTitlesHeadView/*'
end
