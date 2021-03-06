
Pod::Spec.new do |s|

  s.name         = "XCUserGuideView"
  s.version      = "0.1.0"
  s.summary      = "Quickly achieve the position the user guide"

  s.description  = <<-DESC
                  Swift quickly achieve the position the user guide
                   DESC

  s.homepage     = "https://github.com/wuchun4/XCUserGuideView"
  s.screenshots  = "https://github.com/wuchun4/XCUserGuideView/blob/master/2017-03-22%2016.49.36.gif"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Simon" => "870396896@qq.com" }

  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/wuchun4/XCUserGuideView.git", :tag => "#{s.version}", :submodules => true  }

  s.ios.source_files  = "XCUserGuideView/**/*.{swift}"
  #s.exclude_files = "Classes/Exclude"

  s.requires_arc = true
  s.dependency "AMPopTip", "1.4.2"

end
