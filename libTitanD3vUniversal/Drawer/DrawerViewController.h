#import <UIKit/UIKit.h>
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDBlurBaseView.h"
#import "CategoriesCell.h"
#import "SocialViewController.h"
#import "ChangelogViewController.h"
#import "TweakViewController.h"
#import "BackupViewController.h"
//#import "ThemeViewController.h"
#import "ProfileViewController.h"
#import "CrewViewController.h"
#import "ConstraintExtension.h"

@interface DrawerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *categoriesArray;
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, retain) SocialViewController *socialVC;
@property (nonatomic, retain) ChangelogViewController *changelogVC;
@property (nonatomic, retain) TweakViewController *tweakVC;
@property (nonatomic, retain) BackupViewController *backupVC;
@property (nonatomic, retain) ProfileViewController *profileVC;
@property (nonatomic, retain) CrewViewController *crewVC;
@property (nonatomic, retain) UIColor *tintColour;
@end

