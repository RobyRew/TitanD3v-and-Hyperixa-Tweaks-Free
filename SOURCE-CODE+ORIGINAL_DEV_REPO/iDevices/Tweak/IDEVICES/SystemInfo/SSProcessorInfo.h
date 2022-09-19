#import <Foundation/Foundation.h>
#import <sys/sysctl.h>
#include <mach/mach.h>
#import <sys/utsname.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <ExternalAccessory/ExternalAccessory.h>

// AVFoundation
#import <AVFoundation/AVFoundation.h>

@interface SSProcessorInfo : NSObject

+ (NSInteger)numberProcessors;
+ (NSInteger)numberActiveProcessors;

+ (nullable NSString *)country;

// Language
+ (nullable NSString *)language;

// TimeZone
+ (nullable NSString *)timeZone;

// Currency Symbol
+ (nullable NSString *)currency;


// System Uptime (dd hh mm)
+ (nullable NSString *)systemUptime;

// Model of Device
+ (nullable NSString *)deviceModel;

// Device Name
+ (nullable NSString *)deviceName;

// System Name
+ (nullable NSString *)systemName;

// System Version
+ (nullable NSString *)systemVersion;

// System Device Type (iPhone1,0) (Formatted = iPhone 1)
+ (nullable NSString *)systemDeviceTypeFormatted:(BOOL)formatted;

// Get the Screen Width (X)
+ (NSInteger)screenWidth;

// Get the Screen Height (Y)
+ (NSInteger)screenHeight;

// Get the Screen Brightness
+ (float)screenBrightness;

// Multitasking enabled?
+ (BOOL)multitaskingEnabled;

// Proximity sensor enabled?
+ (BOOL)proximitySensorEnabled;

// Debugger Attached?
+ (BOOL)debuggerAttached;

// Plugged In?
+ (BOOL)pluggedIn;

// Step-Counting Available?
+ (BOOL)stepCountingAvailable;

// Distance Available
+ (BOOL)distanceAvailable;

// Floor Counting Available
+ (BOOL)floorCountingAvailable;

// Carrier Name
+ (nullable NSString *)carrierName;

// Carrier Country
+ (nullable NSString *)carrierCountry;

// Carrier Mobile Country Code
+ (nullable NSString *)carrierMobileCountryCode;

// Carrier ISO Country Code
+ (nullable NSString *)carrierISOCountryCode;

// Carrier Mobile Network Code
+ (nullable NSString *)carrierMobileNetworkCode;

// Carrier Allows VOIP
+ (BOOL)carrierAllowsVOIP;

+ (float)batteryLevel;

// Charging?
+ (BOOL)charging;

// Fully Charged?
+ (BOOL)fullyCharged;
+ (nullable NSString *)clipboardContent;

+ (BOOL)accessoriesAttached;

// Are headphone attached?
+ (BOOL)headphonesAttached;

// Number of attached accessories
+ (NSInteger)numberAttachedAccessories;

// Name of attached accessory/accessories (seperated by , comma's)
+ (nullable NSString *)nameAttachedAccessories;

@end
