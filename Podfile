platform :ios, “10.0”
use_frameworks!

target 'HotwireCommunications' do
pod 'Alamofire', '4.1'
pod 'IQKeyboardManagerSwift', '4.0.6'
pod 'SwiftyJSON', '3.0.0'
pod 'HockeySDK'
pod 'ReachabilitySwift', '3.0'
pod 'Branch'
pod 'CMPageControl'

  # Pods for HotwireCommunications

  target 'HotwireCommunicationsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HotwireCommunicationsUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = ‘3.0’
    end
  end
end
