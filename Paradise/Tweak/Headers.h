#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <spawn.h>

//#import "./DATA/DataController/DataViewController.h"

// struct SBIconImageInfo iconspecs;

// typedef struct SBIconImageInfo {
// 	CGSize size;
// 	double scale;
// 	double continuousCornerRadius;
// } SBIconImageInfo;

static NSString *plistPath = @"/var/mobile/Library/Preferences/com.TitanD3v.ParadisePrefs.plist";

@interface FBProcessState : NSObject
@property (getter=isForeground,nonatomic,readonly) BOOL foreground;
@property (getter=isRunning,nonatomic,readonly) BOOL running;
@property (assign,nonatomic) long long taskState;
@end

@interface FBProcess : NSObject
@property (nonatomic,copy,readonly) NSString * name;
@property (nonatomic,copy,readonly) NSString * bundleIdentifier;
@property (getter=isCurrentProcess,nonatomic,readonly) BOOL currentProcess;
-(void)_killForReason:(long long)arg1 andReport:(BOOL)arg2 withDescription:(id)arg3 completion:(/*^block*/id)arg4;
@end

@interface SBClockApplicationIconImageView
-(void)presentAppDataVC:(UITapGestureRecognizer*)sender;
@end

// @interface MTMaterialView : UIView
// @end

@interface UIApplication (Paradise)
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
@end

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * displayName;
@property (assign,nonatomic) id badgeNumberOrString;
@property (nonatomic,copy) id badgeValue;
-(NSString *)bundleIdentifier;
-(void)purgeCaches;
@end

@interface SBIcon : NSObject
- (NSString *)applicationBundleID;
- (SBApplication *)application;
- (NSInteger)badgeValue;
struct SBIconImageInfo {
   CGFloat width;
   CGFloat height;
   CGFloat field1;
   CGFloat field2;
};
-(BOOL)isWidgetIcon;
-(UIImage *)getIconImage:(int)arg1 ;
-(UIImage *)iconImageWithInfo:(struct SBIconImageInfo)info;
@end

@interface SBLeafIcon : SBIcon
-(id)leafIdentifier;
@end

@interface SBWidgetIcon : SBLeafIcon
@end

@interface SBBookmarkIcon : SBLeafIcon
@end

@interface SBHLibraryPodCategoryIcon : SBLeafIcon
@end

@interface SBSApplicationShortcutIcon: NSObject
@end

@interface SBFolderIcon : SBIcon
-(id)nodeIdentifier;
@end

@interface SBSApplicationShortcutItem : NSObject
@property (nonatomic, retain) NSString *type;
@property (nonatomic, copy) NSString * localizedTitle;
@property (nonatomic, copy) SBSApplicationShortcutIcon * icon;
@property (nonatomic, copy) NSString * bundleIdentifierToLaunch;
- (void)setIcon:(SBSApplicationShortcutIcon *)arg1;
@end

@interface SBSApplicationShortcutCustomImageIcon : SBSApplicationShortcutIcon
@property (nonatomic, readwrite) BOOL isTemplate;   
- (id)initWithImagePNGData:(id)arg1;
- (BOOL)isTemplate;
@end

@interface SBIconLabelImageParameters : NSObject
@property (nonatomic,copy,readonly) NSString * iconLocation;
@property (nonatomic,copy) NSString * text; 
-(unsigned long long)hash;
-(id)description;
@end

@interface SBIconView : UIView
@property (nonatomic, retain) SBIcon *icon;
@property (nonatomic, retain) SBFolderIcon * folderIcon;
@property (nonatomic,readonly) UIImage * iconImageSnapshot;
@property (nonatomic,readonly) UIView * iconImageSnapshotView;
@property (nonatomic,copy,readonly) NSString * applicationBundleIdentifierForShortcuts;
- (id)_iconImageView;
- (void)_updateLabel;
- (BOOL)ad_isFolderIcon;
- (SBIconLabelImageParameters*)_labelImageParameters;
@end

@interface SBIconLegibilityLabelView
-(SBIconView *)iconView;
-(SBIconLabelImageParameters *)imageParameters;
@end

@interface SBMutableIconLabelImageParameters : SBIconLabelImageParameters
@property (nonatomic,copy) NSString * text;
@property (nonatomic,retain) UIColor * textColor;
@property (nonatomic,retain) UIColor * focusHighlightColor;

-(void)setFocusHighlightColor:(UIColor *)arg1;
-(void)setTextColor:(UIColor *)arg1;
-(void)setText:(NSString *)arg1;
@end

@interface SBApplicationIcon : SBLeafIcon

// iOS 12 and below
- (UIImage *)generateIconImage:(int)arg1;
// iOS 13
// - (id)generateIconImageWithInfo:(SBIconImageInfo)arg1;
@end

