Pod::Spec.new do |s|
  s.name         = "R1PhotoEffectsSDK"
  s.version      = "1.0.4"
  s.summary      = "Real-time performance data with your next iOS app release."
  s.homepage     = "http://r1sdk.com/effects/"
  # s.license      = { :type => "Commercial", :file => "LICENSE" }
  s.author       = { "Radiumone" => "contact@r1sdk.com" }
  s.source       = { :http => "http://effects.viame-cdn.com/builds/R1PhotoEffectsSDK-ios-263.zip" }
  s.platform     = :ios, "5.0"
  s.public_header_files = "R1PhotoEffectsSDK-ios-1.0.4 2/*.h"
  s.preserve_paths = "R1PhotoEffectsSDK-ios-1.0.4 2/R1*"
  s.frameworks   = "R1PhotoEffectsSDK", "SystemConfiguration", "OpenGLES", "QuartzCore", "AVFoundation",
    "CoreMedia", "CoreVideo", "CoreGraphics", "CoreText", "CoreTelephony", "MobileCoreServices", "StoreKit"
  s.library      = "z"
  s.xcconfig     =  { "FRAMEWORK_SEARCH_PATHS" => '"$(PODS_ROOT)/R1PhotoEffectsSDK/R1PhotoEffectsSDK-ios-1.0.4 2"' }
  s.documentation = { :appledoc => ['--company-id', 'com.r1sdk'] }
  s.resources    = 'R1PhotoEffectsSDK/R1PhotoEffectsSDK-ios-1.0.4 2/R1PhotoEffectsSDK.bundle'
end