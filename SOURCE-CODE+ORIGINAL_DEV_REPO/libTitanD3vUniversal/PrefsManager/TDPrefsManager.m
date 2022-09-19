#import "TDPrefsManager.h"

static NSString *BundleID;
static NSString *prefPath;
static NSString *TweakName;
static NSString *PrefsBundle;
static NSMutableDictionary *settings;

@implementation TDPrefsManager

+(instancetype)sharedInstance {
  static TDPrefsManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[TDPrefsManager alloc] init];
    settings = [NSMutableDictionary dictionary];
  });
  return sharedInstance;
}

-(id)init {
  return self;
}

-(void)initWithBundleID:(NSString *)bundleID tweakName:(NSString*)tweakName prefsBundle:(NSString*)prefsBundle {
  BundleID = bundleID;
  TweakName = tweakName;
  PrefsBundle = prefsBundle;
  prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
}

-(void)initWithBundleID:(NSString *)bundleID {
  prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
}

-(void)bannerTitle:(NSString *)title subtitle:(NSString*)subtitle devName:(NSString*)devName coverImagePath:(NSString*)coverPath showCoverImage:(BOOL)showCover iconPath:(NSString*)iconPath iconTint:(BOOL)iconTint {

  bannerTitle = title;
  bannerSubtitle = subtitle;
  developerName = devName;
  bannerCoverPath = coverPath;
  bannerCoverImage = showCover;
  bannerIconPath = iconPath;
  bannerIconTint = iconTint;

}

-(void)changelogPlistPath:(NSString *)path currentVersion:(NSString *)currentVersionString{
  changelogPlistPath = path;
  currentVersion = currentVersionString;
}

-(void)socialPlistPath:(NSString *)plistPathString iconsPath:(NSString *)iconsPathString twitterName:(NSString *)twitterNameString twitterAvatar:(NSString *)twitterAvatarString twitterURL:(NSString *)twitterURLString {

  socialPlistPath = plistPathString;
  socialIconPath = iconsPathString;
  twitterName = twitterNameString;
  twitterAvatar = twitterAvatarString;
  twitterURL = twitterURLString;

}

-(void)tweakPlistPath:(NSString *)plistPathString iconsPath:(NSString *)iconsPathString {

  tweakPlistPath = plistPathString;
  tweakIconPath = iconsPathString;
}

-(void)crewTitle:(NSString *)titleString plistPath:(NSString *)plistPathString imagePath:(NSString *)imagePathString {

  crewTitle = titleString;
  crewPlistPath = plistPathString;
  crewImagePath = imagePathString;
}

-(void)useAssetsFromLibrary:(BOOL)libraryAssets {
  useLibraryAssets = libraryAssets;
}

-(void)enableExternalCellInset:(BOOL)cellInset {
  externalCellInset = cellInset;
}

- (void)setBool:(BOOL)anObject forKey:(id)aKey {
  [settings setObject:[NSNumber numberWithBool:anObject] forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (void)setObject:(id)anObject forKey:(id)aKey {
  [settings setObject:anObject forKey:aKey];
  [settings writeToFile:prefPath atomically:YES];
}

- (void)setFloat:(long long)anObject forKey:(id)aKey{
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

-(void)writeToPlist {
  [settings writeToFile:prefPath atomically:YES];
}

-(NSString *)getBundleID {
  return BundleID;
}

-(NSString *)getTweakName {
  return TweakName;
}

-(NSString *)getPrefsBundle {
  return PrefsBundle;
}

-(NSString *)getBannerTitle {
  return bannerTitle;
}

-(NSString *)getBannerSubtitle {
  return bannerSubtitle;
}

-(NSString *)getDeveloperName {
  return developerName;
}

-(NSString *)getBannerCoverPath {
  return bannerCoverPath;
}

-(BOOL)bannerWithCoverImage {
  return bannerCoverImage;
}

-(NSString *)getBannerIconPath {
  return bannerIconPath;
}

-(BOOL)bannerWithIconTint {
  return bannerIconTint;
}

-(NSString *)getChangelogPlistPath {
  return changelogPlistPath;
}

-(NSString *)getCurrentVersion {
  return currentVersion;
}

-(NSString *)getSocialPlistPath {
  return socialPlistPath;
}

-(NSString *)getSocialIconPath {
  return socialIconPath;
}

-(NSString *)getTwitterName {
  return twitterName;
}

-(NSString *)getTwitterAvatarPath {
  return twitterAvatar;
}

-(NSString *)getTwitterURL {
  return twitterURL;
}

-(NSString *)getTweakPlistPath {
  return tweakPlistPath;
}

-(NSString *)getTweakIconPath {
  return tweakIconPath;
}

-(NSString *)getCrewTitle {
  return crewTitle;
}

-(NSString *)getCrewPlistPath {
  return crewPlistPath;
}

-(NSString *)getCrewImagePath {
  return crewImagePath;
}

-(BOOL)populateAssetsFromLibrary {
  return useLibraryAssets;
}

-(BOOL)externalCellInset {
  return externalCellInset;
}


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  New code
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

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

@end
