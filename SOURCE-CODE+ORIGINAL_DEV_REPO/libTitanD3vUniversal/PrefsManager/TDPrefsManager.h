#import <UIKit/UIKit.h>
#import <Preferences/PSTableCell.h>
#import "HEXColour.h"

@interface PSTableCell (Private)
- (UIViewController *)_viewControllerForAncestor;
@end


@interface TDPrefsManager : NSObject {

  NSString *bannerTitle;
  NSString *bannerSubtitle;
  NSString *developerName;
  NSString *bannerIconPath;
  NSString *bannerCoverPath;
  NSString *changelogPlistPath;
  NSString *currentVersion;
  NSString *socialPlistPath;
  NSString *socialIconPath;
  NSString *twitterName;
  NSString *twitterAvatar;
  NSString *twitterURL;
  NSString *tweakPlistPath;
  NSString *tweakIconPath;
  NSString *crewTitle;
  NSString *crewPlistPath;
  NSString *crewImagePath;

  BOOL bannerCoverImage;
  BOOL bannerIconTint;
  BOOL useLibraryAssets;
  BOOL externalCellInset;

}

+(instancetype)sharedInstance;
-(id)init;

-(void)initWithBundleID:(NSString *)bundleID tweakName:(NSString*)tweakName prefsBundle:(NSString*)prefsBundle;
-(void)initWithBundleID:(NSString *)bundleID;
-(void)bannerTitle:(NSString *)title subtitle:(NSString*)subtitle devName:(NSString*)devName coverImagePath:(NSString*)coverPath showCoverImage:(BOOL)showCover iconPath:(NSString*)iconPath iconTint:(BOOL)iconTint;
-(void)changelogPlistPath:(NSString *)path currentVersion:(NSString *)currentVersionString;
-(void)socialPlistPath:(NSString *)plistPathString iconsPath:(NSString *)iconsPathString twitterName:(NSString *)twitterNameString twitterAvatar:(NSString *)twitterAvatarString twitterURL:(NSString *)twitterURLString;
-(void)tweakPlistPath:(NSString *)plistPathString iconsPath:(NSString *)iconsPathString;
-(void)crewTitle:(NSString *)titleString plistPath:(NSString *)plistPathString imagePath:(NSString *)imagePathString ;
-(void)useAssetsFromLibrary:(BOOL)libraryAssets;
-(void)enableExternalCellInset:(BOOL)cellInset;

- (void)setBool:(BOOL)anObject forKey:(id)aKey;
 - (void)setObject:(id)anObject forKey:(id)aKey;
- (void)setFloat:(long long)anObject forKey:(id)aKey;
- (void)setInt:(int)anObject forKey:(id)aKey;

- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue;
- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue;
- (long long)floatForKey:(id)aKey defaultValue:(long long)defaultValue;
- (int)intForKey:(id)aKey defaultValue:(int)defaultValue;

- (bool)boolForKey:(id)aKey;
- (id)objectForKey:(id)aKey;
- (long long)floatForKey:(id)aKey;
- (int)intForKey:(id)aKey;

-(NSString *)getBundleID;
-(NSString *)getTweakName;
-(NSString *)getPrefsBundle;
-(NSString *)getBannerTitle;
-(NSString *)getBannerSubtitle;
-(NSString *)getDeveloperName;
-(NSString *)getBannerCoverPath;
-(NSString *)getBannerIconPath;
-(NSString *)getChangelogPlistPath;
-(NSString *)getCurrentVersion;
-(NSString *)getSocialPlistPath;
-(NSString *)getSocialIconPath;
-(NSString *)getTwitterName;
-(NSString *)getTwitterAvatarPath;
-(NSString *)getTwitterURL;
-(NSString *)getTweakPlistPath;
-(NSString *)getTweakIconPath;
-(NSString *)getCrewTitle;
-(NSString *)getCrewPlistPath;
-(NSString *)getCrewImagePath;

-(BOOL)bannerWithIconTint;
-(BOOL)bannerWithCoverImage;
-(BOOL)populateAssetsFromLibrary;
-(BOOL)externalCellInset;


// New code 
- (void)setBool:(BOOL)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setObject:(id)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setFloat:(long long)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setInt:(int)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue ID:(NSString*)bundleIdentifier;
- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue ID:(NSString*)bundleIdentifier;
- (long long)floatForKey:(id)aKey defaultValue:(long long)defaultValue ID:(NSString*)bundleIdentifier;
- (int)intForKey:(id)aKey defaultValue:(int)defaultValue ID:(NSString*)bundleIdentifier;
- (bool)boolForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (id)objectForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (long long)floatForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (int)intForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (UIColor *)colourForKey:(id)aKey defaultValue:(id)defaultValue ID:(NSString*)bundleIdentifier;

@end
