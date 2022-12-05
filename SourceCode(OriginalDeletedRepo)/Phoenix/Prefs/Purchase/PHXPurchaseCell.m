#import "PHXPurchaseCell.h"

@implementation PHXPurchaseCell

- (id)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    self.layer.cornerRadius = 15;
    self.clipsToBounds = true;

    self.baseView = [[BlurBannerView alloc] init];
    [self.contentView addSubview:self.baseView];

    [self.baseView fill];

    self.screenshotImage = [[UIImageView alloc] init];
    [self.baseView addSubview:self.screenshotImage];

    [self.screenshotImage fill];

  }
  return self;
}

@end
