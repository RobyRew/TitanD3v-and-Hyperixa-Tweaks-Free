#import "TDAlertViewButton.h"

@implementation TDAlertViewButton

+ (id)buttonWithType:(UIButtonType)buttonType {
  return [super buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];

  if (self) {
    [self commonInit];
  }

  return self;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    [self commonInit];
  }

  return self;
}

- (void)commonInit {
  self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
  self.layer.shouldRasterize = YES;

  self.layer.borderWidth = 1.0f;

  self.cornerRadius = 4.0f;
  self.clipsToBounds = YES;

  [self tintColorDidChange];
}

- (void)setHidden:(BOOL)hidden {
  [super setHidden:hidden];
  [self invalidateIntrinsicContentSize];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];

}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
}

- (CGSize)intrinsicContentSize {
  if (self.hidden) {
    return CGSizeZero;
  }

  return CGSizeMake([super intrinsicContentSize].width + 12.0f, 44.0f);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
  [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];

  self.layer.borderColor = self.tintColor.CGColor;

  if (self.type == TDAlertViewButtonTypeBordered) {
    self.layer.borderWidth = 1.0f;
  } else {
    self.layer.borderWidth = 0.0f;
  }

  if (self.state == UIControlStateHighlighted) {

  } else {
    if (self.type == TDAlertViewButtonTypeBordered) {
      self.layer.backgroundColor = nil;
      [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    } else {

    }
  }
}

@end
