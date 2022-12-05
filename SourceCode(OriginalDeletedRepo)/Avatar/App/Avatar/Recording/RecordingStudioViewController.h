#import <UIKit/UIKit.h>
#import "RecordingManager.h"
#import "AVTAnimoji.h"
#import "AvatarMotionView.h"
#import "AvatarVideoPreviewViewController.h"
#import "ConstraintExtension.h"
#import "TDHeaderView.h"
#import "RecordingActionMenuCell.h"
#import "RecordingButton.h"
#import "TDStickerPickerViewController.h"
#import "StickerView.h"
#import "SettingManager.h"
#import "RecordingOnboardingViewController.h"

@interface RecordingStudioViewController : UIViewController <RecordingManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIColorPickerViewControllerDelegate, TDStickersPickerProtocol, StickerViewDelegate>
@property (nonatomic, copy) NSString *puppetName;
@property (nonatomic, strong) id avatar;
@property (nonatomic, strong) RecordingManager *recordingManager;
@property (nonatomic, strong) AvatarMotionView *avatarMotionView;
@property (nonatomic, strong) AVTAnimoji *puppet;
@property (nonatomic, strong) AVTAvatarInstance *avatarInstance;
@property (nonatomic, retain) UIImageView *wallpaper;
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) UIView *actionView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) RecordingButton *stopButton;
@property (strong, nonatomic) StickerView *selectedSticker;
@property (strong,nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) NSInteger numberOfStickers;
@end
