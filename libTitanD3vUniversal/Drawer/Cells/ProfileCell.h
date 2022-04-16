#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextField *textField;

@end

