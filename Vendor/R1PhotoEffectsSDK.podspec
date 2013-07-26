Pod::Spec.new do |s|
  s.name                = "R1PhotoEffectsSDK"
  s.version             = "1.0.5"
  s.summary             = "Real-time performance data with your next iOS app release."
  s.homepage            = "http://r1sdk.com/effects/"
  # s.license             = { :type => "Commercial", :file => "LICENSE" }
  s.author              = { "Radiumone" => "contact@r1sdk.com" }
  s.source              = { :http => "http://effects.viame-cdn.com/builds/R1PhotoEffectsSDK-1.0.5.zip" }
  s.platform            = :ios, "5.0"
  s.public_header_files = "R1PhotoEffectsSDK-1.0.5/*.h"
  s.preserve_paths      = "R1PhotoEffectsSDK-1.0.5/*R1*"
  s.frameworks          = "UIKit", "SystemConfiguration", "OpenGLES", "QuartzCore", "AVFoundation",
                          "CoreMedia", "CoreVideo", "CoreGraphics", "CoreText", "CoreTelephony", "MobileCoreServices",
                          "StoreKit"
  s.weak_frameworks     = "AdSupport"
  s.libraries           = 'R1PhotoEffectsSDK'
  s.documentation       = { :appledoc => ['--company-id', 'com.r1sdk'] }
  s.resources           = 'R1PhotoEffectsSDK/R1PhotoEffectsSDK-1.0.5/R1PhotoEffectsSDK.bundle'
  s.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/R1PhotoEffectsSDK/R1PhotoEffectsSDK-1.0.5"' }
  s.pre_install do |pod, library_representation|
    Dir.chdir(File.join(pod.root, 'R1PhotoEffectsSDK-1.0.5')) { `mv R1PhotoEffectsSDK.a libR1PhotoEffectsSDK.a` }
  end
end