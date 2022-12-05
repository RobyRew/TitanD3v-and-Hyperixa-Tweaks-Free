#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import <QuartzCore/QuartzCore.h>

@interface GridView : UIView
-(instancetype)initWithFrame:(CGRect)frame bg:(UIColor *)background icon:(UIImage *)icon iconSize:(CGFloat)size iconPadding:(CGFloat)iconPadding titleTop:(CGFloat)titleTop titleFont:(UIFont *)titleFont;
@property (nonatomic, retain) UIImageView *icon;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UIImage *iconImage;
@property (nonatomic) CGFloat iconSize;
@property (nonatomic) CGFloat iconPadding;
@property (nonatomic) CGFloat titleTopPadding;
@property (nonatomic, retain) UIFont *titleFont;
@end
