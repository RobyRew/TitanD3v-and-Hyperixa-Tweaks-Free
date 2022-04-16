#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDColorDisplayView : UILabel

@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
