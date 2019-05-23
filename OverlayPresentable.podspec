Pod::Spec.new do |s|
  s.name         = "OverlayPresentable"
  s.version      = "0.3"
  s.summary      = "OverlayPresentable is a protocol for easier presenting an overlay in your view"
  s.description  = <<-DESC
  OverlayPresentable gives you tools to easy show an overlay in a view. For example when you want to
  display view containing UIActivityIndicatorView to inform user about lenghty process (e.g. API request)
  and also lock the screen(or view) from user interaction.
                   DESC
  s.homepage     = "https://goapps.pl"
  s.license      = "MIT"
  s.author       = { "Jan Tyra" => "j.tyra@goapps.pl" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/goappsmobile/OverlayPresentable.git", :tag => "#{s.version}" }
  s.source_files  = "OverlayPresentable", "OverlayPresentable/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5' }
end
