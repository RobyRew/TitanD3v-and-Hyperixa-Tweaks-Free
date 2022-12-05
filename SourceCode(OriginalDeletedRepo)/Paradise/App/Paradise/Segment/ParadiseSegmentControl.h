#import <UIKit/UIKit.h>

@interface ParadiseSegmentControl : UIControl

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *sliderColor;
@property (strong, nonatomic) UIColor *labelTextColorInsideSlider;
@property (strong, nonatomic) UIColor *labelTextColorOutsideSlider;
@property (strong, nonatomic) UIFont *font;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat sliderOffset;

+ (instancetype)switchWithStringsArray:(NSArray *)strings;
- (instancetype)initWithStringsArray:(NSArray *)strings;
- (instancetype)initWithAttributedStringsArray:(NSArray *)strings;

- (void)forceSelectedIndex:(NSInteger)index animated:(BOOL)animated;
- (void)setPressedHandler:(void (^)(NSUInteger index))handler;
- (void)setWillBePressedHandler:(void (^)(NSUInteger index))handler;
- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;

@end
