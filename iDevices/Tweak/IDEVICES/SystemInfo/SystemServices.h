#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSNetworkInfo.h"
#import "SSProcessorInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SystemServices : NSObject

+ (nonnull instancetype)sharedServices;
- (NSString *)systemsUptime;
- (NSString *)deviceModel;
- (NSString *)deviceName;
- (NSString *)systemName;
- (NSString *)systemsVersion;
- (NSString *)systemDeviceTypeNotFormatted;
- (NSString *)systemDeviceTypeFormatted;
- (NSInteger)screenWidth;
- (NSInteger)screenHeight;
- (float)screenBrightness;
- (BOOL)multitaskingEnabled;
- (BOOL)proximitySensorEnabled;
- (BOOL)debuggerAttached;
- (BOOL)pluggedIn;
- (BOOL)stepCountingAvailable;
- (BOOL)distanceAvailable;
- (BOOL)floorCountingAvailable;
- (NSInteger)numberProcessors;
- (NSInteger)numberActiveProcessors;
- (BOOL)accessoriesAttached;
- (BOOL)headphonesAttached;
- (NSInteger)numberAttachedAccessories;
- (NSString *)nameAttachedAccessories;
- (NSString *)carrierName;
- (NSString *)carrierCountry;
- (NSString *)carrierMobileCountryCode;
- (NSString *)carrierISOCountryCode;
- (NSString *)carrierMobileNetworkCode;
- (BOOL)carrierAllowsVOIP;
- (float)batteryLevel;
- (BOOL)charging;
- (BOOL)fullyCharged;
- (nullable NSString *)currentIPAddress;
- (nullable NSString *)externalIPAddress;
- (nullable NSString *)cellIPAddress;
- (nullable NSString *)cellNetmaskAddress;
- (nullable NSString *)cellBroadcastAddress;
- (nullable NSString *)wiFiIPAddress;
- (nullable NSString *)wiFiNetmaskAddress;
- (nullable NSString *)wiFiBroadcastAddress;
- (nullable NSString *)wiFiRouterAddress;
- (BOOL)connectedToWiFi;
- (BOOL)connectedToCellNetwork;
- (nullable NSString *)country;
- (nullable NSString *)language;
- (nullable NSString *)timeZoneSS;
- (nullable NSString *)currency;
- (nullable NSString *)clipboardContent;

@end
NS_ASSUME_NONNULL_END
