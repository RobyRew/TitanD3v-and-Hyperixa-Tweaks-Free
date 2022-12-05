#import "FavouriteCell.h"

@implementation FavouriteCell

- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    self.layer.cornerRadius = 15;
    self.layer.cornerCurve = kCACornerCurveContinuous;
    self.clipsToBounds = true;

    self.accentColour = [[SettingManager sharedInstance] accentColour];


    self.baseView = [[UIView alloc] init];
    self.baseView.layer.cornerRadius = 15;
    self.baseView.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.baseView.clipsToBounds = true;
    self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    [self.contentView addSubview:self.baseView];

    [self.baseView fill];


    self.avatarImage = [[UIImageView alloc] init];
    self.avatarImage.layer.cornerRadius = 30;
    self.avatarImage.clipsToBounds = true;
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.baseView addSubview:self.avatarImage];

    [self.avatarImage size:CGSizeMake(60, 60)];
    [self.avatarImage top:self.baseView.topAnchor padding:10];
    [self.avatarImage x:self.baseView.centerXAnchor];


    self.iconView = [[UIView alloc] init];
    self.iconView.layer.cornerRadius = 12.5;
    self.iconView.clipsToBounds = YES;
    [self.baseView addSubview:self.iconView];

    [self.iconView size:CGSizeMake(25, 25)];
    [self.iconView bottom:self.avatarImage.bottomAnchor padding:4];
    [self.iconView trailing:self.avatarImage.trailingAnchor padding:4];


    self.iconImage = [[UIImageView alloc] init];
    self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImage.tintColor = UIColor.whiteColor;
    [self.iconView addSubview:self.iconImage];

    [self.iconImage size:CGSizeMake(17.5, 17.5)];
    [self.iconImage x:self.iconView.centerXAnchor y:self.iconView.centerYAnchor];


    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor labelColor];
    [self.baseView addSubview:self.nameLabel];

    [self.nameLabel top:self.avatarImage.bottomAnchor padding:7];
    [self.nameLabel x:self.baseView.centerXAnchor];
    [self.nameLabel leading:self.baseView.leadingAnchor padding:5];
    [self.nameLabel trailing:self.baseView.trailingAnchor padding:-5];


    self.actionView = [[UIView alloc] init];
    [self.baseView addSubview:self.actionView];

    [self.actionView height:40];
    [self.actionView leading:self.baseView.leadingAnchor padding:15];
    [self.actionView trailing:self.baseView.trailingAnchor padding:-15];
    [self.actionView bottom:self.baseView.bottomAnchor padding:-7];


    self.favCallButton = [[UIButton alloc] init];
    UIImage *callImage = [UIImage systemImageNamed:@"phone.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:20]];
    [self.favCallButton setImage:callImage forState:UIControlStateNormal];
    self.favCallButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.favCallButton.tintColor = self.accentColour;
    self.favCallButton.layer.cornerRadius = 10;
    self.favCallButton.layer.cornerCurve = kCACornerCurveContinuous;
    self.favCallButton.backgroundColor = [self.accentColour colorWithAlphaComponent:0.4];
    [self.favCallButton addTarget:self action:@selector(callButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.favCallButton size:CGSizeMake(40, 40)];


    self.favMessageButton = [[UIButton alloc] init];
    UIImage *messageImage = [UIImage systemImageNamed:@"message.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:20]];
    [self.favMessageButton setImage:messageImage forState:UIControlStateNormal];
    self.favMessageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.favMessageButton.tintColor = self.accentColour;
    self.favMessageButton.layer.cornerRadius = 10;
    self.favMessageButton.layer.cornerCurve = kCACornerCurveContinuous;
    self.favMessageButton.backgroundColor = [self.accentColour colorWithAlphaComponent:0.4];
    [self.favMessageButton addTarget:self action:@selector(messageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.favMessageButton size:CGSizeMake(40, 40)];


    self.favEmailButton = [[UIButton alloc] init];
    UIImage *emailImage = [UIImage systemImageNamed:@"envelope.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:20]];
    [self.favEmailButton setImage:emailImage forState:UIControlStateNormal];
    self.favEmailButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.favEmailButton.tintColor = self.accentColour;
    self.favEmailButton.layer.cornerRadius = 10;
    self.favEmailButton.layer.cornerCurve = kCACornerCurveContinuous;
    self.favEmailButton.backgroundColor = [self.accentColour colorWithAlphaComponent:0.4];
    [self.favEmailButton addTarget:self action:@selector(emailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.favEmailButton size:CGSizeMake(40, 40)];


    self.favStackView = [[UIStackView alloc] init];
    self.favStackView.axis = UILayoutConstraintAxisHorizontal;
    self.favStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.favStackView.alignment = UIStackViewAlignmentCenter;
    self.favStackView.spacing = 10;
    [self.actionView addSubview:self.favStackView];

    [self.favStackView x:self.actionView.centerXAnchor y:self.actionView.centerYAnchor];

  }
  return self;
}


-(void)prepareForReuse {
  [super prepareForReuse];

  self.avatarImage.image = nil;
  self.nameLabel.text = nil;
  self.iconImage.image = nil;
  [self.favStackView removeArrangedSubview:self.favCallButton];
  [self.favStackView removeArrangedSubview:self.favMessageButton];
  [self.favStackView removeArrangedSubview:self.favEmailButton];

  [self.favCallButton removeFromSuperview];
  [self.favMessageButton removeFromSuperview];
  [self.favEmailButton removeFromSuperview];

}


- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  self.backgroundColor = highlighted ? UIColor.secondarySystemBackgroundColor : UIColor.secondarySystemBackgroundColor;
}


-(void)callButtonPressed:(id)sender {
  [self.favouriteDelegate callButtonTappedForCell:self];
}


-(void)messageButtonPressed:(id)sender {
  [self.favouriteDelegate messageButtonTappedForCell:self];
}


-(void)emailButtonPressed:(id)sender {
  [self.favouriteDelegate emailButtonTappedForCell:self];
}

@end