@interface SBIconModel : NSObject
- (SBApplicationIcon *)expectedIconForDisplayIdentifier:(id)arg1;
-(SBIcon *)applicationIconForBundleIdentifier:(id)arg1 ;
-(void)layout;
-(void)purgeAllIconCaches;
-(void)loadAllIcons;
@end

@interface SBIconViewMap : NSObject
@property (nonatomic,readonly) SBIconModel * iconModel;
@end

@interface SBHIconModel : NSObject
-(void)removeAllIcons;
-(void)layout;
-(id)iconState;
@end

@interface SBIconController : UIViewController
// @property (nonatomic, retain) SBIconModel *model;
+(id)sharedInstance;
-(SBIconViewMap *)homescreenIconViewMap;
-(id)model;
@end

@interface SBIconImageView : UIView
@property (assign,nonatomic) SBIconView * iconView;
-(void)setIconView:(SBIconView *)arg1 ;
-(SBIconView *)iconView;
@end

@interface SBApplicationController : NSObject
+ (instancetype)sharedInstance;
- (SBApplication *)applicationWithBundleIdentifier:(NSString *)identifier;
@end

@interface UIImage ()
+ (id)imageNamed:(id)arg1 inBundle:(id)arg2;
@end

@interface UIView (Private)
- (UIViewController *)_viewControllerForAncestor;
@end


// Core Services

@interface _LSBoundIconInfo
@property (nonatomic, copy) NSString *applicationIdentifier;
@end

@interface LSResourceProxy : NSObject
@end

@interface LSBundleProxy : LSResourceProxy
@property (nonatomic,readonly) NSString * localizedShortName;
@property (nonatomic,copy) NSArray * machOUUIDs;
@property (nonatomic,copy) NSString * sdkVersion;
@property (nonatomic,readonly) NSString * bundleIdentifier;
@property (nonatomic,readonly) NSString * bundleType;
@property (nonatomic,readonly) NSURL * bundleURL;
@property (nonatomic,readonly) NSString * bundleExecutable;
@property (nonatomic,readonly) NSString * canonicalExecutablePath;
@property (nonatomic,readonly) NSURL * containerURL;
@property (nonatomic,readonly) NSURL * dataContainerURL;
@property (nonatomic,readonly) NSURL * bundleContainerURL;
@property (nonatomic,readonly) NSURL * appStoreReceiptURL;
@property (nonatomic,readonly) NSString * bundleVersion;
@property (nonatomic,readonly) NSString * signerIdentity;
@property (nonatomic,readonly) NSDictionary * entitlements;
@property (nonatomic,readonly) NSDictionary * environmentVariables;
@property (nonatomic,readonly) NSDictionary * groupContainerURLs;
- (id)localizedName;
@end

@interface LSApplicationProxy : LSBundleProxy
@property (nonatomic,readonly) NSString * applicationIdentifier; 
+ (LSApplicationProxy *)applicationProxyForIdentifier:(NSString *)identifier;
@property (nonatomic,readonly) NSString *shortVersionString;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSNumber *itemID;
@property (nonatomic,readonly) NSNumber * staticDiskUsage;
@property (nonatomic,readonly) NSNumber * dynamicDiskUsage;
@property (nonatomic,readonly) NSNumber * ODRDiskUsage;
@property (getter=isAppStoreVendable,nonatomic,readonly) BOOL appStoreVendable;
@property (getter=isDeletable,nonatomic,readonly) BOOL deletable;

// iOS 13
@property (nonatomic,readonly) NSSet *claimedDocumentContentTypes;
@property (nonatomic,readonly) NSSet *claimedURLSchemes;
@end

@interface IXAppInstallCoordinator : NSObject
+(BOOL)demoteAppToPlaceholderWithBundleID:(id)arg1 forReason:(unsigned long long)arg2 waitForDeletion:(BOOL)arg3 error:(id*)arg4 ;
+(BOOL)demoteAppToPlaceholderWithBundleID:(id)arg1 forReason:(unsigned long long)arg2 error:(id*)arg3 ;
+(void)demoteAppToPlaceholderWithBundleID:(id)arg1 forReason:(unsigned long long)arg2 waitForDeletion:(BOOL)arg3 completion:(/*^block*/id)arg4 ;
+(void)uninstallAppWithBundleID:(id)arg1 requestUserConfirmation:(BOOL)arg2 waitForDeletion:(BOOL)arg3 completion:(/*^block*/id)arg4 ;
@end

@interface SpringBoard : UIApplication
- (id)_accessibilityFrontMostApplication;
-(void)frontDisplayDidChange: (id)arg1;
@end 