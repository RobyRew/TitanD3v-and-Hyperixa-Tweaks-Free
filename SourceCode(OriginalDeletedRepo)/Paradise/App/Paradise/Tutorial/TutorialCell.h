#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface TutorialCell : UITableViewCell <UITextViewDelegate>
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UITextView *messageLabel;
@end

