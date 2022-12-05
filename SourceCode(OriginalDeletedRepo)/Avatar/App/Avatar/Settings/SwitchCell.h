#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "SettingManager.h"

@interface SwitchCell : UITableViewCell
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIView *iconView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UISwitch *toggleSwitch;
@end

