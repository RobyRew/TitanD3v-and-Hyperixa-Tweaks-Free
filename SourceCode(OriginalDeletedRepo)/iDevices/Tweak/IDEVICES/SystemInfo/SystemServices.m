#import "SystemServices.h"

@implementation SystemServices

+ (nonnull instancetype)sharedServices {
    static SystemServices *sharedSystemServices = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSystemServices = [[self alloc] init];
    });
    return sharedSystemServices;
}


- (NSString *)systemsUptime {
    return [SSProcessorInfo systemUptime];
}

- (NSString *)deviceModel {
    return [SSProcessorInfo deviceModel];
}

- (NSString *)deviceName {
    return [SSProcessorInfo deviceName];
}

- (NSString *)systemName {
    return [SSProcessorInfo systemName];
}

- (NSString *)systemsVersion {
    return [SSProcessorInfo systemVersion];
}

- (NSString *)systemDeviceTypeNotFormatted {
    return [SSProcessorInfo systemDeviceTypeFormatted:NO];
}

- (NSString *)systemDeviceTypeFormatted {
    return [SSProcessorInfo systemDeviceTypeFormatted:YES];
}

- (NSInteger)screenWidth {
    return [SSProcessorInfo screenWidth];
}

- (NSInteger)screenHeight {
    return [SSProcessorInfo screenHeight];
}

- (float)screenBrightness {
    return [SSProcessorInfo screenBrightness];
}

- (BOOL)multitaskingEnabled {
    return [SSProcessorInfo multitaskingEnabled];
}

- (BOOL)proximitySensorEnabled {
    return [SSProcessorInfo proximitySensorEnabled];
}

- (BOOL)debuggerAttached {
    return [SSProcessorInfo debuggerAttached];
}

- (BOOL)pluggedIn {
    return [SSProcessorInfo pluggedIn];
}

- (BOOL)stepCountingAvailable {
    return [SSProcessorInfo stepCountingAvailable];
}

- (BOOL)distanceAvailable {
    return [SSProcessorInfo distanceAvailable];
}

- (BOOL)floorCountingAvailable {
    return [SSProcessorInfo floorCountingAvailable];
}

- (NSInteger)numberProcessors {
    return [SSProcessorInfo numberProcessors];
}

- (NSInteger)numberActiveProcessors {
    return [SSProcessorInfo numberActiveProcessors];
}

- (BOOL)accessoriesAttached {
    return [SSProcessorInfo accessoriesAttached];
}

- (BOOL)headphonesAttached {
    return [SSProcessorInfo headphonesAttached];
}

- (NSInteger)numberAttachedAccessories {
    return [SSProcessorInfo numberAttachedAccessories];
}

- (NSString *)nameAttachedAccessories {
    return [SSProcessorInfo nameAttachedAccessories];
}

- (NSString *)carrierName {
    return [SSProcessorInfo carrierName];
}

- (NSString *)carrierCountry {
    return [SSProcessorInfo carrierCountry];
}

- (NSString *)carrierMobileCountryCode {
    return [SSProcessorInfo carrierMobileCountryCode];
}

- (NSString *)carrierISOCountryCode {
    return [SSProcessorInfo carrierISOCountryCode];
}

- (NSString *)carrierMobileNetworkCode {
    return [SSProcessorInfo carrierMobileNetworkCode];
}

- (BOOL)carrierAllowsVOIP {
    return [SSProcessorInfo carrierAllowsVOIP];
}

- (float)batteryLevel {
    return [SSProcessorInfo batteryLevel];
}

- (BOOL)charging {
    return [SSProcessorInfo charging];
}

- (BOOL)fullyCharged {
    return [SSProcessorInfo fullyCharged];
}

- (nullable NSString *)currentIPAddress {
    return [SSNetworkInfo currentIPAddress];
}

- (nullable NSString *)externalIPAddress {
    return [SSNetworkInfo externalIPAddress];
}

- (nullable NSString *)cellIPAddress {
    return [SSNetworkInfo cellIPAddress];
}

- (nullable NSString *)cellNetmaskAddress {
    return [SSNetworkInfo cellNetmaskAddress];
}

- (nullable NSString *)cellBroadcastAddress {
    return [SSNetworkInfo cellBroadcastAddress];
}

- (nullable NSString *)wiFiIPAddress {
    return [SSNetworkInfo wiFiIPAddress];
}

- (nullable NSString *)wiFiNetmaskAddress {
    return [SSNetworkInfo wiFiNetmaskAddress];
}

- (nullable NSString *)wiFiBroadcastAddress {
    return [SSNetworkInfo wiFiBroadcastAddress];
}

- (nullable NSString *)wiFiRouterAddress {
    return [SSNetworkInfo wiFiRouterAddress];
}

- (BOOL)connectedToWiFi {
    return [SSNetworkInfo connectedToWiFi];
}

- (BOOL)connectedToCellNetwork {
    return [SSNetworkInfo connectedToCellNetwork];
}

- (NSString *)country {
    return [SSProcessorInfo country];
}

- (NSString *)language {
    return [SSProcessorInfo language];
}

- (NSString *)timeZoneSS {
    return [SSProcessorInfo timeZone];
}

- (NSString *)currency {
    return [SSProcessorInfo currency];
}

- (NSString *)clipboardContent {
    return [SSProcessorInfo clipboardContent];
}

@end
