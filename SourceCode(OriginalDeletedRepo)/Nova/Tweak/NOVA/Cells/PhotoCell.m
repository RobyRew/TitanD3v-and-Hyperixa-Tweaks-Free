#import "PhotoCell.h"

@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {


    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = [UIColor clearColor];
    self.baseView.layer.cornerRadius = 8;
    self.baseView.clipsToBounds = true;
    [self.contentView addSubview:self.baseView];
    [self.baseView fill];


    self.photoImages = [[UIImageView alloc] init];
    self.photoImages.contentMode = UIViewContentModeScaleAspectFill;
    self.photoImages.layer.borderWidth = 0.7;
    self.photoImages.layer.borderColor = [UIColor accentColour].CGColor;
    self.photoImages.clipsToBounds = true;
    self.photoImages.layer.cornerRadius = 8;
    [self.baseView addSubview:self.photoImages];
    [self.photoImages fill];


    self.countLabel = [[UILabel alloc] init];
    self.countLabel.textColor = UIColor.whiteColor;
    self.countLabel.font = [UIFont systemFontOfSize:10];
    self.countLabel.layer.cornerRadius = 7.5;
    self.countLabel.clipsToBounds = true;
    self.countLabel.backgroundColor = [UIColor accentColour];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    [self.baseView addSubview:self.countLabel];

    [self.countLabel x:self.baseView.centerXAnchor y:self.baseView.centerYAnchor];
    [self.countLabel size:CGSizeMake(15, 15)];


  }
  return self;
}

@end
