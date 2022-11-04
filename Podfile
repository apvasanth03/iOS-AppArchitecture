# Global config
platform :ios, '13.0'
use_frameworks!
workspace 'iOS-AppArchitecture.xcworkspace'

# Methods to ensure the same version of each library is used across targets
def alamofire
  pod 'Alamofire', '~> 5.6'
end

def swinject
  pod 'Swinject', '~> 2.8'
end


# Targets

# App
target 'iOS-AppArchitecture' do
  project 'iOS-AppArchitecture.xcodeproj'
  
  alamofire
  swinject
end

# Libraries

# Network
target 'HttpClient' do
  project 'Libraries/HttpClient/HttpClient.xcodeproj'
  
  alamofire
  swinject
end

# CommonCore
target 'CommonCore' do
  project 'Libraries/CommonCore/CommonCore.xcodeproj'
  
  swinject
end
