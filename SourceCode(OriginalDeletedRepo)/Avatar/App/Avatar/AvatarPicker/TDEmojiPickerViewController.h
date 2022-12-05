#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "TDEmojiPickerCell.h"
#import "TDEmojiPickerCellHeaderView.h"
#import "PrivateBlurEffect.h"

@protocol TDEmojiPickerProtocol <NSObject>
@required
-(void)didSelectEmoji:(NSString *)emoji;
-(void)didDismissedEmojiPicker;
@end

@interface TDEmojiPickerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) _UIBackdropViewSettings *blurSetting;
@property (nonatomic, strong) _UIBackdropView *blurView;
@property (nonatomic, retain) UIVisualEffectView *grabberView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *emojiArray;
@property(nonatomic,assign)id delegate;
@property (nonatomic) BOOL didSelectEmoji;
@end
