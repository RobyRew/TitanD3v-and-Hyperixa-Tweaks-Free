#import <TitanD3vUniversal/TitanD3vUniversal.h>

@interface CategoriesNextButton : UIControl
-(instancetype)initWithIcon:(NSString *)iconString title:(NSString *)titleString accent:(UIColor *)accent action:(SEL)customAction;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UIImageView *icon;
@end

