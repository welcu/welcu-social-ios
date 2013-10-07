Pod::Spec.new do |s|
  s.name                = "R1PhotoEffectsSDK"
  s.version             = "1.0.9"
  s.summary             = "RadiumOne Photo Effects"
  s.homepage            = "http://radiumone.com/photoeffects/"
  # s.license             = { :type => "Commercial", :file => "LICENSE" }
  s.author              = { "Radiumone" => "contact@r1sdk.com" }
  s.source              = { :http => "http://effects.viame-cdn.com/builds/R1PhotoEffectsSDK-318.zip" }
  s.platform            = :ios, "5.0"
  s.public_header_files = "*.h"
  s.preserve_paths      = "*.{a,h,bundle}"
  s.frameworks          = "UIKit", "SystemConfiguration", "OpenGLES", "QuartzCore", "AVFoundation",
                          "CoreMedia", "CoreVideo", "CoreGraphics", "CoreText", "CoreTelephony", "MobileCoreServices",
                          "StoreKit"
  s.weak_frameworks     = "AdSupport"
  s.libraries           = 'R1PhotoEffectsSDK'
  s.resources           = 'R1PhotoEffectsResources.bundle'
  s.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/R1PhotoEffectsSDK"' }
  s.prepare_command = <<-CMD
    mv R1PhotoEffectsSDK/* ./
    mv R1PhotoEffectsSDK.a libR1PhotoEffectsSDK.a
  CMD
end
