#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"

@interface MemoryView : UIView
-(instancetype)initWithFrame:(CGRect)frame icon:(UIImage *)icon;
@property (nonatomic, retain) UIView *iconView;
@property (nonatomic, retain) UIImageView *icon;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *subtitle;
@property (nonatomic, retain) UIImage *iconImage;
@end

