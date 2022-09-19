#import "CrewCell.h"

@implementation CrewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {

    self.tintColour = [[TDAppearance sharedInstance] tintColour];


    self.baseView = [[UIView alloc] initWithFrame:CGRectZero];
    self.baseView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
    self.baseView.layer.cornerRadius = 20;
    if(@available(iOS 13.0, *)) {
      self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    }
    self.baseView.clipsToBounds = true;
    self.baseView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
    self.baseView.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.baseView];

    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
    [self.baseView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10].active = YES;
    [self.baseView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
    [self.baseView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = YES;


    self.bannerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120)];
    [self.bannerImage setContentMode:UIViewContentModeScaleToFill];
    [self.baseView addSubview:self.bannerImage];


    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImage.layer.cornerRadius = 50;
    self.iconImage.clipsToBounds = true;
    self.iconImage.layer.borderWidth = 1;
    self.iconImage.layer.borderColor = self.tintColour.CGColor;
    [self.baseView addSubview:self.iconImage];

    self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.iconImage.widthAnchor constraintEqualToConstant:100.0].active = YES;
    [self.iconImage.heightAnchor constraintEqualToConstant:100.0].active = YES;
    [[self.iconImage centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
    [self.iconImage.topAnchor constraintEqualToAnchor:self.bannerImage.bottomAnchor constant:-70].active = YES;


    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.textColor = UIColor.whiteColor;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:20];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.baseView addSubview:self.nameLabel];

    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.nameLabel centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:20.0].active = YES;


    self.roleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.roleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.7];
    self.roleLabel.font = [UIFont systemFontOfSize:16];
    self.roleLabel.textAlignment = NSTextAlignmentCenter;
    [self.baseView addSubview:self.roleLabel];

    self.roleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.roleLabel centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
    [self.roleLabel.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:10.0].active = YES;


    self.followLabel = [[UILabel alloc] init];
    self.followLabel.backgroundColor = self.tintColour;
    self.followLabel.text = @"Follow";
    self.followLabel.layer.cornerRadius = 22.5;
    self.followLabel.font = [UIFont systemFontOfSize:18];
    self.followLabel.textAlignment = NSTextAlignmentCenter;
    self.followLabel.clipsToBounds = true;
    self.followLabel.textColor = UIColor.whiteColor;
    [self.baseView addSubview:self.followLabel];

    self.followLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.followLabel.widthAnchor constraintEqualToConstant:100].active = YES;
    [self.followLabel.heightAnchor constraintEqualToConstant:45].active = YES;
    [[self.followLabel centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
    [self.followLabel.topAnchor constraintEqualToAnchor:self.roleLabel.bottomAnchor constant:10].active = YES;


  }

  return self;
}


-(void)layoutSubviews {

  CALayer *mask = [CALayer layer];
  mask.contents = (id)[[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/crew-mask.png"] CGImage];
  mask.frame = CGRectMake(0, 0, self.frame.size.width, 120);
  self.bannerImage.layer.mask = mask;
  self.bannerImage.layer.masksToBounds = YES;

  self.bannerImage.frame = CGRectMake(0, 0, self.frame.size.width, 120);
}

@end
