#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface RecordingButton : UIControl
-(instancetype)initWithIcon:(NSString *)iconString accent:(UIColor *)accent action:(SEL)customAction;
@property (nonatomic, retain) UIImageView *icon;
@end

