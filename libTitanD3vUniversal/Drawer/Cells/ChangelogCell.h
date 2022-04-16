#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface ChangelogCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UIView *categoriesView;
@property (nonatomic, retain) UILabel *categoriesLabel;
@property (nonatomic, retain) UIView *versionView;
@property (nonatomic, retain) UILabel *versionLabel;
@property (nonatomic, retain) UIView *splitView;
@property (nonatomic, retain) UITextView *messageLabel;

@end

