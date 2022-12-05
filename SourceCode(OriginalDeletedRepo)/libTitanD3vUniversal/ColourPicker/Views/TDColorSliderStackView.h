#import <UIKit/UIKit.h>
#import "TDColorSliderDelegate.h"
#import "TDColorPickerDelegate.h"
#import "TDColorSpaceType.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDColorSliderStackView : UIStackView <TDColorSliderDelegate>

@property (nonatomic, weak) id <TDColorPickerDelegate> delegate;

- (instancetype)initWithColor:(UIColor *)color stackType:(TDColorSpaceType)type delegate:(id<TDColorPickerDelegate>)delegate;
- (void)configureForStackType:(TDColorSpaceType)type color:(UIColor *)color;

- (void)setColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
