#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "TDStickerPickerCell.h"
#import "TDStickerPickerCellHeaderView.h"
#import "PrivateBlurEffect.h"

@protocol TDStickersPickerProtocol <NSObject>
@required
-(void)didSelectSticker:(NSString *)sticker;
-(void)didDismissedStickersPicker;
@end

@interface TDStickerPickerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) _UIBackdropViewSettings *blurSetting;
@property (nonatomic, strong) _UIBackdropView *blurView;
@property (nonatomic, retain) UIVisualEffectView *grabberView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *stickerArray;
@property(nonatomic,assign)id delegate;
@property (nonatomic) BOOL didSelectSticker;
@end
