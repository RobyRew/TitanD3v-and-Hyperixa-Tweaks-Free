#import "AboutDeviceInfo.h"

@implementation InfoModel

-(id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle icon:(NSString *)icon colour:(UIColor *)colour {
    self = [super init];
    if(self) {
        self.title = title;
        self.subtitle = subtitle;
        self.icon = icon;
        self.colour = colour;
    }
    return self;
}
@end


@implementation AboutDeviceInfo

+(instancetype)sharedInstance {
  static AboutDeviceInfo *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[AboutDeviceInfo alloc] init];
  });
  return sharedInstance;
}

-(id)init {
  return self;
}


-(NSMutableArray *)generalArray {
    
    NSString *DeviceName = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] deviceName]];
    NSString *DeviceModel = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] deviceModel]];
    NSString *SystemName = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] systemName]];
    NSString *SystemVersion = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] systemsVersion]];
    NSString *SystemDeviceTypeFormattedNO = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] systemDeviceTypeNotFormatted]];
    NSString *SystemDeviceTypeFormattedYES = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] systemDeviceTypeFormatted]];
    NSArray *uptimeFormat = [[[SystemServices sharedServices] systemsUptime] componentsSeparatedByString:@" "];
    NSString *UDID = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
    NSString *SystemUptime = [NSString stringWithFormat:@"%@ Days %@ Hours %@ Minutes", [uptimeFormat objectAtIndex:0], [uptimeFormat objectAtIndex:1], [uptimeFormat objectAtIndex:2]];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"Device Name" subtitle:DeviceName icon:@"apps.iphone" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Device Model" subtitle:DeviceModel icon:@"apps.iphone" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"System Name" subtitle:SystemName icon:@"apps.iphone" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"System Version" subtitle:SystemVersion icon:@"apps.iphone" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Model Name Unformatted" subtitle:SystemDeviceTypeFormattedNO icon:@"apps.iphone" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Model Name Formatted" subtitle:SystemDeviceTypeFormattedYES icon:@"apps.iphone" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"UDID" subtitle:UDID icon:@"apps.iphone" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"System Uptime" subtitle:SystemUptime icon:@"apps.iphone" colour:UIColor.indigoColour]];
    
    return array;
}


-(NSMutableArray *)networkArray {

    NSString *WiFiName = [[objc_getClass("SBWiFiManager") sharedInstance] currentNetworkName] ?: @"Not connected";
    NSString *ConnectedToWiFi = ([[SystemServices sharedServices] connectedToWiFi]) ? @"Yes" : @"No";
    NSString *WiFiIPAddress = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] wiFiIPAddress]];
    NSString *WiFiNetmaskAddress = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] wiFiNetmaskAddress]];
    NSString *WiFiBroadcastAddress = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] wiFiBroadcastAddress]];
    NSString *WiFiRouterAddress = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] wiFiRouterAddress]];
    
    NSString *CarrierName = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] carrierName]];
    NSString *ConnectedToCellNetwork = ([[SystemServices sharedServices] connectedToCellNetwork]) ? @"Yes" : @"No";
    NSString *CellIPAddress = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] cellIPAddress]];
    NSString *CarrierCountry = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] carrierCountry]];
    NSString *CarrierMobileCountryCode = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] carrierMobileCountryCode]];
    NSString *CarrierISOCountryCode = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] carrierISOCountryCode]];
    NSString *CarrierMobileNetworkCode = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] carrierMobileNetworkCode]];
    NSString *CarrierAllowsVOIP = ([[SystemServices sharedServices] carrierAllowsVOIP]) ? @"Yes" : @"No";
    NSString *CellNetmaskAddress = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] cellNetmaskAddress]];
    NSString *CellBroadcastAddress = [NSString stringWithFormat:@"%@",[[SystemServices sharedServices] cellBroadcastAddress]];


    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"WiFi Name" subtitle:WiFiName icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Connected to WiFi" subtitle:ConnectedToWiFi icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"WiFi IP Address" subtitle:WiFiIPAddress icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"WiFi Netmask Address" subtitle:WiFiNetmaskAddress icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"WiFi Broadcast Address" subtitle:WiFiBroadcastAddress icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"WiFi Router Address" subtitle:WiFiRouterAddress icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Carrier Name" subtitle:CarrierName icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Connected to Cell Network" subtitle:ConnectedToCellNetwork icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Cell IP Address" subtitle:CellIPAddress icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Carrier Country" subtitle:CarrierCountry icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Carrier Mobile Country" subtitle:CarrierMobileCountryCode icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Carrier ISO Country Code" subtitle:CarrierISOCountryCode icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Carrier Mobile Network Code" subtitle:CarrierMobileNetworkCode icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Carrier Allows VOIP" subtitle:CarrierAllowsVOIP icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Cell Netmask Address" subtitle:CellNetmaskAddress icon:@"wifi" colour:UIColor.tealColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Cell Broadcast Address" subtitle:CellBroadcastAddress icon:@"wifi" colour:UIColor.tealColour]];

    return array;
}


-(NSMutableArray *)batteryArray {

    NSString *BatteryLevel = [NSString stringWithFormat:@"%f%%", [[SystemServices sharedServices] batteryLevel]];
    NSString *Charging = ([[SystemServices sharedServices] charging]) ? @"Yes" : @"No";
    NSString *FullyCharged = ([[SystemServices sharedServices] fullyCharged]) ? @"Yes" : @"No";
    NSString *PluggedIn = ([[SystemServices sharedServices] pluggedIn]) ? @"Yes" : @"No";

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"Battery Level" subtitle:BatteryLevel icon:@"battery.100" colour:UIColor.greenColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Charging" subtitle:Charging icon:@"battery.100" colour:UIColor.greenColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Fully Charged" subtitle:FullyCharged icon:@"battery.100" colour:UIColor.greenColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Plugged In" subtitle:PluggedIn icon:@"battery.100" colour:UIColor.greenColour]];

    return array;
}


