Pod::Spec.new do |s|
  s.name         = "A_ChainAnimation"
  s.version      = "1.0.0"
  s.summary      = "Library provides various Animation Combination with Animation Chain."
  s.homepage     = "https://github.com/Animaxx/ChainAnimation"
  s.license      = "MIT"
  s.authors      = { 'Animax Deng' => 'Animax.deng@gmail.com'}
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Animaxx/ChainAnimation.git", :tag => s.version }
  s.source_files = "A_ChainAnimation/*.{h,m}"
  s.requires_arc = true
end