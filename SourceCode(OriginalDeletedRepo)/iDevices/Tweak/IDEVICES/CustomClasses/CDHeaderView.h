#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"

@interface CDHeaderView : UIView
@property (nonatomic, retain) UIView *grabberView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, retain) UIButton *rightButton;

-(instancetype)initWithTitle:(NSString *)title accent:(UIColor *)accent leftIcon:(NSString *)leftIconString leftAction:(SEL)leftAction;
-(instancetype)initWithTitle:(NSString *)title accent:(UIColor *)accent leftIcon:(NSString *)leftIconString leftAction:(SEL)leftAction rightIcon:(NSString *)rightIconString rightAction:(SEL)rightAction;
@end

