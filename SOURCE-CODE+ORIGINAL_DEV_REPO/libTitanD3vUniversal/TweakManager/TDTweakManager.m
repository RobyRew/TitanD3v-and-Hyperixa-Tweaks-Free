#import "TDTweakManager.h"

@implementation TDTweakManager

+(instancetype)sharedInstance {
  static TDTweakManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[TDTweakManager alloc] init];
  });
  return sharedInstance;
}

-(id)init {
  return self;
}


- (void)setBool:(BOOL)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
    [settings2 setObject:[NSNumber numberWithBool:anObject] forKey:aKey];
    [settings2 writeToFile:prefPath2 atomically:YES];
  }
}

- (void)setObject:(id)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
    [settings2 setObject:anObject forKey:aKey];
    [settings2 writeToFile:prefPath2 atomically:YES];
  }
}

- (void)setFloat:(long long)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
    [settings2 setObject:@(anObject) forKey:aKey];
    [settings2 writeToFile:prefPath2 atomically:YES];
  }
}

- (void)setInt:(int)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
    [settings2 setObject:@(anObject) forKey:aKey];
    [settings2 writeToFile:prefPath2 atomically:YES];
  }
}

- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  if([settings2 objectForKey:aKey] == NULL){
    return defaultValue;
  }
  return [[settings2 objectForKey:aKey] boolValue];
}

- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  return [settings2 objectForKey:aKey]?:defaultValue;
}

- (long long)floatForKey:(id)aKey defaultValue:(long long)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  return [[settings2 objectForKey:aKey] longLongValue]?:defaultValue;
}

- (int)intForKey:(id)aKey defaultValue:(int)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  return [[settings2 objectForKey:aKey] intValue]?:defaultValue;
}

- (bool)boolForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  return [[settings2 objectForKey:aKey] boolValue];
}

- (id)objectForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  return [settings2 objectForKey:aKey];
}

- (long long)floatForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  return [[settings2 objectForKey:aKey] longLongValue];
}

- (int)intForKey:(id)aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  return [[settings2 objectForKey:aKey] intValue];
}

- (UIColor *)colourForKey:(id)aKey defaultValue:(id)defaultValue ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  NSString *colourString = [settings2 objectForKey:aKey]?:defaultValue;
  UIColor *color = colorFromHexString(colourString);
  return color;
}

- (UIColor *)systemColourForKey:(id)aKey defaultColour:(UIColor *)defaultColour ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
  }
  NSData *decodedData = [settings2 objectForKey:aKey];
  UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData]?:defaultColour;
  return color;
}

- (void)removeObjectForKey:aKey ID:(NSString*)bundleIdentifier {
  NSMutableDictionary *settings2 = [NSMutableDictionary dictionary];
  NSString *BID = bundleIdentifier;
  if ([BID isEqualToString:bundleIdentifier]) {
    NSString *prefPath2 = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIdentifier];
    [settings2 addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath2]];
    [settings2 removeObjectForKey:aKey];
    [settings2 writeToFile:prefPath2 atomically:YES];
  }
}

@end
