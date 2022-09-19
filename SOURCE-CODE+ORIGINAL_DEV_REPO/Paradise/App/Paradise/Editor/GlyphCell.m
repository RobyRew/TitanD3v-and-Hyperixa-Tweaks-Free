#import "GlyphCell.h"

@implementation GlyphCell


- (id)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    self.baseView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.baseView.clipsToBounds = YES;
    [self.contentView addSubview:self.baseView];


    self.iconImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImage];

    self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.iconImage.widthAnchor constraintEqualToConstant:40.0].active = YES;
    [self.iconImage.heightAnchor constraintEqualToConstant:40.0].active = YES;
    [[self.iconImage centerXAnchor] constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [[self.iconImage centerYAnchor] constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;

  }
  return self;
}


@end
