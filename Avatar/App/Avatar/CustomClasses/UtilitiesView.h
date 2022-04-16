#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface UtilitiesView : UIView
-(instancetype)initWithFrame:(CGRect)frame icon:(UIImage *)icon;
@property (nonatomic, retain) UIView *iconView;
@property (nonatomic, retain) UIImageView *icon;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UIImageView *arrow;
@property (nonatomic, retain) UIImage *iconImage;
@end

