# Uncomment this line to define a global platform for your project

source 'https://github.com/CocoaPods/Specs.git'
source 'https://cdn.cocoapods.org/'
plugin 'cocoapods-art', :sources => [
'drivekit-ios',
'httpclient-ios',
'octokit-ios',
'octosmaaskit-ios',
'rorschach-ios',
]

platform :ios, '14.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}. Try deleting Generated.xcconfig, then run flutter pub get"
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)

flutter_ios_podfile_setup

target 'Runner' do
  use_frameworks!
  pod 'RaxelPulse', '~> 6.0.0'
  pod 'MarketingCloudSDK', '~> 8.1.0'
  pod 'Firebase/Analytics', '10.19.0'
  pod 'Firebase/RemoteConfig', '10.19.0'
  pod 'Firebase/Messaging', '10.19.0'
  pod 'Firebase/Crashlytics', '10.19.0'

  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
  # target 'RunnerTests' do
  #   inherit! :search_paths
  # end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end

  installer.pods_project.build_configurations.each do |config|

    config.build_settings["BUILD_LIBRARY_FOR_DISTRIBUTION"] = "YES"

  end

  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'

        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: [PermissionGroup.calendarWriteOnly, PermissionGroup.calendar (iOS 16 and below)]
        # 'PERMISSION_EVENTS=1',

        ## dart: [PermissionGroup.calendarFullAccess, PermissionGroup.calendar (iOS 17 and above)]
        # 'PERMISSION_EVENTS_FULL_ACCESS=1',

        ## dart: PermissionGroup.reminders
        # 'PERMISSION_REMINDERS=1',

        ## dart: PermissionGroup.contacts
        # 'PERMISSION_CONTACTS=1',

        ## dart: PermissionGroup.camera
        # 'PERMISSION_CAMERA=1',

        ## dart: PermissionGroup.microphone
        # 'PERMISSION_MICROPHONE=1',

        ## dart: PermissionGroup.speech
        # 'PERMISSION_SPEECH_RECOGNIZER=1',

        ## dart: PermissionGroup.photos
        # 'PERMISSION_PHOTOS=1',

        ## dart: PermissionGroup.photosAddOnly
        # 'PERMISSION_PHOTOS_ADD_ONLY=1',

        ## dart: [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]
        'PERMISSION_LOCATION=1',

        ## dart: PermissionGroup.notification
        'PERMISSION_NOTIFICATIONS=1',

        ## dart: PermissionGroup.mediaLibrary
        # 'PERMISSION_MEDIA_LIBRARY=1',

        ## dart: PermissionGroup.sensors
        'PERMISSION_SENSORS=1',

        ## dart: PermissionGroup.bluetooth
        # 'PERMISSION_BLUETOOTH=1',

        ## dart: PermissionGroup.appTrackingTransparency
        # 'PERMISSION_APP_TRACKING_TRANSPARENCY=1',

        ## dart: PermissionGroup.criticalAlerts
        # 'PERMISSION_CRITICAL_ALERTS=1'
      ]
      end
    end
  end

end