-(NSMutableArray *)accessoriesArray {

    NSString *AccessoriesAttached = ([[SystemServices sharedServices] accessoriesAttached]) ? @"Yes" : @"No";
    NSString *HeadphonesAttached = ([[SystemServices sharedServices] headphonesAttached]) ? @"Yes" : @"No";
    NSString *NumberAttachedAccessories = [NSString stringWithFormat:@"%ld", (long)[[SystemServices sharedServices] numberAttachedAccessories]];
    NSString *NameAttachedAccessories = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] nameAttachedAccessories]];
    
    NSString *name;
    
    if ([NameAttachedAccessories isEqualToString:@"(null)"]) {
        name = @"None";
    } else {
        name = NameAttachedAccessories;
    }

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"Accessories Attached" subtitle:AccessoriesAttached icon:@"headphones" colour:UIColor.pinkColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Headphones Attached" subtitle:HeadphonesAttached icon:@"headphones" colour:UIColor.pinkColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Number of Attached Accessories" subtitle:NumberAttachedAccessories icon:@"headphones" colour:UIColor.pinkColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Name of Attached Accessories" subtitle:name icon:@"headphones" colour:UIColor.pinkColour]];

    return array;
}


-(NSMutableArray *)screenArray {

    NSString *ScreenBrightness = [NSString stringWithFormat:@"%.0f%%", [[SystemServices sharedServices] screenBrightness]];
    NSString *ScreenWidth = [NSString stringWithFormat:@"%ld Pts", (long)[[SystemServices sharedServices] screenWidth]];
    NSString *ScreenHeight = [NSString stringWithFormat:@"%ld Pts", (long)[[SystemServices sharedServices] screenHeight]];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"Screen Brightness" subtitle:ScreenBrightness icon:@"iphone" colour:UIColor.yellowColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Screen Width" subtitle:ScreenWidth icon:@"iphone" colour:UIColor.yellowColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Screen Height" subtitle:ScreenHeight icon:@"iphone" colour:UIColor.yellowColour]];

    return array;
}


-(NSMutableArray *)processorArray {

    NSString *NumberProcessors = [NSString stringWithFormat:@"%ld", (long)[[SystemServices sharedServices] numberProcessors]];
    NSString *NumberActiveProcessors = [NSString stringWithFormat:@"%ld", (long)[[SystemServices sharedServices] numberActiveProcessors]];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"Number of Processors" subtitle:NumberProcessors icon:@"chart.bar.xaxis" colour:UIColor.redColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Number of Active Processors" subtitle:NumberActiveProcessors icon:@"chart.bar.xaxis" colour:UIColor.redColour]];

    return array;
}


-(NSMutableArray *)motionArray {

    NSString *MultitaskingEnabled = ([[SystemServices sharedServices] multitaskingEnabled]) ? @"Yes" : @"No";
    NSString *ProximitySensorEnabled = ([[SystemServices sharedServices] proximitySensorEnabled]) ? @"Yes" : @"No";
    NSString *stepCountingAvailable = ([[SystemServices sharedServices] stepCountingAvailable]) ? @"Yes" : @"No";
    NSString *distanceAvailable = ([[SystemServices sharedServices] distanceAvailable]) ? @"Yes" : @"No";
    NSString *floorCountingAvailable = ([[SystemServices sharedServices] floorCountingAvailable]) ? @"Yes" : @"No";

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"Multitasking" subtitle:MultitaskingEnabled icon:@"figure.walk" colour:UIColor.orangeColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Proximity Sensor" subtitle:ProximitySensorEnabled icon:@"figure.walk" colour:UIColor.orangeColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Step Counting Available" subtitle:stepCountingAvailable icon:@"figure.walk" colour:UIColor.orangeColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Distance Available" subtitle:distanceAvailable icon:@"figure.walk" colour:UIColor.orangeColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Floor Counting Available" subtitle:floorCountingAvailable icon:@"figure.walk" colour:UIColor.orangeColour]];

    return array;
}


-(NSMutableArray *)localisationArray {

    NSString *Country = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] country]];
    NSString *Language = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] language]];
    NSString *TimeZone = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] timeZoneSS]];
    NSString *Currency = [NSString stringWithFormat:@"%@", [[SystemServices sharedServices] currency]];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"Country" subtitle:Country icon:@"coloncurrencysign.circle.fill" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Language" subtitle:Language icon:@"coloncurrencysign.circle.fill" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"TimeZone" subtitle:TimeZone icon:@"coloncurrencysign.circle.fill" colour:UIColor.indigoColour]];
    [array addObject:[[InfoModel alloc] initWithTitle:@"Currency" subtitle:Currency icon:@"coloncurrencysign.circle.fill" colour:UIColor.indigoColour]];

    return array;
}


-(NSMutableArray *)debugArray {

    NSString *DebuggerAttached = ([[SystemServices sharedServices] debuggerAttached]) ? @"Yes" : @"No";
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:[[InfoModel alloc] initWithTitle:@"Debugger Attached" subtitle:DebuggerAttached icon:@"ant.fill" colour:UIColor.tealColour]];


    return array;
}

@end


