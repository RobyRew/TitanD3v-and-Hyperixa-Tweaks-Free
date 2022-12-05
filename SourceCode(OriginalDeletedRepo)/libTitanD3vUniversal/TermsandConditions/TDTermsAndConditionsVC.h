#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface TDTermsAndConditionsVC : UIViewController <UITextViewDelegate>
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextView *textView;
@end
