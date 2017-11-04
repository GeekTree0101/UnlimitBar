Pod::Spec.new do |s|
  s.name             = 'UnlimitBar'
  s.version          = '0.1.0'
  s.summary          = 'I HATE UINavigationBar attribute restriction!'

  s.description      = 'UINavigationBar has tooo many restriction, Lets make custom navigationBar as UIView!'

  s.homepage         = 'https://github.com/Geektree0101/UnlimitBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Geektree0101' => 'h2s1880@gmail.com' }
  s.source           = { :git => 'https://github.com/Geektree0101/UnlimitBar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'UnlimitBar/Classes/**/*'
end
