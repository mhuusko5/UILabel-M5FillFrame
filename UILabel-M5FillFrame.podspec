Pod::Spec.new do |s|
  s.name = 'UILabel-M5FillFrame'
  s.version = '1.0.1'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Set M5FillFrameFontScale and M5FillFrameHeightOnly runtime attributes on UILabels or UIButtons to have their text fill/fit to their frame.'
  s.homepage = 'https://github.com/mhuusko5/UILabel-M5FillFrame'
  s.social_media_url = 'https://twitter.com/mhuusko5'
  s.authors = { 'Mathew Huusko V' => 'mhuusko5@gmail.com' }
  s.source = { :git => 'https://github.com/mhuusko5/UILabel-M5FillFrame.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.frameworks = 'UIKit'
  
  s.source_files = '*.{h,m}'
end