# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'Weather' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Weather
  pod 'RealmSwift', '~> 3.17'
  pod 'GooglePlaces', '~> 3.3'
  pod 'SlideMenu3D'
  
  target 'WeatherTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WeatherUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
            end
        end
    end
end
