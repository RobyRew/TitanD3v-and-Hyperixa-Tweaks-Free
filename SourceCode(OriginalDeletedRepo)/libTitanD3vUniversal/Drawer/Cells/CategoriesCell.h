#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface CategoriesCell : UICollectionViewCell

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIView *selectedView;
@property (nonatomic, retain) UIView *iconView;
@property (nonatomic, retain) UIView *gradientView;
@property (nonatomic, retain) CAGradientLayer *gradient;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;

@end