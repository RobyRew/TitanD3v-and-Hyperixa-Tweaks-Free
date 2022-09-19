#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "AnimojiPickerViewController.h"
#import "AVTAvatarStore.h"
#import "AvatarManager.h"
#import "AVTAnimoji.h"
#import "AVTAvatarLibraryViewController.h"
#import "RecordingStudioViewController.h"  
#import "GridView.h"
#import "UtilitiesView.h"
#import "SettingManager.h"
#import "TDAvatarIdentityPickerViewController.h"
#import "LibraryViewController.h"
#import "SettingsViewController.h"
#import "AvimojiViewController.h"
#import "Avatar-Swift.h"
#import "DefaultMemojiViewController.h"

@interface HomeViewController : UIViewController <AnimojiPickerDelegate, TDAvatarPickerProtocol>
@property (nonatomic, retain) AVTAvatarLibraryViewController *memojiViewController;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *avatarImage;
@property (nonatomic, retain) UILabel *welcomeTitle;
@property (nonatomic, retain) UILabel *welcomeSubtitle;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) GridView *memojiView;
@property (nonatomic, retain) GridView *animojiView;
@property (nonatomic, retain) GridView *avimojiView;
@property (nonatomic, retain) GridView *libraryView;
@property (nonatomic, retain) UILabel *utilitiesLabel;
@property (nonatomic, retain) UtilitiesView *settingView;
@property (nonatomic, retain) UtilitiesView *tutorialView;
@property (nonatomic, retain) UIView *footerView;
@end

