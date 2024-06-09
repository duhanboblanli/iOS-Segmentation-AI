# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'Segment AI' do
  
  use_frameworks!
  # Pods for ios_ai_cutter
  pod 'FLAnimatedImage', '~> 1.0'
  pod 'Google-Mobile-Ads-SDK'
  pod 'GoogleMobileAdsMediationFacebook'
  pod 'GoogleMobileAdsMediationMintegral'
  pod 'GoogleMobileAdsMediationAppLovin'
  pod 'GoogleMobileAdsMediationInMobi'
  pod 'FBAudienceNetwork'
  pod 'Alamofire'
  # Pod for Photo Editing from colorful-room + PixelEnginePackage
  pod 'QCropper'
  
  # !cause error!
  # pod 'LazyViewSwiftUI'
end

# This will update all the Pod targets at once to your desired version.
# Silence the IPHONEOS_DEPLOYMENT_TARGET warnings
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
