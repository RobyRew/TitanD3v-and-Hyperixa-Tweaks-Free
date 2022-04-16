#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "TDAppearance.h"
#import "TDUtilities.h"

@interface TDReportBugViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, MFMailComposeViewControllerDelegate, UITextViewDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *reportButton;
@property (nonatomic, retain) UIButton *cancelButton;
@property (nonatomic, retain) UIView *messageView;
@property (nonatomic, retain) UILabel *messageLabel;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *categoriesArray;
@property (nonatomic, retain) UIView *composeView;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIView *attachmentView;
@property (nonatomic, retain) UIButton *fileButton;
@property (nonatomic, retain) UIButton *imageButton;
@property (nonatomic, retain) UIButton *urlButton;
@property (nonatomic, retain) UILabel *fileLabel;
@property (nonatomic, retain) UILabel *imageLabel;
@property (nonatomic, retain) UILabel *urlLabel;
@property (nonatomic, retain) UIColor *tintColour;
@end
  
