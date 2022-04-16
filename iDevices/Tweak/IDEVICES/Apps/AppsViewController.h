#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "DataManager.h"
#import "CDHeaderView.h"
#import "AppCell.h"  
#import <CoreServices/CoreServices.h>

@interface AppsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) CDHeaderView *headerView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIImageView *headerIcon;
@property (nonatomic, retain) UILabel *headerTitle;
@end


@interface SBIconController: UIViewController
- (UIImage *)iconImageForIdentifier:(NSString *)identifier;
@property (nonatomic, copy, readonly) NSArray * allApplications;
+ (id)sharedInstance;
@end

@interface UIImage (Private)
+(id)_applicationIconImageForBundleIdentifier:(NSString*)displayIdentifier format:(int)form scale:(CGFloat)scale;
@end

@interface UIApplication (Libra)
- (BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2;
@end

@interface SBApplication
@property (nonatomic,readonly) NSString * displayName; 
@property (nonatomic,readonly) NSString * bundleIdentifier; 
- (BOOL)isSystemApplication;
- (BOOL)isInternalApplication;
- (id)badgeValue;
@end

@interface LSBundleProxy
@property(readonly, nonatomic) NSURL *bundleContainerURL;
@property(readonly, nonatomic) NSURL *bundleURL;
@property(readonly, nonatomic) NSURL *dataContainerURL;
- (id)localizedName;
@end

@interface LSApplicationProxy : LSBundleProxy
+ (LSApplicationProxy *)applicationProxyForIdentifier:(id)arg1;
@end



