#import "TDBannerView.h"

NSDate *todaysDate;
NSDateFormatter *todaysDateFormat;
NSString *todaysDateString;

@implementation TDBannerView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

    self.backgroundColor = UIColor.clearColor;

    self.bannerColour = [[TDAppearance sharedInstance] bannerColour];
    self.labelColour = [[TDAppearance sharedInstance] labelColour];
    self.tintColour = [[TDAppearance sharedInstance] tintColour];


    NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
    NSString *bannerCoverPath = [[TDPrefsManager sharedInstance] getBannerCoverPath];
    NSString *bannerCoverString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, bannerCoverPath];
    NSString *bannerIconPath = [[TDPrefsManager sharedInstance] getBannerIconPath];
    NSString *bannerIconString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, bannerIconPath];

    BOOL useBanner = [[TDPrefsManager sharedInstance] bannerWithCoverImage];
    BOOL iconTint = [[TDPrefsManager sharedInstance] bannerWithIconTint];


    self.baseView = [[UIView alloc] init];
    self.baseView.layer.cornerRadius = 25;
    if(@available(iOS 13.0, *)) {
      self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    }
    if (useBanner) {
      self.baseView.backgroundColor = UIColor.clearColor;;
    } else {
      self.baseView.backgroundColor = self.bannerColour;
    }
    self.baseView.clipsToBounds = true;
    [self addSubview:self.baseView];


    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [self.baseView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    [self.baseView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
    [self.baseView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;


    self.bannerImage = [[UIImageView alloc] init];
    self.bannerImage.contentMode = UIViewContentModeScaleAspectFill;
    self.bannerImage.image = [[UIImage imageWithContentsOfFile:bannerCoverString]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (useBanner) {
      self.bannerImage.alpha = 1;
    } else {
      self.bannerImage.alpha = 0;
    }
    [self.baseView addSubview:self.bannerImage];

    self.bannerImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bannerImage.topAnchor constraintEqualToAnchor:self.baseView.topAnchor].active = YES;
    [self.bannerImage.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor].active = YES;
    [self.bannerImage.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor].active = YES;
    [self.bannerImage.bottomAnchor constraintEqualToAnchor:self.baseView.bottomAnchor].active = YES;


    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconImage.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImage.userInteractionEnabled = true;
    self.iconImage.alpha = 0;
    if (iconTint) {
      self.iconImage.image = [[UIImage imageWithContentsOfFile:bannerIconString]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      self.iconImage.tintColor = self.tintColour;
    } else {
      self.iconImage.image = [[UIImage imageWithContentsOfFile:bannerIconString]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [self.baseView addSubview:self.iconImage];

    self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.iconImage.widthAnchor constraintEqualToConstant:90].active = YES;
    [self.iconImage.heightAnchor constraintEqualToConstant:90].active = YES;
    [[self.iconImage centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
    [[self.iconImage centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor constant:-35].active = true;


    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = [[TDPrefsManager sharedInstance] getBannerTitle];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    self.titleLabel.textColor = self.labelColour;
    self.titleLabel.alpha = 0;
    [self.baseView addSubview:self.titleLabel];

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant: 10].active = YES;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant: 10].active = YES;
    [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant: -10].active = YES;


    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.text = [[TDPrefsManager sharedInstance] getBannerSubtitle];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.font = [UIFont systemFontOfSize:14];
    self.subtitleLabel.textColor = self.labelColour;
    self.subtitleLabel.alpha = 0;
    [self.baseView addSubview:self.subtitleLabel];

    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.subtitleLabel centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
    [self.subtitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant: 10].active = YES;
    [self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant: 10].active = YES;
    [self.subtitleLabel.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant: -10].active = YES;


    NSString *birthdayDate = [[TDPrefsManager sharedInstance] objectForKey:@"profileDOB" defaultValue:@"22/11"];
    NSString *devName = [[TDPrefsManager sharedInstance] getDeveloperName];
    NSString *developerString = [NSString stringWithFormat:@"From %@", devName];

    todaysDate = [NSDate date];
    todaysDateFormat = [[NSDateFormatter alloc] init];
    [todaysDateFormat setDateFormat:@"dd/MM"];
    todaysDateString = [todaysDateFormat stringFromDate:todaysDate];

    if ([todaysDateString isEqualToString:birthdayDate]) {

      self.titleLabel.text = @"Happy Birthday";
      self.subtitleLabel.text = developerString;

      self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Events/birthday.png"];

    }


    NSDate * now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *monthComponents = [gregorian components:NSCalendarUnitMonth fromDate:now];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:now];


    if ([dayComponents day] == 4 && [monthComponents month] == 7) {

      self.titleLabel.text = @"Happy 4th July";
      self.subtitleLabel.text = developerString;
      self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Events/fourth-july.png"];

    } else if ([dayComponents day] == 31 && [monthComponents month] == 10) {

      self.titleLabel.text = @"Happy Halloween";
      self.subtitleLabel.text = developerString;
      self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Events/halloween.png"];

    } else if ([dayComponents day] == 25 && [monthComponents month] == 12) {

      self.titleLabel.text = @"Merry Christmas";
      self.subtitleLabel.text = developerString;
      self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Events/christmas.png"];
      self.iconImage.layer.borderColor = UIColor.clearColor.CGColor;

    } else if ([dayComponents day] == 31 && [monthComponents month] == 12) {

      self.titleLabel.text = @"Happy New Year Eve";
      self.subtitleLabel.text = developerString;
      self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Events/nye.png"];

    } else if ([dayComponents day] == 1 && [monthComponents month] == 1) {

      self.titleLabel.text = @"Happy New Year";
      self.subtitleLabel.text = developerString;
      self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Events/nyd.png"];

    }


  }

  return self;
}


-(void)didMoveToSuperview {
  [super didMoveToSuperview];
  [self fadeInBanner];
}


-(void)fadeInBanner {

  [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    self.iconImage.alpha = 1;
    self.titleLabel.alpha = 1;
    self.subtitleLabel.alpha = 1;
  } completion:nil];

}


@end
