#import "TDReportCell.h"

@implementation TDReportCell


- (id)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    self.baseView = [[UIView alloc] init];
    self.baseView.clipsToBounds = YES;
    self.baseView.layer.cornerRadius = 10;
    if(@available(iOS 13.0, *)) {
      self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    }
    [self.contentView addSubview:self.baseView];

    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.baseView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [self.baseView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [self.baseView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;


    self.iconImage = [[UIImageView alloc] init];
    [self.baseView addSubview:self.iconImage];

    self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.iconImage.widthAnchor constraintEqualToConstant:25.0].active = YES;
    [self.iconImage.heightAnchor constraintEqualToConstant:25.0].active = YES;
    [self.iconImage.topAnchor constraintEqualToAnchor:self.baseView.topAnchor constant:5].active = YES;
    [self.iconImage.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-5].active = YES;


    self.appLabel = [[UILabel alloc] init];
    self.appLabel.font = [UIFont systemFontOfSize:16];
    self.appLabel.textAlignment = NSTextAlignmentLeft;
    self.appLabel.numberOfLines = 2;
    [self.baseView addSubview:self.appLabel];

    self.appLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.appLabel centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = YES;
    [self.appLabel.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10].active = YES;
    [self.appLabel.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant: -15].active = YES;
      
  }
  return self;
}


@end
