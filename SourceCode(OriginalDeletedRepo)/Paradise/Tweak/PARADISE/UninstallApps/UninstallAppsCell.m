#import "UninstallAppsCell.h"

@implementation UninstallAppsCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {

    loadPrefs();


    self.baseView = [[UIView alloc] initWithFrame:CGRectZero];
    self.baseView.layer.cornerRadius = 15;
    self.baseView.clipsToBounds = true;
    self.baseView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.baseView];

    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5].active = YES;
    [self.baseView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
    [self.baseView.topAnchor constraintEqualToAnchor:self.topAnchor constant:5].active = YES;
    [self.baseView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5].active = YES;


    self.appImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appImage.layer.cornerRadius = 10;
    self.appImage.clipsToBounds = true;
    [self.baseView addSubview:self.appImage];

    self.appImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.appImage.widthAnchor constraintEqualToConstant:50.0].active = YES;
    [self.appImage.heightAnchor constraintEqualToConstant:50.0].active = YES;
    [[self.appImage centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
    [self.appImage.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10].active = YES;


    self.appnameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.appnameLabel.textColor = [UIColor appdataFontColor];
    self.appnameLabel.font = [UIFont boldSystemFontOfSize:16];
    self.appnameLabel.textAlignment = NSTextAlignmentLeft;
    [self.baseView addSubview:self.appnameLabel];

    self.appnameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.appnameLabel.heightAnchor constraintEqualToConstant:18.0].active = YES;
    [self.appnameLabel.widthAnchor constraintEqualToConstant:220.0].active = YES;
    [[self.appnameLabel centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor constant:-10].active = true;
    [self.appnameLabel.leadingAnchor constraintEqualToAnchor:self.appImage.trailingAnchor constant:10.0].active = YES;


    self.appBIDLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.appBIDLabel.textColor = [UIColor appdataFontColor];
    self.appBIDLabel.font = [UIFont systemFontOfSize:12];
    self.appBIDLabel.textAlignment = NSTextAlignmentLeft;
    [self.baseView addSubview:self.appBIDLabel];

    self.appBIDLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.appBIDLabel.heightAnchor constraintEqualToConstant:14.0].active = YES;
    [self.appBIDLabel.widthAnchor constraintEqualToConstant:220.0].active = YES;
    [self.appBIDLabel.topAnchor constraintEqualToAnchor:self.appnameLabel.bottomAnchor constant:5.0].active = YES;
    [self.appBIDLabel.leadingAnchor constraintEqualToAnchor:self.appImage.trailingAnchor constant:10.0].active = YES;

  }

  return self;
}

@end
