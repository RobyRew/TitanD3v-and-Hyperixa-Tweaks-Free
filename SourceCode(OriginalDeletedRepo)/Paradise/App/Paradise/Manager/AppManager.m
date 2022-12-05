#import "AppManager.h"

static NSString *prefPath = @"/var/mobile/Library/Preferences/com.TitanD3v.ParadiseEditor.plist";
static NSMutableDictionary *settings;

@implementation AppManager

+(instancetype)sharedInstance {
  static AppManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[AppManager alloc] init];
    settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  });
  return sharedInstance;
}

-(id)init {
  return self;
}

- (void)setBool:(BOOL)anObject forKey:(id)aKey {
  [settings setObject:[NSNumber numberWithBool:anObject] forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (void)setObject:(id)anObject forKey:(id)aKey {
  [settings setObject:anObject forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (void)setFloat:(long long)anObject forKey:(id)aKey {
  [settings setObject:@(anObject) forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (void)setInt:(int)anObject forKey:(id)aKey {
  [settings setObject:@(anObject) forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue {
  if([settings objectForKey:aKey] == NULL){
    return defaultValue;
  }
  return [[settings objectForKey:aKey] boolValue];
}

- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue {
  return [settings objectForKey:aKey]?:defaultValue;
}

- (long long)floatForKey:(id)aKey defaultValue:(long long)defaultValue {
  return [[settings objectForKey:aKey] longLongValue]?:defaultValue;
}

- (int)intForKey:(id)aKey defaultValue:(int)defaultValue {
  return [[settings objectForKey:aKey] intValue]?:defaultValue;
}

- (bool)boolForKey:(id)aKey {
  return [[settings objectForKey:aKey] boolValue];
}

- (id)objectForKey:(id)aKey {
  return [settings objectForKey:aKey];
}

- (long long)floatForKey:(id)aKey {
  return [[settings objectForKey:aKey] longLongValue];
}

- (int)intForKey:(id)aKey {
  return [[settings objectForKey:aKey] intValue];
}

@end
