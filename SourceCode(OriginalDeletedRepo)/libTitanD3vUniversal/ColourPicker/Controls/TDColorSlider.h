#import <UIKit/UIKit.h>
#import "TDSliderType.h"
#import "TDColorSliderDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDColorSlider : UISlider

@property (nonatomic, weak) id <TDColorSliderDelegate> delegate;
@property (nonatomic, readonly) TDSliderType type;
@property (nonatomic, readonly) UIColor *colorValue;

- (instancetype)initWithSliderType:(TDSliderType)type color:(UIColor *)color;

- (void)setColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
