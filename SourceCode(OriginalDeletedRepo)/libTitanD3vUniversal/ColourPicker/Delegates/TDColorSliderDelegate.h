@class TDColorSlider;
@protocol TDColorSliderDelegate <NSObject>

- (void)slider:(TDColorSlider *)colorSlider valueChanged:(CGFloat)value;
- (void)slider:(TDColorSlider *)colorSlider valueFinishedChange:(CGFloat)value;
- (void)slider:(TDColorSlider *)colorSlider colorChanged:(UIColor *)color;

@end
