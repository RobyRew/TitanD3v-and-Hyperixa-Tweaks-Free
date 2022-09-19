
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Preferences/Preferences.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "TDUtilities.h"
#import "GlobalPrefs.h"
#import "TDBannerView.h"
#import "TDGridCell.h"
#import "DrawerViewController.h"
#import "TDBlurView.h"
#import "ConstraintExtension.h"

@interface TDPrimraryController : PSListController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, retain) UILabel *greetingLabel;
@property (nonatomic, retain) UIVisualEffectView *blurEffectView;
@property (nonatomic, retain) NSString *bundleID;
@property (nonatomic, retain) UIColor *navigationBarColour;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *backgroundColour;
@property (nonatomic, retain) UIColor *cellsColour;
@property (nonatomic, retain) UIColor *labelColour;
@property (nonatomic, retain) TDBannerView *bannerView;
@property (nonatomic, retain) DrawerViewController *drawerVC;
@property (nonatomic, retain) UIRefreshControl *respringController;
@property (nonatomic, retain) TDBlurView *tutorialView;
@property (nonatomic, retain) UIImageView *tutorialImage;
@property (nonatomic) NSInteger licenceStatus;
@property (nonatomic, retain) UIImageView *licenceImage;
-(void)updateLicenceStatus;
@end


@interface UIStatusBar : NSObject
@property (nonatomic, assign) UIColor *foregroundColor;
@end

@interface UIApplication (Private)
@property (nonatomic, retain) UIStatusBar *statusBar;
@end
