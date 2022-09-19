#import "ContactCell.h"

@implementation ContactCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {

    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = [UIColor cellColour];
    self.baseView.layer.cornerRadius = 15;
    self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    self.baseView.clipsToBounds = true;
    [self addSubview:self.baseView];

    [self.baseView top:self.topAnchor padding:15];
    [self.baseView leading:self.leadingAnchor padding:10];
    [self.baseView trailing:self.trailingAnchor padding:-10];
    [self.baseView bottom:self.bottomAnchor padding:-5];


    self.menuButton = [[UIButton alloc] init];
    UIImage *menuImage = [UIImage systemImageNamed:@"ellipsis"];
    [self.menuButton setImage:menuImage forState:UIControlStateNormal];
    self.menuButton.transform = CGAffineTransformMakeRotation(M_PI / 2);
    self.menuButton.tintColor = [UIColor accentColour];
    [self.contentView addSubview:self.menuButton];

    [self.menuButton size:CGSizeMake(40, 40)];
    [self.menuButton top:self.baseView.topAnchor padding:5];
    [self.menuButton trailing:self.baseView.trailingAnchor padding:5];


    self.avatarImage = [[UIImageView alloc] init];
    self.avatarImage.layer.cornerRadius = 45;
    self.avatarImage.clipsToBounds = true;
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.avatarImage];

    [self.avatarImage size:CGSizeMake(90, 90)];
    [self.avatarImage x:self.baseView.centerXAnchor];
    [self.avatarImage top:self.baseView.topAnchor padding:10];


    self.contactButton = [[UIButton alloc] init];
    [self.contactButton addTarget:self action:@selector(contactButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contactButton setTitle:@"Choose Contact" forState:UIControlStateNormal];
    [self.contactButton setTitleColor:[UIColor accentColour] forState:UIControlStateNormal];
    self.contactButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contactButton];

    [self.contactButton top:self.avatarImage.bottomAnchor padding:5];
    [self.contactButton x:self.baseView.centerXAnchor];
    [self.contactButton height:13];


    self.personImage = [[UIImageView alloc] init];
    self.personImage.image = [UIImage systemImageNamed:@"person.crop.circle"];
    self.personImage.tintColor = [UIColor iconTintColour];
    self.personImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.baseView addSubview:self.personImage];

    [self.personImage size:CGSizeMake(40, 40)];
    [self.personImage top:self.contactButton.bottomAnchor padding:10];
    [self.personImage leading:self.baseView.leadingAnchor padding:10];


    self.nameTitleLabel = [[UILabel alloc] init];
    self.nameTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.nameTitleLabel.text = @"Name";
    self.nameTitleLabel.font = [UIFont systemFontOfSize:12];
    self.nameTitleLabel.alpha = 0.7;
    self.nameTitleLabel.textColor = [UIColor fontColour];
    [self.baseView addSubview:self.nameTitleLabel];

    [self.nameTitleLabel top:self.personImage.topAnchor padding:2];
    [self.nameTitleLabel leading:self.personImage.trailingAnchor padding:10];


    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
    self.nameLabel.textColor = [UIColor fontColour];
    [self.baseView addSubview:self.nameLabel];

    [self.nameLabel bottom:self.personImage.bottomAnchor padding:-2];
    [self.nameLabel leading:self.personImage.trailingAnchor padding:10];


    self.splitView = [[UIView alloc] init];
    self.splitView.backgroundColor = [UIColor separatorColour];
    self.splitView.layer.cornerRadius = 1;
    [self.baseView addSubview:self.splitView];

    [self.splitView x:self.baseView.centerXAnchor];
    [self.splitView height:2];
    [self.splitView top:self.nameLabel.bottomAnchor padding:10];
    [self.splitView leading:self.baseView.leadingAnchor padding:20];
    [self.splitView trailing:self.baseView.trailingAnchor padding:-20];


    self.phoneImage = [[UIImageView alloc] init];
    self.phoneImage.image = [UIImage systemImageNamed:@"phone.circle"];
    self.phoneImage.tintColor = [UIColor iconTintColour];
    self.phoneImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.baseView addSubview:self.phoneImage];

    [self.phoneImage size:CGSizeMake(40, 40)];
    [self.phoneImage top:self.splitView.bottomAnchor padding:10];
    [self.phoneImage leading:self.baseView.leadingAnchor padding:10];


    self.phoneTitleLabel = [[UILabel alloc] init];
    self.phoneTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.phoneTitleLabel.text = @"Phone";
    self.phoneTitleLabel.font = [UIFont systemFontOfSize:12];
    self.phoneTitleLabel.alpha = 0.7;
    self.phoneTitleLabel.textColor = [UIColor fontColour];
    [self.baseView addSubview:self.phoneTitleLabel];

    [self.phoneTitleLabel top:self.phoneImage.topAnchor padding:2];
    [self.phoneTitleLabel leading:self.phoneImage.trailingAnchor padding:10];


    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.textAlignment = NSTextAlignmentLeft;
    self.phoneLabel.textColor = [UIColor fontColour];
    self.phoneLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.baseView addSubview:self.phoneLabel];

    [self.phoneLabel bottom:self.phoneImage.bottomAnchor padding:-2];
    [self.phoneLabel leading:self.phoneImage.trailingAnchor padding:10];

  }

  return self;
}


- (void)contactButtonPressed:(id)sender {
  [self.contactDelegate contactButtonTappedForCell:self];
}

@end
