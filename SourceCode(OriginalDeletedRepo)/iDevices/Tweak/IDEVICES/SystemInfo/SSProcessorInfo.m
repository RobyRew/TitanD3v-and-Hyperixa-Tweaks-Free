#import "SSProcessorInfo.h"


@implementation SSProcessorInfo


+ (NSInteger)numberProcessors {
    // See if the process info responds to selector
    if ([[NSProcessInfo processInfo] respondsToSelector:@selector(processorCount)]) {
        // Get the number of processors
        NSInteger processorCount = [[NSProcessInfo processInfo] processorCount];
        // Return the number of processors
        return processorCount;
    } else {
        // Return -1 (not found)
        return -1;
    }
}


+ (NSInteger)numberActiveProcessors {
    // See if the process info responds to selector
    if ([[NSProcessInfo processInfo] respondsToSelector:@selector(activeProcessorCount)]) {
        // Get the number of active processors
        NSInteger activeprocessorCount = [[NSProcessInfo processInfo] activeProcessorCount];
        // Return the number of active processors
        return activeprocessorCount;
    } else {
        // Return -1 (not found)
        return -1;
    }
}


+ (NSArray *)processorsUsage {
    
    // Try to get Processor Usage Info
    @try {
        // Variables
        processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
        mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
        unsigned _numCPUs;
        NSLock *_cpuUsageLock;
        
        // Get the number of processors from sysctl
        int _mib[2U] = { CTL_HW, HW_NCPU };
        size_t _sizeOfNumCPUs = sizeof(_numCPUs);
        int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
        if (_status)
            _numCPUs = 1;
        
        // Allocate the lock
        _cpuUsageLock = [[NSLock alloc] init];
        
        // Get the processor info
        natural_t _numCPUsU = 0U;
        kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
        if (err == KERN_SUCCESS) {
            [_cpuUsageLock lock];
            
            // Go through info for each processor
            NSMutableArray *processorInfo = [NSMutableArray new];
            for (unsigned i = 0U; i < _numCPUs; ++i) {
                Float32 _inUse, _total;
                if (_prevCPUInfo) {
                    _inUse = (
                              (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                              + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                              + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                              );
                    _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
                } else {
                    _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                    _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
                }
                // Add to the processor usage info
                [processorInfo addObject:@(_inUse / _total)];
            }
            
            [_cpuUsageLock unlock];
            if (_prevCPUInfo) {
                size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
                vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
            }
            // Retrieved processor information
            return processorInfo;
        } else {
            // Unable to get processor information
            return nil;
        }
    } @catch (NSException *exception) {
        // Getting processor information failed
        return nil;
    }
}


// Country
+ (NSString *)country {
    // Get the user's country
    @try {
        // Get the locale
        NSLocale *locale = [NSLocale currentLocale];
        // Get the country from the locale
        NSString *country = [locale localeIdentifier];
        // Check for validity
        if (country == nil || country.length <= 0) {
            // Error, invalid country
            return nil;
        }
        // Completed Successfully
        return country;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}

// Language
+ (NSString *)language {
    // Get the user's language
    @try {
        // Get the list of languages
        NSArray *languageArray = [NSLocale preferredLanguages];
        // Get the user's language
        NSString *language = [languageArray objectAtIndex:0];
        // Check for validity
        if (language == nil || language.length <= 0) {
            // Error, invalid language
            return nil;
        }
        // Completed Successfully
        return language;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}

// TimeZone
+ (NSString *)timeZone {
    // Get the user's timezone
    @try {
        // Get the system timezone
        NSTimeZone *localTime = [NSTimeZone systemTimeZone];
        // Convert the time zone to a string
        NSString *timeZone = [localTime name];
        // Check for validity
        if (timeZone == nil || timeZone.length <= 0) {
            // Error, invalid TimeZone
            return nil;
        }
        // Completed Successfully
        return timeZone;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}

// Currency Symbol
+ (NSString *)currency {
    // Get the user's currency
    @try {
        // Get the system currency
        NSString *currency = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
        // Check for validity
        if (currency == nil || currency.length <= 0) {
            // Error, invalid Currency
            return nil;
        }
        // Completed Successfully
        return currency;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}


+ (NSString *)systemUptime {
    // Set up the days/hours/minutes
    NSNumber *days, *hours, *minutes;
    
    // Get the info about a process
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    // Get the uptime of the system
    NSTimeInterval uptimeInterval = [processInfo systemUptime];
    // Get the calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Create the Dates
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:(0-uptimeInterval)];
    unsigned int unitFlags = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date toDate:[NSDate date]  options:0];
    
    // Get the day, hour and minutes
    days = [NSNumber numberWithLong:[components day]];
    hours = [NSNumber numberWithLong:[components hour]];
    minutes = [NSNumber numberWithLong:[components minute]];
    
    // Format the dates
    NSString *uptime = [NSString stringWithFormat:@"%@ %@ %@",
                        [days stringValue],
                        [hours stringValue],
                        [minutes stringValue]];
    
    // Error checking
    if (!uptime) {
        // No uptime found
        // Return nil
        return nil;
    }
    
    // Return the uptime
    return uptime;
}

// Model of Device
+ (NSString *)deviceModel {
    // Get the device model
    if ([[UIDevice currentDevice] respondsToSelector:@selector(model)]) {
        // Make a string for the device model
        NSString *deviceModel = [[UIDevice currentDevice] model];
        // Set the output to the device model
        return deviceModel;
    } else {
        // Device model not found
        return nil;
    }
}

// Device Name
+ (NSString *)deviceName {
    // Get the current device name
    if ([[UIDevice currentDevice] respondsToSelector:@selector(name)]) {
        // Make a string for the device name
        NSString *deviceName = [[UIDevice currentDevice] name];
        // Set the output to the device name
        return deviceName;
    } else {
        // Device name not found
        return nil;
    }
}

// System Name
+ (NSString *)systemName {
    // Get the current system name
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemName)]) {
        // Make a string for the system name
        NSString *systemName = [[UIDevice currentDevice] systemName];
        // Set the output to the system name
        return systemName;
    } else {
        // System name not found
        return nil;
    }
}

