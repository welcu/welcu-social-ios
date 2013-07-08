Pod::Spec.new do |s|
  s.name         = "PCStackMenu"
  s.version      = "1.0.0"
  s.summary      = "Stack Menu looks like the OS X Dock's stacks feature."
  s.homepage     = "https://github.com/istsest/StackMenu"
  s.screenshots  = "https://github.com/istsest/StackMenu/raw/master/main.png"
  s.license      = 'BSD'
  s.author       = "John"
  s.source       = { :git => "https://github.com/istsest/StackMenu.git" }
  s.platform     = :ios, '5.0'
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.requires_arc = true
end
