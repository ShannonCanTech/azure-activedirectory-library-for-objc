Pod::Spec.new do |s|
  s.name         = "ADAL"
  s.module_name  = "ADAL"
  s.version      = "2.1.0-beta.4"
  s.summary      = "The ADAL SDK for iOS gives you the ability to add Azure Identity authentication to your application"

  s.description  = <<-DESC
                   The Azure Identity Library for Objective C. This library gives you the ability to add support for Work Accounts to your iOS and OS X applications with just a few lines of additional code. This SDK gives your application the full functionality of Microsoft Azure AD, including industry standard protocol support for OAuth2, Web API integration with user level consent, and two factor authentication support.
                   DESC
  s.homepage     = "https://github.com/AzureAD/azure-activedirectory-library-for-objc"
  s.license      = { 
    :type => "MIT", 
    :file => "LICENSE.txt" 
  }
  s.authors      = { "Brandon Werner" => "brandwe@microsoft.com" }
  s.social_media_url   = "https://twitter.com/azuread"
  s.platform     = :ios, :osx
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.10"
  s.source       = { 
    :git => "https://github.com/AzureAD/azure-activedirectory-library-for-objc.git", 
    :tag => s.version.to_s
  }
  
  s.header_dir = "ADAL"
  
  s.prefix_header_file = "ADAL/src/ADAL.pch"

  s.source_files = "ADAL/src/**/*.{h,m}"
  s.public_header_files = "ADAL/src/public/*.h"
  
  s.ios.public_header_files = "ADAL/src/public/ios/*.h"
  s.ios.exclude_files = "ADAL/src/**/mac/*"
  
  s.osx.public_header_files = "ADAL/src/public/mac/*.h"
  s.osx.exclude_files = "ADAL/src/**/ios/*"
  s.osx.module_map = "ADAL/resources/mac/adal_mac.modulemap"
  s.osx.resources = "ADAL/resources/mac/ADCredentialViewController.xib"
  
  s.exclude_files = "ADAL/src/broker/ios/ADBrokerKeyHelper.m","ADAL/src/cache/ios/ADKeychainTokenCache.m","ADAL/src/workplacejoin/ios/ADWorkPlaceJoinUtil.m"
  s.requires_arc = true
  
  # This is a hack because one of the headers is public on mac but private on ios
  s.subspec 'tokencacheheader' do |ph|
  	ph.platform = :ios
  	ph.ios.source_files = "ADAL/src/public/mac/ADTokenCache.h","ADAL/src/public/ios/*.h"
  	# This extra nonsense is so that it doesn't make ADTokenCache.h a public header on iOS
  	# And also doesn't generate a podspec warning
  	ph.ios.public_header_files = "ADAL/src/public/ios/*.h"
  end
  
  s.subspec 'iosinternalheaders' do |hds|
   hds.platform = :osx
   hds.osx.source_files = "ADAL/src/workplacejoin/ios/ADWorkplaceJoinConstants.h","ADAL/src/broker/ios/*.h","ADAL/src/public/mac/*.h"
   hds.osx.public_header_files = "ADAL/src/public/mac/*.h"
  end

  # This is the only way cocoapods has of dealing with a handful of files that don't use
  # ARC. Why they make this significantly more difficult, I don't know.
  s.subspec 'no-arc' do |noarc|
    noarc.platform = :ios
   	noarc.ios.source_files = "ADAL/src/**/*.h","ADAL/src/broker/ios/ADBrokerKeyHelper.m","ADAL/src/cache/ios/ADKeychainTokenCache.m","ADAL/src/workplacejoin/ios/ADWorkPlaceJoinUtil.m"
  	noarc.ios.public_header_files = "ADAL/src/public/*.h"
  	
  	noarc.ios.public_header_files = "ADAL/src/public/ios/*.h"
  	noarc.ios.exclude_files = "ADAL/src/**/mac/*"
  	
  	noarc.requires_arc = false
  end
end
