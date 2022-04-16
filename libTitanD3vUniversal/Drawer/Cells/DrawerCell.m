#import "DrawerCell.h"

@implementation DrawerCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {


    self.baseView = [[UIView alloc] initWithFrame:CGRectZero];
    self.baseView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
    self.baseView.layer.cornerRadius = 10;
    if(@available(iOS 13.0, *)) {
      self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    }
    self.baseView.clipsToBounds = true;
    self.baseView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
    self.baseView.layer.borderWidth = 0.5;
    [self addSubview:self.baseView];

    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    [self.baseView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
    [self.baseView.topAnchor constraintEqualToAnchor:self.topAnchor constant:5].active = YES;
    [self.baseView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5].active = YES;


    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImage.layer.cornerRadius = 22.5;
    self.iconImage.clipsToBounds = true;
    [self.baseView addSubview:self.iconImage];

    self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.iconImage.widthAnchor constraintEqualToConstant:45.0].active = YES;
    [self.iconImage.heightAnchor constraintEqualToConstant:45.0].active = YES;
    [[self.iconImage centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
    [self.iconImage.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10.0].active = YES;


    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.baseView addSubview:self.titleLabel];

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.baseView.topAnchor constant:10.0].active = YES;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:10.0].active = YES;


    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
    self.subtitleLabel.font = [UIFont systemFontOfSize:13];
    self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
    self.subtitleLabel.numberOfLines = 1;
    [self.baseView addSubview:self.subtitleLabel];

    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.subtitleLabel.bottomAnchor constraintEqualToAnchor:self.baseView.bottomAnchor constant:-10.0].active = YES;
    [self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:10.0].active = YES;
    [self.subtitleLabel.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-10].active = YES;
  }

  return self;
}

@end
