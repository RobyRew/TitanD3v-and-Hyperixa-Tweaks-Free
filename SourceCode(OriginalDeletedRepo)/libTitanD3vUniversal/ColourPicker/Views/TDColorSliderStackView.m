#import "TDColorSliderStackView.h"
#import "TDColorSlider.h"
#import "TDColorDisplayView.h"
#import "UIColor+ChromaPicker_Internal.h"

@implementation TDColorSliderStackView {
  NSArray *_sliders;
  UIColor *_color;
  TDColorSpaceType _type;
}

- (instancetype)initWithColor:(UIColor *)color stackType:(TDColorSpaceType)type delegate:(id<TDColorPickerDelegate>)delegate {
  if (self == [super init]) {
    self.delegate = delegate;
    [self configureForStackType:type color:color];
  }
  return self;
}

- (void)configureForStackType:(TDColorSpaceType)type color:(UIColor *)color {
  self.axis = UILayoutConstraintAxisVertical;
  self.alignment = UIStackViewAlignmentFill;
  self.distribution = UIStackViewDistributionFillEqually;
  self.spacing = 8;

  _type = type;
  _color = color;

  switch (type) {

    case TDColorSpaceTypeRGB:
    _sliders = @[
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeRed color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeGreen color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeBlue color:color]
    ];
    break;
    case TDColorSpaceTypeRGBA:
    _sliders = @[
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeRed color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeGreen color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeBlue color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeAlpha color:color],
    ];
    break;
    case TDColorSpaceTypeHSB:
    _sliders = @[
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeHue color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeSaturation color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeBrightness color:color]
    ];
    break;
    case TDColorSpaceTypeHSBA:
    _sliders = @[
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeHue color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeSaturation color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeBrightness color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeAlpha color:color]
    ];
    break;
    case TDColorSpaceTypeCMYK:
    _sliders = @[
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeCyan color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeMagenta color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeYellow color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeBlack color:color]
    ];
    break;
    case TDColorSpaceTypeCMYKA:
    _sliders = @[
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeCyan color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeMagenta color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeYellow color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeBlack color:color],
    [[TDColorSlider alloc] initWithSliderType:TDSliderTypeAlpha color:color]
    ];
    break;
  }

  [self.arrangedSubviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
    [self removeArrangedSubview:obj];
    [obj removeConstraints:obj.constraints];
    [obj removeFromSuperview];
  }];

  for (TDColorSlider *slider in _sliders) {
    slider.delegate = self;
    [self addArrangedSubview:slider];
  }
}

- (void)applyColorExcludingSlider:(TDColorSlider *)excludingSlider {
  if (self.delegate && [self.delegate respondsToSelector:@selector(colorPickerDidUpdateColor:)])
  [self.delegate colorPickerDidUpdateColor:_color];

  for (TDColorSlider *slider in _sliders) {
    if (slider != excludingSlider) {
      [slider setColor:_color];
    }
  }
}

- (void)setColor:(UIColor *)color {
  _color = color;
  [self applyColorExcludingSlider:nil];
}

#pragma mark - TDColorSliderDelegate

- (void)slider:(TDColorSlider *)colorSlider colorChanged:(UIColor *)color {
  _color = color;
  [self applyColorExcludingSlider:colorSlider];
}

- (void)slider:(TDColorSlider *)colorSlider valueChanged:(CGFloat)value {
  _color = [_color colorByApplyingValue:value / colorSlider.maximumValue sliderType:colorSlider.type];
  [self applyColorExcludingSlider:colorSlider];
}

- (void)slider:(TDColorSlider *)colorSlider valueFinishedChange:(CGFloat)value {
  if (self.delegate && [self.delegate respondsToSelector:@selector(colorPickerDidChangeColor:)])
  [self.delegate colorPickerDidChangeColor:_color];
}


@end
