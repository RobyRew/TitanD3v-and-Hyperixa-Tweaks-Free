#import "ParadiseManager.h"
#import "ParadiseFileManager.h"

static NSString *prefPath = @"/var/mobile/Library/Preferences/com.Titand3v.ParadiseData.plist";
NSMutableDictionary *settings;


@interface ParadiseManager ()
@property (nonatomic, strong) SBApplication *sbApplication;
@property (nonatomic, strong) LSApplicationProxy *appProxy;
@property (nonatomic, strong) SBIconView *iconView;
@end

@implementation ParadiseManager

+(instancetype)sharedInstance {
  static ParadiseManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[ParadiseManager alloc] init];
  });
  return sharedInstance;
}

+ (ParadiseManager *)initForBundleIdentifier:(NSString *)bundleIdentifier{
  ParadiseManager *data = [[ParadiseManager alloc] initWithBundleIdentifier:bundleIdentifier];
  return data;
}

-(UIImage *)imageForBID{
  UIImage *image;
  SBIconModel *model;

  SBIconController *iconController = [NSClassFromString(@"SBIconController") sharedInstance];

  if([iconController respondsToSelector:@selector(homescreenIconViewMap)]) model = [[iconController homescreenIconViewMap] iconModel];
  else if([iconController respondsToSelector:@selector(model)]) model = [iconController model];
  SBIcon *icon = [model applicationIconForBundleIdentifier:self.bundleIdentifier];
  if([icon respondsToSelector:@selector(getIconImage:)]) image = [icon getIconImage:2];
  else if([icon respondsToSelector:@selector(iconImageWithInfo:)]) image = [icon iconImageWithInfo:(struct SBIconImageInfo){60,60,2,0}];

  return image;
}

- (instancetype)initWithBundleIdentifier:(NSString *)bundleIdentifier {
  if (self = [super init]) {
    self.sbApplication = [self.class sbApplicationForBundleIdentifier:bundleIdentifier];
    self.appProxy = [NSClassFromString(@"LSApplicationProxy") applicationProxyForIdentifier:bundleIdentifier];
    self.bundleIdentifier = bundleIdentifier;
    settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
    [self loadData];
  }
  return self;
}

