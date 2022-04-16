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
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:[NSNumber numberWithBool:anObject] forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
}

- (void)setObject:(id)anObject forKey:(id)aKey {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:anObject forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
    NSLog(@"Write image data...");
}

- (void)setFloat:(long long)anObject forKey:(id)aKey {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:@(anObject) forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
}

- (void)setInt:(int)anObject forKey:(id)aKey {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [settings setObject:@(anObject) forKey:aKey];
    [settings writeToFile:prefPath atomically:YES];
}

- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    if([settings objectForKey:aKey] == NULL){
        return defaultValue;
    }
    return [[settings objectForKey:aKey] boolValue];
}

- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    return [settings objectForKey:aKey]?:defaultValue;
}

- (long long)floatForKey:(id)aKey defaultValue:(long long)defaultValue {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    return [[settings objectForKey:aKey] longLongValue]?:defaultValue;
}

- (int)intForKey:(id)aKey defaultValue:(int)defaultValue {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    return [[settings objectForKey:aKey] intValue]?:defaultValue;
}

- (bool)boolForKey:(id)aKey {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    return [[settings objectForKey:aKey] boolValue];
}

- (id)objectForKey:(id)aKey {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    return [settings objectForKey:aKey];
}

- (long long)floatForKey:(id)aKey {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    return [[settings objectForKey:aKey] longLongValue];
}

- (int)intForKey:(id)aKey {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    return [[settings objectForKey:aKey] intValue];
}


- (UIColor *)systemColourForKey:(id)aKey defaultColour:(UIColor *)defaultColour {
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Settings.plist", aDocumentsDirectory];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    NSData *decodedData = [settings objectForKey:aKey];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData]?:defaultColour;
    return color;
}


@end
