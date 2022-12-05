#import "TDSwitchCell.h"

@implementation TDSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		specifier.properties[@"height"] = [NSNumber numberWithInt:70];

		self.containerColour = [[TDAppearance sharedInstance] containerColour];
		self.tintColour = [[TDAppearance sharedInstance] tintColour];
		self.labelColour = [[TDAppearance sharedInstance] labelColour];

		((UISwitch *)self.control).onTintColor = self.tintColour;

		NSString *customIconPath = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", specifier.properties[@"iconName"]];


		self.iconImage = [[UIImageView alloc]init];
		self.iconImage.image = [UIImage imageWithContentsOfFile:customIconPath];
		self.iconImage.layer.cornerRadius = 20;
		self.iconImage.clipsToBounds = true;
		[self addSubview:self.iconImage];

		self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
		[self.iconImage.widthAnchor constraintEqualToConstant:40.0].active = YES;
		[self.iconImage.heightAnchor constraintEqualToConstant:40.0].active = YES;
		[[self.iconImage centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.iconImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:13].active = YES;


		self.headerLabel = [[UILabel alloc] init];
		[self.headerLabel setText:specifier.properties[@"title"]];
		[self.headerLabel setFont:[self.headerLabel.font fontWithSize:15]];
		[self addSubview:self.headerLabel];

		self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.headerLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor constant:-9].active = true;
		[self.headerLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:12].active = YES;


		self.subtitleLabel = [[UILabel alloc]init];
		[self.subtitleLabel setText:specifier.properties[@"subtitle"]];
		[self.subtitleLabel setFont:[self.subtitleLabel.font fontWithSize:10]];
		[self addSubview:self.subtitleLabel];

		self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.subtitleLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor constant:9].active = true;
		[self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:12].active = YES;


		showTips = specifier.properties[@"showTips"] && [specifier.properties[@"showTips"] boolValue];


		if (showTips) {

			self.tipsButton = [[UIButton alloc] init];
			self.tipsButton.backgroundColor = self.tintColour;
			UIImage *tipsImage = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Tips/tips.png"];
			[self.tipsButton setImage:tipsImage forState:UIControlStateNormal];
			self.tipsButton.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
			[self.tipsButton addTarget:self action:@selector(showTipsTapped:) forControlEvents:UIControlEventTouchUpInside];
			self.tipsButton.layer.cornerRadius = 10;
			[self.contentView addSubview:self.tipsButton];

			self.tipsButton.translatesAutoresizingMaskIntoConstraints = NO;
			[self.tipsButton.widthAnchor constraintEqualToConstant:20.0].active = YES;
			[self.tipsButton.heightAnchor constraintEqualToConstant:20.0].active = YES;
			[[self.tipsButton centerYAnchor] constraintEqualToAnchor:self.headerLabel.centerYAnchor].active = true;
			[self.tipsButton.leadingAnchor constraintEqualToAnchor:self.headerLabel.trailingAnchor constant:5].active = YES;

		}

	}

	return self;
}


-(void)showTipsTapped:(UIButton *)sender {

	[[TDUtilities sharedInstance] haptic:0];

	NSString *titleString = self.specifier.properties[@"tipsTitle"];
	NSString *messageString = self.specifier.properties[@"tipsMessage"];
	NSString *tipsImagePath = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Tips/%@.png", self.specifier.properties[@"tipsImage"]];
	UIImage *tipsImage = [UIImage imageWithContentsOfFile:tipsImagePath];

	tipsImageStyle = [self.specifier.properties[@"tipsImageStyle"]integerValue];


	TDAlertViewControllerConfiguration *configuration = [TDAlertViewControllerConfiguration new];
	configuration.alertViewBackgroundColor = self.containerColour;
	configuration.titleTextColor = self.labelColour;
	configuration.messageTextColor = self.labelColour;
	configuration.transitionStyle = TDAlertViewControllerTransitionStyleSlideFromTop;
	configuration.backgroundTapDismissalGestureEnabled = YES;
	configuration.swipeDismissalGestureEnabled = YES;
	configuration.alwaysArrangesActionButtonsVertically = YES;
	configuration.buttonConfiguration.titleColor = self.tintColour;
	configuration.cancelButtonConfiguration.titleColor = self.tintColour;
	configuration.cancelButtonConfiguration.titleFont = [UIFont systemFontOfSize:16];
	configuration.alertViewCornerRadius = 20;
	configuration.showsSeparators = NO;


	TDAlertAction *okAction = [[TDAlertAction alloc] initWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];

	TDAlertViewController *alertViewController = [[TDAlertViewController alloc] initWithOptions:configuration title:titleString message:messageString actions:@[okAction]];


	if (tipsImageStyle == 0) {

		UIImageView *iconImageView = [[UIImageView alloc] initWithImage:tipsImage];
		iconImageView.contentMode = UIViewContentModeScaleAspectFit;
		[iconImageView.heightAnchor constraintEqualToConstant:80.0f].active = YES;
		alertViewController.alertViewContentView = iconImageView;

	} else {

		UIImageView *bannerImageView = [[UIImageView alloc] initWithImage:tipsImage];
		bannerImageView.clipsToBounds = YES;
		bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
		[bannerImageView.heightAnchor constraintEqualToConstant:120.0f].active = YES;
		alertViewController.alertViewContentView = bannerImageView;

	}


	UIViewController *prefsController = [self _viewControllerForAncestor];
	[prefsController presentViewController:alertViewController animated:YES completion:nil];

}


// - (void)layoutSubviews {
// 	[super layoutSubviews];

// 	[self.control setFrame:CGRectOffset(self.control.frame, -10, 0)];

// }


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
