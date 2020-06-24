
Pod::Spec.new do |s|
  s.name         = "RNGetThumbnail"
  s.version      = "1.0.1"
  s.summary      = "Get Thumbnail from Video"
  s.description  = <<-DESC
                  Get Thumbnail from Video
                   DESC
  s.homepage     = "https://github.com/CaoLP/react-native-get-thumbnail.git"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "cao.le@kyanon.digital" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/CaoLP/react-native-get-thumbnail.git", :tag => "master" }
  s.source_files  = "**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  