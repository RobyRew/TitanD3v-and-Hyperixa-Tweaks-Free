#import "TDImage.h"

@implementation TDImage

- (instancetype _Nullable )initWithImage:(nullable UIImage *)image tint:(BOOL)tint tintColour:(UIColor *_Nullable)tintColour corner:(CGFloat)corner {

  self = [super init];
  if (self) {

    if (tint) {
      self.tintColor = tintColour;
    }

    self.image = image;
    self.layer.cornerRadius = corner;
    self.userInteractionEnabled = true;

  }
  return self;


}

@end
