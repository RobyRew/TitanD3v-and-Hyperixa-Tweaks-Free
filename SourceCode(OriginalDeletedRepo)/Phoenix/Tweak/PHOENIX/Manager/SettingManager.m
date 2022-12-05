#import "SettingManager.h"

@implementation SettingManager

+(instancetype)sharedInstance {
  static SettingManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[SettingManager alloc] init];
  });
  return sharedInstance;
}

-(id)init {
  return self;
}

- (void)setBool:(BOOL)anObject forKey:(id)aKey {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  [settings setObject:[NSNumber numberWithBool:anObject] forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (void)setObject:(id)anObject forKey:(id)aKey {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  [settings setObject:anObject forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
  NSLog(@"Write image data...");
}

- (void)setFloat:(long long)anObject forKey:(id)aKey {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  [settings setObject:@(anObject) forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (void)setInt:(int)anObject forKey:(id)aKey {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  [settings setObject:@(anObject) forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  if([settings objectForKey:aKey] == NULL){
    return defaultValue;
  }
  return [[settings objectForKey:aKey] boolValue];
}

- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  return [settings objectForKey:aKey]?:defaultValue;
}

- (long long)floatForKey:(id)aKey defaultValue:(long long)defaultValue {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  return [[settings objectForKey:aKey] longLongValue]?:defaultValue;
}

- (int)intForKey:(id)aKey defaultValue:(int)defaultValue {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  return [[settings objectForKey:aKey] intValue]?:defaultValue;
}

- (bool)boolForKey:(id)aKey {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  return [[settings objectForKey:aKey] boolValue];
}

- (id)objectForKey:(id)aKey {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  return [settings objectForKey:aKey];
}

- (long long)floatForKey:(id)aKey {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  return [[settings objectForKey:aKey] longLongValue];
}

- (int)intForKey:(id)aKey {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  return [[settings objectForKey:aKey] intValue];
}


- (UIColor *)systemColourForKey:(id)aKey defaultColour:(UIColor *)defaultColour {
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *prefPath = [NSString stringWithFormat:@"%@/PhoenixSettings.plist", aDocumentsDirectory];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  NSData *decodedData = [settings objectForKey:aKey];
  UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData]?:defaultColour;
  return color;
}


-(UIColor *)accentColour {
  UIColor *customColour = [self colorWithHexString:[self objectForKey:@"accentColour" defaultValue:@"007AFF"]];
  return customColour;
}


-(UIColor *)callButtonColour {
  UIColor *customColour = [self colorWithHexString:[self objectForKey:@"callButtonColour" defaultValue:@"35C759"]];
  return customColour;
}


-(UIColor *)messageButtonColour {
  UIColor *customColour = [self colorWithHexString:[self objectForKey:@"messageButtonColour" defaultValue:@"007AFF"]];
  return customColour;
}


-(UIColor *)emailButtonColour {
  UIColor *customColour = [self colorWithHexString:[self objectForKey:@"emailButtonColour" defaultValue:@"31ADE6"]];
  return customColour;
}


-(UIColor *)deleteButtonColour {
  UIColor *customColour = [self colorWithHexString:[self objectForKey:@"deleteButtonColour" defaultValue:@"FF3C2F"]];
  return customColour;
}


-(UIColor *)colorWithHexString:(NSString*)hex {

  NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

  if ([cString length] < 6) return [UIColor grayColor];

  if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];

  if ([cString length] != 6) return  [UIColor grayColor];

  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];

  range.location = 2;
  NSString *gString = [cString substringWithRange:range];

  range.location = 4;
  NSString *bString = [cString substringWithRange:range];

  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];

  return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


-(UIImage *)icloudAvatar {
  UIImage *avatar;
  NSString *prefPath = @"/var/mobile/Library/Preferences/com.TitanD3v.PhoenixPrefs.plist";
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  NSData *imageData = [settings objectForKey:@"meCardAvatar"];
  avatar = [UIImage imageWithData:imageData];;
  return avatar;
}


-(NSString *)icloudFullName {
  NSString *name;
  NSString *prefPath = @"/var/mobile/Library/Preferences/com.TitanD3v.PhoenixPrefs.plist";
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  name = [settings objectForKey:@"meCardFullName"];
  return name;
}


@end
