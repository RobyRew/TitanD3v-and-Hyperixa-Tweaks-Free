#import "TDFontPickerCell.h"

@implementation TDFontPickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	specifier.properties[@"height"] = [NSNumber numberWithInt:70];

	if (self) {

		self.tintColour = [[TDAppearance sharedInstance] tintColour];

		NSString *customIconPath = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", specifier.properties[@"iconName"]];

		self.iconImage = [[UIImageView alloc]init];
		self.iconImage.image = [[UIImage imageWithContentsOfFile:customIconPath]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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


		self.fontLabel = [[UILabel alloc]init];
		self.fontLabel.text = @"Font";
		[self addSubview:self.fontLabel];

		self.fontLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.fontLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.fontLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;

	}

	return self;
}


- (id)target {
	return self;
}


- (id)cellTarget {
	return self;
}


- (SEL)action {
	return @selector(openFontPicker);
}


- (SEL)cellAction {
	return @selector(openFontPicker);
}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	[self.specifier setTarget:self];
	[self.specifier setButtonAction:@selector(openFontPicker)];


	UIView *blankView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
	[blankView setClipsToBounds:YES];
	[self setAccessoryView:blankView];


	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];
	NSString *keyString = self.specifier.properties[@"key"];

	NSData *data = [settings objectForKey:keyString];
	NSError *error = nil;
	UIFontDescriptor *descriptor = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIFontDescriptor class] fromData:data error:&error];

	self.fontLabel.font = [UIFont fontWithDescriptor:descriptor size:12];

}


-(void)openFontPicker {

	if (@available(iOS 13.0, *)) {
		UIFontPickerViewControllerConfiguration *config = [[UIFontPickerViewControllerConfiguration alloc] init];
		config.includeFaces = YES;
		config.displayUsingSystemFont  = YES;

		UIFontPickerViewController *fontPicker = [[UIFontPickerViewController alloc] initWithConfiguration:config];
		fontPicker.delegate = self;
		UIViewController *prefsController = [self _viewControllerForAncestor];
		[prefsController presentViewController:fontPicker animated:YES completion:nil];
	}

}


-(void)fontPickerViewControllerDidPickFont:(UIFontPickerViewController *)fontPicker API_AVAILABLE(ios(13.0)) {

	if (@available(iOS 13.0, *)) {
		UIFontDescriptor *descriptor = fontPicker.selectedFontDescriptor;
		NSError *error = nil;
		NSData *encodedDescriptor = [NSKeyedArchiver archivedDataWithRootObject:descriptor requiringSecureCoding:NO error:&error];

		NSString *bundleID = self.specifier.properties[@"defaults"];
		NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
		NSMutableDictionary *settings = [NSMutableDictionary dictionary];
		[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

		[settings setObject:encodedDescriptor forKey:self.specifier.properties[@"key"]];
		[settings writeToFile:prefsPath atomically:YES];


		NSString *keyString = self.specifier.properties[@"key"];

		NSData *data = [settings objectForKey:keyString];
		UIFontDescriptor *descriptorFont = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIFontDescriptor class] fromData:data error:&error];

		self.fontLabel.font = [UIFont fontWithDescriptor:descriptorFont size:12];

		[fontPicker dismissViewControllerAnimated:YES completion:nil];
	}

}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
