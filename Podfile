# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GroceryApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['LD_NO_PIE'] = 'NO'
          end
      end
  end
  
  # Pods for GroceryApp

  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Alamofire', '~> 5.0.0-rc.2'
  pod 'Stripe'
end
