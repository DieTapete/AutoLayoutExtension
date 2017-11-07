Pod::Spec.new do |s|
  s.name             = 'AutoLayoutExtension'
  s.version          = '0.1.0'
  s.summary          = 'A simple UIView extension that adds some convenience autolayout methods.'

  s.description      = <<-DESC
A simple UIView extension that adds some convenience autolayout methods.
                       DESC

  s.homepage         = 'https://github.com/dietapete/AutoLayoutExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Henner' => 'henner@tapwork.de' }
  s.source           = { :git => 'https://github.com/Henner/AutoLayoutExtension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'AutoLayoutExtension/Classes/**/*'

  s.frameworks = 'UIKit'
end
