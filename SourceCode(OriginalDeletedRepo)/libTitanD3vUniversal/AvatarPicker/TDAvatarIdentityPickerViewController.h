#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "TDHeaderView.h"
#import "TDAvatarIdentityToolsCell.h"
#import "TDAvatarIdentityCellHeaderView.h"
#import "TDAvatarIdentityStickerCell.h"
#import "TDAvatarIdentityEmojiCell.h"
#import "TDAvatarIdentityPickerDataSource.h"
#import "TDEmojiPickerViewController.h"

@protocol TDAvatarPickerProtocol <NSObject>
@required
-(void)didCreatedAvatar:(UIImage *)avatar;
-(void)didDismissedAvatarPicker;
@end

@interface TDAvatarIdentityPickerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIColorPickerViewControllerDelegate, UITextFieldDelegate, TDEmojiPickerProtocol>
-(instancetype)initWithTitle:(NSString *)title showDefaultAvatar:(BOOL)defaultAvatar avatarImage:(UIImage *)avatar accent:(UIColor *)accent;
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) UIView *preview;
@property (nonatomic, retain) UIImageView *previewImage;
@property (nonatomic, retain) UIImageView *stickerImage;
@property (nonatomic, retain) UILabel *emojiLabel;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *stickersArray;
@property (nonatomic, retain) NSMutableArray *emojisArray;
@property(nonatomic,assign)id delegate;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic) BOOL useDefaultAvatarImage;
@property (nonatomic, retain) UIImage *defaultAvatar;
@property (nonatomic, retain) UIColor *accentColour;
@end
