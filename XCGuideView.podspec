
Pod::Spec.new do |s|


  s.name         = "XCGuideView"
  s.version      = "0.0.1"
  s.summary      = "XCGuideView"

  s.description  = <<-DESC
XCGuideView，封装简单的引导页功能
                   DESC

  s.homepage     = "https://github.com/fanxiaocong/XCGuideView"


  s.license      = "MIT"

  s.author             = { "樊小聪" => "1016697223@qq.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/fanxiaocong/XCGuideView.git", :tag => "#{s.version}" }

  s.source_files  = "XCGuideView/*.{h,m}"


  s.dependency "XCMacros", "~> 1.0.2"

end