- (void)loadData {
  // App Info
  self.version = self.appProxy.shortVersionString ? : self.appProxy.bundleVersion;
  self.iconImage = [self imageForBID];
  // Data URLs
  self.bundleURL = self.appProxy.bundleURL ? : self.appProxy.bundleContainerURL;
  if ([self.appProxy respondsToSelector:@selector(dataContainerURL)]) {
    self.dataContainerURL = self.appProxy.dataContainerURL;
  }
  // Disk Usage
  self.diskUsage = [self.appProxy.staticDiskUsage integerValue];
  self.diskUsageString = [NSByteCountFormatter stringFromByteCount:[self.appProxy.staticDiskUsage longLongValue] countStyle:NSByteCountFormatterCountStyleFile];

  self.bundlePATH = [[NSString stringWithFormat:@"%@", self.bundleURL] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
  self.containerPATH = [[NSString stringWithFormat:@"%@", self.dataContainerURL] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
}

-(id)init {
  settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  return self;
}

- (NSString *)name {
  return [self.sbApplication respondsToSelector:@selector(displayName)] ? self.sbApplication.displayName : nil;
}

- (BOOL)isApplication {
  return self.sbApplication != nil;
}

- (NSString *)customIconName {
  return [settings objectForKey:self.bundleIdentifier];
}

-(void)refreshIcons{
  SBIconController *model = [NSClassFromString(@"SBIconController") sharedInstance];
  [[model  model] layout];
}

- (void)resetIconNameForBID:(NSString*)BID {
  [settings removeObjectForKey:BID];
  [self writeToPlist];
}

- (void)resetIconForBID:(NSString*)BID {
  NSString *pathWithIcon = [NSString stringWithFormat:@"/Library/Paradise/%@-Large.png", BID];
  NSLog(@"yyyyyyyyyyyyyyyyyyyyy pathWithIcon:-%@", pathWithIcon);
  [[NSFileManager defaultManager] removeItemAtPath:pathWithIcon error:nil];
  [self refreshIcons];
}

- (bool)isCustomIconForBID:(NSString*)BID{
  NSString *pathWithIcon = [NSString stringWithFormat:@"/Library/Paradise/%@-Large.png", BID];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if (![fileManager fileExistsAtPath:pathWithIcon]) {
    return 0;
  }
  return 1;
}

- (void)setCustomIconForBID:(NSString *)BID iconImage:(UIImage*)iconImage{
  NSString *pathWithIcon = [NSString stringWithFormat:@"/Library/Paradise/%@-Large.png", BID];
  NSLog(@"yyyyyyyyyyyyyyyyyyyyy pathWithIcon:-%@, BID:-%@, iconImage:-%@", pathWithIcon, BID, iconImage);
  [UIImagePNGRepresentation(iconImage) writeToFile:pathWithIcon atomically:YES];
  [self refreshIcons];
}

-(void)renameForBID:(NSString *)bid newName:(NSString*)newName{
  SBApplication *app = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bid];
  NSString *bidForReal = [NSString stringWithFormat:@"%@.real", bid];
  [settings setObject:app.displayName forKey:bidForReal];
  [settings setObject:newName forKey:bid];
  NSLog(@"xxxxxxxxxxxxxx bidForReal:-%@, newName:-%@, renameForBID:-%@", bidForReal, newName, bid);
  [self writeToPlist];
}

+ (SBApplication *)sbApplicationForBundleIdentifier:(NSString *)bundleIdentifier {
  if ([[NSClassFromString(@"SBApplicationController") sharedInstance] respondsToSelector:@selector(applicationWithBundleIdentifier:)]) {
    return [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleIdentifier];
  }
  return nil;
}

- (NSInteger)appBadgeCount {
  if ([self.sbApplication respondsToSelector:@selector(badgeValue)]) {
    return [[self.sbApplication badgeValue] integerValue];
  } else if ([self.sbApplication respondsToSelector:@selector(badgeNumberOrString)]) {
    return [[self.sbApplication badgeNumberOrString] integerValue];
  }
  return 0;
}

- (void)setAppBadgeCount:(NSInteger)badgeCount {
  if ([self.sbApplication respondsToSelector:@selector(setBadgeValue:)]) {
    [self.sbApplication setBadgeValue:[NSNumber numberWithInteger:badgeCount]];
  } else {
    [self.sbApplication setBadgeNumberOrString:[NSNumber numberWithInteger:badgeCount]];
  }
}

-(void)writeToPlist{
  [settings writeToFile:prefPath atomically:YES];
}

-(NSString *)getAppNameForBID:(NSString *)BID{
  NSString *appName = [settings objectForKey:BID];
  NSLog(@"xxxxxxxxxxxxxx getAppNameForBID:-%@", appName);
  return appName;
}

- (NSURL *)cacheDirectoryURL {
  return [self.dataContainerURL URLByAppendingPathComponent:@"/Library/Caches/"];
}

- (NSURL *)tmpDirectoryURL {
  return [self.dataContainerURL URLByAppendingPathComponent:@"/tmp/"];
}

- (NSArray *)cacheDirectoriesURLs {
  NSMutableArray *caches = [NSMutableArray new];

  NSURL *cacheDirectoryURL = [self cacheDirectoryURL];
  if (cacheDirectoryURL) [caches addObject:cacheDirectoryURL];

  NSURL *tmpDirectoryURL = [self tmpDirectoryURL];
  if (tmpDirectoryURL) [caches addObject:tmpDirectoryURL];

  return caches;
}

- (void)getCachesDirectorySizeWithCompletion:(void(^)(NSString *formattedSize))completion {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    unsigned long long int totalSize = 0;
    NSArray <NSURL *> *cacheDirectoriesURLs = [self cacheDirectoriesURLs];
    for (NSURL *url in cacheDirectoriesURLs) {
      if (url && [[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
        unsigned long long int folderSize = 0;
        [[NSFileManager defaultManager] nr_getAllocatedSize:&folderSize ofDirectoryAtURL:url error:nil];
        totalSize += folderSize;
      }
    }
    NSString *formattedSize = [NSByteCountFormatter stringFromByteCount:totalSize countStyle:NSByteCountFormatterCountStyleFile];
    dispatch_async(dispatch_get_main_queue(), ^{
      completion(formattedSize);
    });
  });
}

- (void)clearAppCachesWithCompletion:(void(^)())completion {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

    NSArray <NSURL *> *cacheDirectoriesURLs = [self cacheDirectoriesURLs];
    for (NSURL *url in cacheDirectoriesURLs) {
      [self.class deleteContentsOfDirectoryAtURL:url];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
      completion();
    });
  });
}

+ (void)deleteContentsOfDirectoryAtURL:(NSURL *)url {
  NSFileManager *fm = [NSFileManager defaultManager];
  NSDirectoryEnumerator *enumerator = [fm enumeratorAtURL:url includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants errorHandler:nil];
  NSURL *child;
  while ((child = [enumerator nextObject])) {
    [fm removeItemAtURL:child error:NULL];
  }
}


//this to delete appDataSaved data
-(void)deleteKey:(NSString*)key{
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefPath];
  NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
  [mutableDict removeObjectForKey:key];
  [mutableDict writeToFile:prefPath atomically:YES];
  NSLog(@"ParadiseDebug deleteKey:-%@", key);
}

@end
