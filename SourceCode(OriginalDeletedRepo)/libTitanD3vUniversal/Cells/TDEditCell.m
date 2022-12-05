#import "TDEditCell.h"

@implementation TDEditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	specifier.properties[@"height"] = [NSNumber numberWithInt:70];

	if (self) {

		self.tintColour = [[TDAppearance sharedInstance] tintColour];
		self.labelColour = [[TDAppearance sharedInstance] labelColour];


		baseView = [[UIView alloc] initWithFrame:self.bounds];
		baseView.backgroundColor = [[TDAppearance sharedInstance] cellColour];
		[self addSubview:baseView];


		customIcon = specifier.properties[@"customIcon"] && [specifier.properties[@"customIcon"] boolValue];

		NSString *customIconPath = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", specifier.properties[@"iconName"]];

		self.iconImage = [[UIImageView alloc]init];
		if (customIcon) {
			self.iconImage.image = [[UIImage imageWithContentsOfFile:customIconPath]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		} else {
			self.iconImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/edit.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		}
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


		NSString *bundleID = specifier.properties[@"defaults"];
		NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
		NSMutableDictionary *settings = [NSMutableDictionary dictionary];
		[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

		self.textField = [[UITextField alloc] init];
		self.textField.font = [UIFont systemFontOfSize:15];
		self.textField.placeholder = specifier.properties[@"placeholderText"];
		self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
		self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
		self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		self.textField.delegate = self;
		self.textField.backgroundColor = UIColor.clearColor;
		self.textField.textColor = self.labelColour;
		self.textField.text = [settings objectForKey:specifier.properties[@"objectKey"]] ?: specifier.properties[@"default"];
		[self addSubview:self.textField];

		self.textField.translatesAutoresizingMaskIntoConstraints = NO;
		[self.textField.leadingAnchor constraintEqualToAnchor:self.headerLabel.trailingAnchor constant:10].active = YES;
		[self.textField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
		[self.textField.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
		[self.textField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;


		if ([specifier.properties[@"keyboardType"] isEqualToString:@"keyboard"]) {
			self.textField.keyboardType = UIKeyboardTypeDefault;
		} else if ([specifier.properties[@"keyboardType"] isEqualToString:@"numberpad"]) {
			self.textField.keyboardType = UIKeyboardTypeNumberPad;
		}


	}

	return self;
}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	UIView *blankView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
	[blankView setClipsToBounds:YES];
	[self setAccessoryView:blankView];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {

	NSString *textString = self.textField.text;

	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	[settings setObject:textString forKey:self.specifier.properties[@"objectKey"]];
	[settings writeToFile:prefsPath atomically:YES];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

	UIToolbar *textToolbar = [[UIToolbar alloc] init];
	[textToolbar sizeToFit];
	textToolbar.barStyle = UIBarStyleDefault;
	textToolbar.tintColor = self.tintColour;
	textToolbar.items = [self textToolBarButtons];
	self.textField.inputAccessoryView = textToolbar;

	return YES;

}


-(NSArray *)textToolBarButtons {

	NSMutableArray *textButtons = [[NSMutableArray alloc] init];

	[textButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];

	[textButtons addObject:[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)]];

	return [textButtons copy];

}


-(void)dismissKeyboard {

	[[TDUtilities sharedInstance] haptic:0];

	NSString *textString = self.textField.text;

	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	[settings setObject:textString forKey:self.specifier.properties[@"objectKey"]];
	[settings writeToFile:prefsPath atomically:YES];

	[self.textField resignFirstResponder];
}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}


- (void)layoutSubviews {
	[super layoutSubviews];

	baseView.frame = self.bounds;

}


@end
