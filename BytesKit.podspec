Pod::Spec.new do |s|

  s.name         = "BytesKit"
  s.version      = "1.0"
  s.summary      = "A set of tools to interact with bytes in Swift"

  s.description  = <<-DESC
BytesKit allows you to manipulate bytes in Swift objects in a protocol-oriented manner. It provides utility features that allow you to convert objects to arrays of bytes, to get their hex strings and to convert hex strings to arrays of bytes or Data objects. This library supports String and Data out of the box, and you can extend it with your own types through protocol conformance.
                   DESC

  s.homepage     = "https://github.com/alexaubry/BytesKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Alexis Aubry Radanovic" => "aleks@alexis-aubry-radanovic.me" }
  s.social_media_url   = "http://twitter.com/leksantoine"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/alexaubry/BytesKit.git", :tag => "#{s.version}" }
  s.source_files  = "Sources"
  s.framework  = "Foundation"

end
