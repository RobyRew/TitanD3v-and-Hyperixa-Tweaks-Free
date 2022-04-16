#import "TDColorSlider.h"
#import "TDGradientView.h"
#import "UIColor+ChromaPicker_Internal.h"


@implementation UILabel (Private)

+ (instancetype)sliderLabel {
  UILabel *label = [UILabel new];
  label.numberOfLines = 1;
  label.font = [UIFont systemFontOfSize:16 weight: UIFontWeightLight];
  label.backgroundColor = UIColor.clearColor;
  label.textAlignment = NSTextAlignmentCenter;
  return label;
}
@end

@implementation TDColorSlider {
  UIVisualEffectView *_grabberEffectView;
  TDGradientView *_trackGradientView;
  UILabel *_leadingLabel;
  UILabel *_trailingLabel;
}

- (instancetype)initWithSliderType:(TDSliderType)type color:(UIColor *)color {
  if (self == [super init]) {
    [self configureWithType:type color:color];
  }
  return self;
}

- (void)configureWithType:(TDSliderType)type color:(UIColor *)color {
  [self setMinimumTrackImage:UIImage.new forState:UIControlStateNormal];
  [self setMaximumTrackImage:UIImage.new forState:UIControlStateNormal];

  self.minimumValueImage = [UIColor.clearColor imageWithSize:CGSizeMake(30, 1)];
  self.maximumValueImage = [UIColor.clearColor imageWithSize:CGSizeMake(30, 1)];

  UIView *grabber = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
  if (@available(iOS 13.0, *)) {
    grabber.layer.cornerCurve = kCACornerCurveContinuous;
  }
  grabber.layer.cornerRadius = 12;
  grabber.layer.borderWidth = 5;

  [self setThumbImage:[UIColor.clearColor imageWithSize:CGSizeMake(24, 24)] forState:UIControlStateNormal];
  _grabberEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
  _grabberEffectView.userInteractionEnabled = NO;
  _grabberEffectView.maskView = grabber;
  [self addSubview:_grabberEffectView];

  _trackGradientView = [[TDGradientView alloc] initWithColors:@[]];
  [self.layer insertSublayer:_trackGradientView atIndex:0];

  _leadingLabel = UILabel.sliderLabel;
  [self addSubview:_leadingLabel];
  _leadingLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [_leadingLabel.widthAnchor constraintEqualToConstant: 30].active = YES;
  [_leadingLabel.centerYAnchor constraintEqualToAnchor: self.centerYAnchor].active = YES;
  [_leadingLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor].active = YES;

  _trailingLabel = UILabel.sliderLabel;
  [self addSubview:_trailingLabel];
  _trailingLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [_trailingLabel.widthAnchor constraintEqualToConstant: 30].active = YES;
  [_trailingLabel.centerYAnchor constraintEqualToAnchor: self.centerYAnchor].active = YES;
  [_trailingLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor].active = YES;

  _leadingLabel.text = sliderTypeShortName(type);
  self.maximumValue = sliderTypeMaxValue(type);

  _type = type;
  [self setColor:color];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect rect = [self trackRectForBounds:self.bounds];
  _trackGradientView.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) - 10, CGRectGetWidth(rect), 20);
  _grabberEffectView.frame = [self thumbRectForBounds:self.bounds trackRect:rect value:self.value];
}

- (void)setColor:(UIColor *)color {
  _colorValue = color;
  if (_type != TDSliderTypeHue || _trackGradientView.colors.count < 2) {
    [_trackGradientView setColorsForSliderType:_type primaryColor:color];
  }
  self.value = [color valueForType:_type] * self.maximumValue;
  _trailingLabel.text = [NSString stringWithFormat:@"%.f", self.value];
}

- (void)_updateSlider:(BOOL)finalized {
  if (self.delegate && [self.delegate respondsToSelector:@selector(slider:valueChanged:)]) {
    [self.delegate slider:self valueChanged:self.value];
  }
  if (self.delegate && [self.delegate respondsToSelector:@selector(slider:valueFinishedChange:)]) {
    [self.delegate slider:self valueFinishedChange:self.value];
  }
  _trailingLabel.text = [NSString stringWithFormat:@"%.f", self.value];
}

- (CGSize)intrinsicContentSize {
  return CGSizeMake(200, 40);
}

#pragma mark - UISliderTracking
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL tracking = [super beginTrackingWithTouch:touch withEvent:event];
  [self _updateSlider:NO];
  return tracking;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL tracking = [super continueTrackingWithTouch:touch withEvent:event];
  [self _updateSlider:NO];
  return tracking;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  [super endTrackingWithTouch:touch withEvent:event];
  [self _updateSlider:YES];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
  [super cancelTrackingWithEvent:event];
  [self _updateSlider:YES];
}

@end
