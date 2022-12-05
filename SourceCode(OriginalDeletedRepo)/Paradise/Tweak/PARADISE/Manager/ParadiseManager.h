#import <UIKit/UIKit.h>
#import "Headers.h"

@interface ParadiseManager : NSObject
// @property (nonatomic, strong) LSApplicationProxy *appProxy;
// @property (nonatomic, strong) SBIconView *iconView;
@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *bundleIdentifier;
@property (nonatomic, strong) NSString *bundlePATH;
@property (nonatomic, strong) NSString *containerPATH;

@property (nonatomic, strong) NSURL *bundleURL;
@property (nonatomic, strong) NSURL *dataContainerURL;

@property (nonatomic, assign) NSInteger diskUsage;
@property (nonatomic, strong) NSString *diskUsageString;

+(instancetype)sharedInstance;
-(id)init;
- (instancetype)initWithBundleIdentifier:(NSString *)bundleIdentifier;
+ (ParadiseManager *)initForBundleIdentifier:(NSString *)bundleIdentifier;
-(UIImage *)imageForBID;

-(void)renameForBID:(NSString *)bid newName:(NSString*)newName;
-(NSString *)getAppNameForBID:(NSString *)BID;
- (NSString *)name;
- (BOOL)isApplication;
- (NSString *)customIconName;

- (void)resetIconNameForBID:(NSString*)BID;
- (void)resetIconForBID:(NSString*)BID;

- (bool)isCustomIconForBID:(NSString*)BID;
- (void)setCustomIconForBID:(NSString *)BID iconImage:(UIImage*)iconImage;

- (void)getCachesDirectorySizeWithCompletion:(void(^)(NSString *formattedSize))completion;
- (void)clearAppCachesWithCompletion:(void(^)())completion;

- (void)setAppBadgeCount:(NSInteger)badgeCount;
- (NSInteger)appBadgeCount;

-(void)deleteKey:(NSString*)key;
@end