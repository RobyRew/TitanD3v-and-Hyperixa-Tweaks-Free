#import "ContactCell.h"

@implementation ContactCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {

    self.hideContactsDetails = [[SettingManager sharedInstance] boolForKey:@"hideContactsDetails" defaultValue:NO];


    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.baseView.clipsToBounds = true;
    self.baseView.layer.cornerRadius = 10;
    self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    [self addSubview:self.baseView];

    [self.baseView top:self.topAnchor padding:3];
    [self.baseView leading:self.leadingAnchor padding:2];
    [self.baseView trailing:self.trailingAnchor padding:-2];
    [self.baseView bottom:self.bottomAnchor padding:-3];


    self.avatar = [[UIImageView alloc] init];
    self.avatar.contentMode = UIViewContentModeScaleAspectFill;
    self.avatar.layer.cornerRadius = 25;
    self.avatar.clipsToBounds = YES;
    [self.baseView addSubview:self.avatar];

    [self.avatar size:CGSizeMake(50, 50)];
    [self.avatar leading:self.baseView.leadingAnchor padding:10];
    [self.avatar y:self.baseView.centerYAnchor];


    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = UIColor.labelColor;
    [self.baseView addSubview:self.nameLabel];

    if (!self.hideContactsDetails) {
    self.nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [self.nameLabel top:self.avatar.topAnchor padding:-5];
    [self.nameLabel leading:self.avatar.trailingAnchor padding:10];
    [self.nameLabel trailing:self.baseView.trailingAnchor padding:-10];
    } else {
    self.nameLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    [self.nameLabel y:self.baseView.centerYAnchor];
    [self.nameLabel leading:self.avatar.trailingAnchor padding:10];
    [self.nameLabel trailing:self.baseView.trailingAnchor padding:-10];
    }


    if (!self.hideContactsDetails) {
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.textAlignment = NSTextAlignmentLeft;
    self.numberLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.numberLabel.textColor = UIColor.tertiaryLabelColor;
    [self.baseView addSubview:self.numberLabel];

    [self.numberLabel y:self.baseView.centerYAnchor];
    [self.numberLabel leading:self.avatar.trailingAnchor padding:10];
    [self.numberLabel trailing:self.baseView.trailingAnchor padding:-10];


    self.emailLabel = [[UILabel alloc] init];
    self.emailLabel.textAlignment = NSTextAlignmentLeft;
    self.emailLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.emailLabel.textColor = UIColor.tertiaryLabelColor;
    [self.baseView addSubview:self.emailLabel];

    [self.emailLabel bottom:self.avatar.bottomAnchor padding:2];
    [self.emailLabel leading:self.avatar.trailingAnchor padding:10];
    [self.emailLabel trailing:self.baseView.trailingAnchor padding:-10];
    }

  }

  return self;
}


-(void)prepareForReuse {
  [super prepareForReuse];

  self.avatar.image = nil;
  self.nameLabel.text = nil;
  self.numberLabel.text = nil;
  self.emailLabel.text = nil;
}

@end
