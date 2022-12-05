#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "SenderCell.h"
#import "RecipientCell.h"
#import "PhotoCell.h"  
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "GlobalPrefernces.h"

@protocol messageDataProtocol <NSObject>
-(void)passDataToCreateVC:(NSMutableArray *)imageArrays message:(NSString *)messageString includedAttachment:(BOOL)didIncludedAttachment;
@end


@interface ComposeMessageVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, PHPickerViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) UIButton *doneButton;
@property (nonatomic, retain) UIImageView *doneImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) CGFloat defaultChatHeight;
@property (nonatomic, retain) UITextView *senderTextView;
@property (nonatomic, retain) UILabel *placeholderLabel;
@property (nonatomic, retain) UIView *toolbarView;
@property (nonatomic, retain) UIImage *recipientAvatarImage;
@property (nonatomic, retain) NSString *recipientNameString;
@property (nonatomic, retain) NSString *senderTextString;
@property (nonatomic, retain) UIButton *photoButton;
@property (nonatomic, retain) UIImageView *photoImage;
@property (nonatomic) float kbHeight;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property(nonatomic,assign)id messageDataDelegate;
@property (nonatomic, assign, getter= didAddedAttachmentImages) BOOL didAddedAttachmentImages;
@property (nonatomic, retain) UIColor *toolbarColour;

@end

