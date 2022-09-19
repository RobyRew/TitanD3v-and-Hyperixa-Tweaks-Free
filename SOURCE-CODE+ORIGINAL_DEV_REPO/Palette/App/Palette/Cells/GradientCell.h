#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface GradientCell : UICollectionViewCell
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIView *gradientView;
@property (nonatomic, retain) UIView *firstPreview;
@property (nonatomic, retain) UIView *secondPreview;
@property (nonatomic, retain) UILabel *firstLabel;
@property (nonatomic, retain) UILabel *secondLabel;
@property (nonatomic, retain) CAGradientLayer *gradient;
@end