// System Version
+ (NSString *)systemVersion {
    // Get the current system version
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemVersion)]) {
        // Make a string for the system version
        NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
        // Set the output to the system version
        return systemVersion;
    } else {
        // System version not found
        return nil;
    }
}

// System Device Type (iPhone1,0) (Formatted = iPhone 1)
+ (NSString *)systemDeviceTypeFormatted:(BOOL)formatted {
    // Set up a Device Type String
    NSString *deviceType;
    
    // Check if it should be formatted
    if (formatted) {
        // Formatted
        @try {
            // Set up a new Device Type String
            NSString *newDeviceType;
            // Set up a struct
            struct utsname dt;
            // Get the system information
            uname(&dt);
            // Set the device type to the machine type
            deviceType = [NSString stringWithFormat:@"%s", dt.machine];
            
            if ([deviceType isEqualToString:@"iPhone8,1"])
                newDeviceType = @"iPhone 6s";
            else if ([deviceType isEqualToString:@"iPhone8,2"])
                newDeviceType = @"iPhone 6s Plus";
            else if ([deviceType isEqualToString:@"iPhone8,4"])
                newDeviceType = @"iPhone SE";
            else if ([deviceType isEqualToString:@"iPhone9,1"])
                newDeviceType = @"iPhone 7 (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone9,3"])
                newDeviceType = @"iPhone 7 (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone9,2"])
                newDeviceType = @"iPhone 7 Plus (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone9,4"])
                newDeviceType = @"iPhone 7 Plus (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,1"])
                newDeviceType = @"iPhone 8 (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,2"])
                newDeviceType = @"iPhone 8 Plus (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,3"])
                newDeviceType = @"iPhone X (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,4"])
                newDeviceType = @"iPhone 8 (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,5"])
                newDeviceType = @"iPhone 8 Plus (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,6"])
                newDeviceType = @"iPhone X (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone11,2"])
                newDeviceType = @"iPhone XS";
            else if ([deviceType isEqualToString:@"iPhone11,4"])
                newDeviceType = @"iPhone XS MAX";
            else if ([deviceType isEqualToString:@"iPhone11,6"])
                newDeviceType = @"iPhone XS MAX (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone11,8"])
                newDeviceType = @"iPhone XR";
            else if ([deviceType isEqualToString:@"iPhone12,1"])
                newDeviceType = @"iPhone 11";
            else if ([deviceType isEqualToString:@"iPhone12,3"])
                newDeviceType = @"iPhone 11 Pro";
            else if ([deviceType isEqualToString:@"iPhone12,5"])
                newDeviceType = @"iPhone 11 Pro Max";
            else if ([deviceType isEqualToString:@"iPhone12,8"])
                newDeviceType = @"iPhone SE 2nd Gen";
            else if ([deviceType isEqualToString:@"iPhone13,1"])
                newDeviceType = @"iPhone 12 Mini";
            else if ([deviceType isEqualToString:@"iPhone13,2"])
                newDeviceType = @"iPhone 12";
            else if ([deviceType isEqualToString:@"iPhone13,3"])
                newDeviceType = @"iPhone 12 Pro";
            else if ([deviceType isEqualToString:@"iPhone13,4"])
                newDeviceType = @"iPhone 12 Pro Max";
            else if ([deviceType isEqualToString:@"iPhone14,2"])
                newDeviceType = @"iPhone 13 Pro";
            else if ([deviceType isEqualToString:@"iPhone14,3"])
                newDeviceType = @"iPhone 13 Pro Max";
            else if ([deviceType isEqualToString:@"iPhone14,4"])
                newDeviceType = @"iPhone 13 Mini";
            else if ([deviceType isEqualToString:@"iPhone14,5"])
                newDeviceType = @"iPhone 13";
            
            
            
            // Return the new device type
            return newDeviceType;
        }
        @catch (NSException *exception) {
            // Error
            return nil;
        }
    } else {
        // Unformatted
        @try {
            // Set up a struct
            struct utsname dt;
            // Get the system information
            uname(&dt);
            // Set the device type to the machine type
            deviceType = [NSString stringWithFormat:@"%s", dt.machine];
            
            // Return the device type
            return deviceType;
        }
        @catch (NSException *exception) {
            // Error
            return nil;
        }
    }
}

