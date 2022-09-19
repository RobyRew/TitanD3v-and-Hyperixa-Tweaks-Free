#import "PHXEnableCell.h"

static NSString *URL =  @"https://payments.titand3v.com/api/deviceCheck.php?udid=";
static NSString *TweakName = @"Phoenix";
static NSString *UDID = nil;


@implementation PHXEnableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	specifier.properties[@"height"] = [NSNumber numberWithInt:100];

	if (self) {

		self.backgroundColour = [[TDAppearance sharedInstance] backgroundColour];

		UDID = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);

		NSString *disabledColourString = specifier.properties[@"disabledColour"];
		disabledColour = colorFromHexString(disabledColourString);

		NSString *enabledColourString = specifier.properties[@"enabledColour"];
		enabledColour = colorFromHexString(enabledColourString);


		customIcon = specifier.properties[@"customIcon"] && [specifier.properties[@"customIcon"] boolValue];

		NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
		NSString *disabledIconPath = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, specifier.properties[@"disabledIconPath"]];
		NSString *enabledIconPath = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, specifier.properties[@"enabledIconPath"]];


		self.stackView = [[UIStackView alloc] init];
		self.stackView.axis = UILayoutConstraintAxisHorizontal;
		self.stackView.alignment = UIStackViewAlignmentCenter;
		self.stackView.distribution = UIStackViewDistributionFillEqually;
		self.stackView.spacing = 10;
		[self addSubview:self.stackView];


		self.disabledView = [[UIView alloc] init];
		self.disabledView.layer.cornerRadius = 10;
		if (@available(iOS 13.0, *)) {
			self.disabledView.layer.cornerCurve = kCACornerCurveContinuous;
		}
		self.disabledView.clipsToBounds = true;
		self.disabledView.backgroundColor = self.backgroundColour;
		self.disabledView.layer.shadowOpacity = 0.5;
		self.disabledView.layer.shadowOffset = CGSizeMake(0.0,0.0);
		self.disabledView.layer.shadowRadius = 3.0;
		self.disabledView.layer.masksToBounds = false;

		[self.disabledView.heightAnchor constraintEqualToConstant:80].active = true;


		self.disabledImage = [[UIImageView alloc] init];
		if (customIcon) {
			self.disabledImage.image = [[UIImage imageWithContentsOfFile:disabledIconPath]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		} else {
			self.disabledImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/disabled.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		}
		self.disabledImage.tintColor = disabledColour;
		[self.disabledView addSubview:self.disabledImage];

		self.disabledImage.translatesAutoresizingMaskIntoConstraints = false;
		[self.disabledImage.heightAnchor constraintEqualToConstant:30].active = true;
		[self.disabledImage.widthAnchor constraintEqualToConstant:30].active = true;
		[self.disabledImage.topAnchor constraintEqualToAnchor:self.disabledView.topAnchor constant:10].active = true;
		[self.disabledImage.centerXAnchor constraintEqualToAnchor:self.disabledView.centerXAnchor].active = true;


		self.disabledLabel = [[UILabel alloc] init];
		self.disabledLabel.textAlignment = NSTextAlignmentCenter;
		self.disabledLabel.font = [UIFont boldSystemFontOfSize:12];
		self.disabledLabel.text = specifier.properties[@"disabledTitle"];
		self.disabledLabel.textColor = disabledColour;
		[self.disabledView addSubview:self.disabledLabel];

		self.disabledLabel.translatesAutoresizingMaskIntoConstraints = false;
		[self.disabledLabel.topAnchor constraintEqualToAnchor:self.disabledImage.bottomAnchor constant:5].active = true;
		[self.disabledLabel.centerXAnchor constraintEqualToAnchor:self.disabledView.centerXAnchor].active = true;


		self.disabledStateView = [[UIView alloc] init];
		self.disabledStateView.backgroundColor = disabledColour;
		self.disabledStateView.layer.cornerRadius = 3;
		[self.disabledView addSubview:self.disabledStateView];

		self.disabledStateView.translatesAutoresizingMaskIntoConstraints = false;
		[self.disabledStateView.heightAnchor constraintEqualToConstant:6].active = true;
		[self.disabledStateView.widthAnchor constraintEqualToConstant:50].active = true;
		[self.disabledStateView.bottomAnchor constraintEqualToAnchor:self.disabledView.bottomAnchor constant:-5].active = true;
		[self.disabledStateView.centerXAnchor constraintEqualToAnchor:self.disabledView.centerXAnchor].active = true;


		self.enabledView = [[UIView alloc] init];
		self.enabledView.layer.cornerRadius = 10;
		if (@available(iOS 13.0, *)) {
			self.enabledView.layer.cornerCurve = kCACornerCurveContinuous;
		}
		self.enabledView.clipsToBounds = true;
		self.enabledView.backgroundColor = self.backgroundColour;
		self.enabledView.layer.shadowOpacity = 0.5;
		self.enabledView.layer.shadowOffset = CGSizeMake(0.0,0.0);
		self.enabledView.layer.shadowRadius = 3.0;
		self.enabledView.layer.masksToBounds = false;

		[self.enabledView.heightAnchor constraintEqualToConstant:80].active = true;


		self.enabledImage = [[UIImageView alloc] init];
		if (customIcon) {
			self.enabledImage.image = [[UIImage imageWithContentsOfFile:enabledIconPath]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		} else {
			self.enabledImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/enabled.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		}
		self.enabledImage.tintColor = enabledColour;
		[self.enabledView addSubview:self.enabledImage];

		self.enabledImage.translatesAutoresizingMaskIntoConstraints = false;
		[self.enabledImage.heightAnchor constraintEqualToConstant:30].active = true;
		[self.enabledImage.widthAnchor constraintEqualToConstant:30].active = true;
		[self.enabledImage.topAnchor constraintEqualToAnchor:self.enabledView.topAnchor constant:10].active = true;
		[self.enabledImage.centerXAnchor constraintEqualToAnchor:self.enabledView.centerXAnchor].active = true;


		self.enabledLabel = [[UILabel alloc] init];
		self.enabledLabel.textAlignment = NSTextAlignmentCenter;
		self.enabledLabel.font = [UIFont boldSystemFontOfSize:12];
		self.enabledLabel.text = specifier.properties[@"enabledTitle"];
		self.enabledLabel.textColor = enabledColour;
		[self.enabledView addSubview:self.enabledLabel];

		self.enabledLabel.translatesAutoresizingMaskIntoConstraints = false;
		[self.enabledLabel.topAnchor constraintEqualToAnchor:self.enabledImage.bottomAnchor constant:5].active = true;
		[self.enabledLabel.centerXAnchor constraintEqualToAnchor:self.enabledView.centerXAnchor].active = true;


		self.enabledStateView = [[UIView alloc] init];
		self.enabledStateView.backgroundColor = enabledColour;
		self.enabledStateView.layer.cornerRadius = 3;
		[self.enabledView addSubview:self.enabledStateView];

		self.enabledStateView.translatesAutoresizingMaskIntoConstraints = false;
		[self.enabledStateView.heightAnchor constraintEqualToConstant:6].active = true;
		[self.enabledStateView.widthAnchor constraintEqualToConstant:50].active = true;
		[self.enabledStateView.bottomAnchor constraintEqualToAnchor:self.enabledView.bottomAnchor constant:-5].active = true;
		[self.enabledStateView.centerXAnchor constraintEqualToAnchor:self.enabledView.centerXAnchor].active = true;


		[self.stackView addArrangedSubview:self.disabledView];
		[self.stackView addArrangedSubview:self.enabledView];

		self.stackView.translatesAutoresizingMaskIntoConstraints = false;
		[self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = true;
		[self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = true;
		[self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = true;
		[self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = true;
		[self.stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = true;
		[self.stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = true;


		[self.disabledView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(disableAction)]];
		[self.enabledView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(enableAction)]];

	}

	return self;
}


-(void)updatingValue {

	NSString *prefsPlistPath = @"/var/mobile/Library/Preferences/com.TitanD3v.PhoenixPrefs.plist";
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPlistPath]];

	isEnabled = [[settings objectForKey:@"togglePhoenix"] boolValue];

	if (isEnabled) {

		self.disabledView.layer.shadowColor = UIColor.clearColor.CGColor;
		self.enabledView.layer.shadowColor = enabledColour.CGColor;

		self.disabledImage.alpha = 0.4;
		self.disabledLabel.alpha = 0.4;
		self.disabledStateView.alpha = 0.4;
		self.enabledImage.alpha = 1.0;
		self.enabledLabel.alpha = 1.0;
		self.enabledStateView.alpha = 1.0;

	} else {

		self.disabledView.layer.shadowColor = disabledColour.CGColor;
		self.enabledView.layer.shadowColor = UIColor.clearColor.CGColor;

		self.disabledImage.alpha = 1.0;
		self.disabledLabel.alpha = 1.0;
		self.disabledStateView.alpha = 1.0;
		self.enabledImage.alpha = 0.4;
		self.enabledLabel.alpha = 0.4;
		self.enabledStateView.alpha = 0.4;

	}

}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	[self updatingValue];
}


-(void)disableAction {

	invokeHapticFeedback();

	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	[settings setObject:[NSNumber numberWithBool:NO] forKey:self.specifier.properties[@"key"]];
	[settings writeToFile:prefsPath atomically:YES];

	[self updatingValue];

}


-(void)enableAction {

	invokeHapticFeedback();

	NSString *isT = readPlist(@"isT");
	NSString *isU = readPlist(@"isU");
	NSString *mT = readPlist(@"mT");
	NSString *uT = readPlist(@"uT");
	NSString *udd = readPlist(@"udd");

	NSString *UDID = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
	if (([isT isEqual:@"YES"] || [isU isEqual:@"YES"]) && (![mT isEqual:@"Trial not found"] || ![uT isEqual:@"License not found"]) && [udd isEqual:UDID]) {
		writeToPrefsPlist(@"togglePhoenix", @"YES");
		NSLog(@"AJSGAJSASAS enableAction enabeing tweak");
	}
	else{
		NSLog(@"AJSGAJSASAS enableAction enabeing tweak");
		writeToPrefsPlist(@"togglePhoenix", @"NO");
		[self showAlert];
	}

	[self updatingValue];

}


-(void)showAlert {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Sorry you can’t enable Phoenix because you haven’t purchased it.\n\nIf you already bought Phoenix then please connect to internet to use it" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

	}];
	[alertController addAction:okAction];
	alertController.view.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
	UIViewController *prefsController = [self _viewControllerForAncestor];
	[prefsController presentViewController:alertController animated:YES completion:nil];

}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
