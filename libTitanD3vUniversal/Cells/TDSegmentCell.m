#import "TDSegmentCell.h"

@implementation TDSegmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		specifier.properties[@"height"] = [NSNumber numberWithInt:70];

		self.containerColour = [[TDAppearance sharedInstance] containerColour];
		self.tintColour = [[TDAppearance sharedInstance] tintColour];
		self.labelColour = [[TDAppearance sharedInstance] labelColour];


		if (@available(iOS 13.0, *)) {
			((UISegmentedControl *)self.control).selectedSegmentTintColor = self.tintColour;
		}


		self.headerLabel = [[UILabel alloc] init];
		self.headerLabel.text = specifier.properties[@"title"];
		[self addSubview:self.headerLabel];

		self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.headerLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
		[self.headerLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15].active = YES;


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



- (void)layoutSubviews {
	[super layoutSubviews];

	CGRect newHeight = self.control.frame;
	newHeight.size.height = 30;
	self.control.frame = newHeight;

	[self.control setFrame:CGRectOffset(self.control.frame, 0, 28)];

}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