// Get the Screen Width (X)
+ (NSInteger)screenWidth {
    // Get the screen width
    @try {
        // Screen bounds
        CGRect Rect = [[UIScreen mainScreen] bounds];
        // Find the width (X)
        NSInteger Width = Rect.size.width;
        // Verify validity
        if (Width <= 0) {
            // Invalid Width
            return -1;
        }
        
        // Successful
        return Width;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Get the Screen Height (Y)
+ (NSInteger)screenHeight {
    // Get the screen height
    @try {
        // Screen bounds
        CGRect Rect = [[UIScreen mainScreen] bounds];
        // Find the Height (Y)
        NSInteger Height = Rect.size.height;
        // Verify validity
        if (Height <= 0) {
            // Invalid Height
            return -1;
        }
        
        // Successful
        return Height;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Get the Screen Brightness
+ (float)screenBrightness {
    // Get the screen brightness
    @try {
        // Brightness
        float brightness = [UIScreen mainScreen].brightness;
        // Verify validity
        if (brightness < 0.0 || brightness > 1.0) {
            // Invalid brightness
            return -1;
        }
        
        // Successful
        return (brightness * 100);
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Multitasking enabled?
+ (BOOL)multitaskingEnabled {
    // Is multitasking enabled?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        // Create a bool
        BOOL MultitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
        // Return the value
        return MultitaskingSupported;
    } else {
        // Doesn't respond to selector
        return false;
    }
}

// Proximity sensor enabled?
+ (BOOL)proximitySensorEnabled {
    // Is the proximity sensor enabled?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setProximityMonitoringEnabled:)]) {
        // Create a UIDevice variable
        UIDevice *device = [UIDevice currentDevice];
        
        // Make a Bool for the proximity Sensor
        BOOL ProximitySensor;
        
        // Turn the sensor on, if not already on, and see if it works
        if (device.proximityMonitoringEnabled != YES) {
            // Sensor is off
            // Turn it on
            [device setProximityMonitoringEnabled:YES];
            // See if it turned on
            if (device.proximityMonitoringEnabled == YES) {
                // It turned on!  Turn it off
                [device setProximityMonitoringEnabled:NO];
                // It works
                ProximitySensor = true;
            } else {
                // Didn't turn on, no good
                ProximitySensor = false;
            }
        } else {
            // Sensor is already on
            ProximitySensor = true;
        }
        
        // Return on or off
        return ProximitySensor;
    } else {
        // Doesn't respond to selector
        return false;
    }
}

// Debugging attached?
+ (BOOL)debuggerAttached {
    // Is the debugger attached?
    @try {
        // Set up the variables
        int                 ret;
        int                 mib[4];
        struct kinfo_proc   info;
        size_t              size;
        info.kp_proc.p_flag = 0;
        mib[0] = CTL_KERN;
        mib[1] = KERN_PROC;
        mib[2] = KERN_PROC_PID;
        mib[3] = getpid();
        size = sizeof(info);
        ret = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
        
        // Verify ret
        if (ret) {
            // Sysctl() failed
            // Return the output of sysctl
            return ret;
        }
        
        // Return whether the process is being traced or not
        return ( (info.kp_proc.p_flag & P_TRACED) != 0 );
        
    }
    @catch (NSException *exception) {
        // Error
        return false;
    }
}

// Plugged In?
+ (BOOL)pluggedIn {
    // Is the device plugged in?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(batteryState)]) {
        // Create a bool
        BOOL PluggedIn;
        // Set the battery monitoring enabled
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        // Get the battery state
        UIDeviceBatteryState batteryState = [UIDevice currentDevice].batteryState;
        // Check if it's plugged in or finished charging
        if (batteryState == UIDeviceBatteryStateCharging || batteryState == UIDeviceBatteryStateFull) {
            // We're plugged in
            PluggedIn = true;
        } else {
            PluggedIn = false;
        }
        // Return the value
        return PluggedIn;
    } else {
        // Doesn't respond to selector
        return false;
    }
}

// Step-Counting Available?
+ (BOOL)stepCountingAvailable {
    @try {
        // Make sure the Pedometer class exists
        if ([CMPedometer class]) {
            // Make sure the selector exists
            if ([CMPedometer respondsToSelector:@selector(isStepCountingAvailable)]) {
                // Return whether it's available
                return [CMPedometer isStepCountingAvailable];
            }
        }
        // Not available
        return false;
    }
    @catch (NSException *exception) {
        // Error
        return false;
    }
}

// Distance Available
+ (BOOL)distanceAvailable {
    @try {
        // Make sure the Pedometer class exists
        if ([CMPedometer class]) {
            // Make sure the selector exists
            if ([CMPedometer respondsToSelector:@selector(isDistanceAvailable)]) {
                // Return whether it's available
                return [CMPedometer isDistanceAvailable];
            }
        }
        // Not available
        return false;
    }
    @catch (NSException *exception) {
        // Error
        return false;
    }
}

// Floor Counting Available
+ (BOOL)floorCountingAvailable {
    @try {
        // Make sure the Pedometer class exists
        if ([CMPedometer class]) {
            // Make sure the selector exists
            if ([CMPedometer respondsToSelector:@selector(isFloorCountingAvailable)]) {
                // Return whether it's available
                return [CMPedometer isFloorCountingAvailable];
            }
        }
        // Not available
        return false;
    }
    @catch (NSException *exception) {
        // Error
        return false;
    }
}


+ (NSString *)carrierName {
    // Get the carrier name
    @try {
        // Get the Telephony Network Info
        CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
        // Get the carrier
        CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
        // Get the carrier name
        NSString *carrierName = [carrier carrierName];
        
        // Check to make sure it's valid
        if (carrierName == nil || carrierName.length <= 0) {
            // Return unknown
            return nil;
        }
        
        // Return the name
        return carrierName;
    }
    @catch (NSException *exception) {
        // Error finding the name
        return nil;
    }
}

// Carrier Country
+ (NSString *)carrierCountry {
    // Get the country that the carrier is located in
    @try {
        // Get the locale
        NSLocale *currentCountry = [NSLocale currentLocale];
        // Get the country Code
        NSString *country = [currentCountry objectForKey:NSLocaleCountryCode];
        // Check if it returned anything
        if (country == nil || country.length <= 0) {
            // No country found
            return nil;
        }
        // Return the country
        return country;
    }
    @catch (NSException *exception) {
        // Failed, return nil
        return nil;
    }
}

// Carrier Mobile Country Code
+ (NSString *)carrierMobileCountryCode {
    // Get the carrier mobile country code
    @try {
        // Get the Telephony Network Info
        CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
        // Get the carrier
        CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
        // Get the carrier mobile country code
        NSString *carrierCode = [carrier mobileCountryCode];
        
        // Check to make sure it's valid
        if (carrierCode == nil || carrierCode.length <= 0) {
            // Return unknown
            return nil;
        }
        
        // Return the name
        return carrierCode;
    }
    @catch (NSException *exception) {
        // Error finding the name
        return nil;
    }
}

// Carrier ISO Country Code
+ (NSString *)carrierISOCountryCode {
    // Get the carrier ISO country code
    @try {
        // Get the Telephony Network Info
        CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
        // Get the carrier
        CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
        // Get the carrier ISO country code
        NSString *carrierCode = [carrier isoCountryCode];
        
        // Check to make sure it's valid
        if (carrierCode == nil || carrierCode.length <= 0) {
            // Return unknown
            return nil;
        }
        
        // Return the name
        return carrierCode;
    }
    @catch (NSException *exception) {
        // Error finding the name
        return nil;
    }
}

// Carrier Mobile Network Code
+ (NSString *)carrierMobileNetworkCode {
    // Get the carrier mobile network code
    @try {
        // Get the Telephony Network Info
        CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
        // Get the carrier
        CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
        // Get the carrier mobile network code
        NSString *carrierCode = [carrier mobileNetworkCode];
        
        // Check to make sure it's valid
        if (carrierCode == nil || carrierCode.length <= 0) {
            // Return unknown
            return nil;
        }
        
        // Return the name
        return carrierCode;
    }
    @catch (NSException *exception) {
        // Error finding the name
        return nil;
    }
}

// Carrier Allows VOIP
+ (BOOL)carrierAllowsVOIP {
    // Check if the carrier allows VOIP
    @try {
        // Get the Telephony Network Info
        CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
        // Get the carrier
        CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
        // Get the carrier VOIP Status
        BOOL carrierVOIP = [carrier allowsVOIP];
        
        // Return the VOIP Status
        return carrierVOIP;
    }
    @catch (NSException *exception) {
        // Error finding the VOIP Status
        return false;
    }
}


+ (float)batteryLevel {
    // Find the battery level
    @try {
        // Get the device
        UIDevice *device = [UIDevice currentDevice];
        // Set battery monitoring on
        device.batteryMonitoringEnabled = YES;
        
        // Set up the battery level float
        float batteryLevel = 0.0;
        // Get the battery level
        float batteryCharge = [device batteryLevel];
        
        // Check to make sure the battery level is more than zero
        if (batteryCharge > 0.0f) {
            // Make the battery level float equal to the charge * 100
            batteryLevel = batteryCharge * 100;
        } else {
            // Unable to find the battery level
            return -1;
        }
        
        // Output the battery level
        return batteryLevel;
    }
    @catch (NSException *exception) {
        // Error out
        return -1;
    }
}

// Charging?
+ (BOOL)charging {
    // Is the battery charging?
    @try {
        // Get the device
        UIDevice *device = [UIDevice currentDevice];
        // Set battery monitoring on
        device.batteryMonitoringEnabled = YES;
        
        // Check the battery state
        if ([device batteryState] == UIDeviceBatteryStateCharging || [device batteryState] == UIDeviceBatteryStateFull) {
            // Device is charging
            return true;
        } else {
            // Device is not charging
            return false;
        }
    }
    @catch (NSException *exception) {
        // Error out
        return false;
    }
}

// Fully Charged?
+ (BOOL)fullyCharged {
    // Is the battery fully charged?
    @try {
        // Get the device
        UIDevice *device = [UIDevice currentDevice];
        // Set battery monitoring on
        device.batteryMonitoringEnabled = YES;
        
        // Check the battery state
        if ([device batteryState] == UIDeviceBatteryStateFull) {
            // Device is fully charged
            return true;
        } else {
            // Device is not fully charged
            return false;
        }
    }
    @catch (NSException *exception) {
        // Error out
        return false;
    }
}


+ (NSString *)clipboardContent {
    // Get the string content of the clipboard (copy, paste)
    @try {
        // Get the Pasteboard
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        // Get the string value of the pasteboard
        NSString *clipboardContent = [pasteBoard string];
        // Check for validity
        if (clipboardContent == nil || clipboardContent.length <= 0) {
            // Error, invalid pasteboard
            return nil;
        }
        // Successful
        return clipboardContent;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}


// Are any accessories attached?
+ (BOOL)accessoriesAttached {
    // Check if any accessories are connected
    @try {
        // Set up the accessory manger
        EAAccessoryManager *accessoryManager = [EAAccessoryManager sharedAccessoryManager];
        // Get the number of accessories connected
        int numberOfAccessoriesConnected = (int)[accessoryManager.connectedAccessories count];
        // Check if there are any connected
        if (numberOfAccessoriesConnected > 0) {
            // There are accessories connected
            return true;
        } else {
            // There are no accessories connected
            return false;
        }
    }
    @catch (NSException *exception) {
        // Error, return false
        return false;
    }
}

// Are headphone attached?
+ (BOOL)headphonesAttached {
    // Check if the headphones are connected
    @try {
        // Get the audiosession route information
        AVAudioSessionRouteDescription *route = [[AVAudioSession sharedInstance] currentRoute];
        
        // Run through all the route outputs
        for (AVAudioSessionPortDescription *desc in [route outputs]) {
            
            // Check if any of the ports are equal to the string headphones
            if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones]) {
                
                // Return YES
                return YES;
            }
        }
        
        // No headphones attached
        return NO;
    }
    @catch (NSException *exception) {
        // Error, return false
        return false;
    }
}

// Number of attached accessories
+ (NSInteger)numberAttachedAccessories {
    // Get the number of attached accessories
    @try {
        // Set up the accessory manger
        EAAccessoryManager *accessoryManager = [EAAccessoryManager sharedAccessoryManager];
        // Get the number of accessories connected
        int numberOfAccessoriesConnected = (int)[accessoryManager.connectedAccessories count];
        // Return how many accessories are attached
        return numberOfAccessoriesConnected;
    }
    @catch (NSException *exception) {
        // Error, return false
        return false;
    }
}

// Name of attached accessory/accessories (seperated by , comma's)
+ (NSString *)nameAttachedAccessories {
    // Get the name of the attached accessories
    @try {
        // Set up the accessory manger
        EAAccessoryManager *accessoryManager = [EAAccessoryManager sharedAccessoryManager];
        // Set up an accessory (for later use)
        EAAccessory *accessory;
        // Get the number of accessories connected
        int numberOfAccessoriesConnected = (int)[accessoryManager.connectedAccessories count];
        
        // Check to make sure there are accessories connected
        if (numberOfAccessoriesConnected > 0) {
            // Set up a string for all the accessory names
            NSString *allAccessoryNames = @"";
            // Set up a string for the accessory names
            NSString *accessoryName;
            // Get the accessories
            NSArray *accessoryArray = accessoryManager.connectedAccessories;
            // Run through all the accessories
            for (int x = 0; x < numberOfAccessoriesConnected; x++) {
                // Get the accessory at that index
                accessory = [accessoryArray objectAtIndex:x];
                // Get the name of it
                accessoryName = [accessory name];
                // Make sure there is a name
                if (accessoryName == nil || accessoryName.length == 0) {
                    // If there isn't, try and get the manufacturer name
                    accessoryName = [accessory manufacturer];
                }
                // Make sure there is a manufacturer name
                if (accessoryName == nil || accessoryName.length == 0) {
                    // If there isn't a manufacturer name still
                    accessoryName = @"Unknown";
                }
                // Format that name
                allAccessoryNames = [allAccessoryNames stringByAppendingFormat:@"%@", accessoryName];
                if (x < numberOfAccessoriesConnected - 1) {
                    allAccessoryNames = [allAccessoryNames stringByAppendingFormat:@", "];
                }
            }
            // Return the name/s of the connected accessories
            return allAccessoryNames;
        } else {
            // No accessories connected
            return nil;
        }
    }
    @catch (NSException *exception) {
        // Error, return false
        return nil;
    }
}

@end
