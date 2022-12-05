#import "TDTextViewCell.h"

@implementation TDTextViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		self.labelColour = [[TDAppearance sharedInstance] labelColour];
		self.tintColour = [[TDAppearance sharedInstance] tintColour];


		baseView = [[UIView alloc] initWithFrame:self.bounds];
		baseView.backgroundColor = [[TDAppearance sharedInstance] cellColour];
		[self addSubview:baseView];

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
		[self.headerLabel setFont:[UIFont boldSystemFontOfSize:14]];
		self.headerLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.headerLabel];

		self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.headerLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:10].active = YES;
		[self.headerLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;


		NSString *bundleID = specifier.properties[@"defaults"];
		NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
		NSMutableDictionary *settings = [NSMutableDictionary dictionary];
		[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];


		self.descriptionTextView = [[UITextView alloc] init];
		self.descriptionTextView.clipsToBounds = YES;
		self.descriptionTextView.contentInset = UIEdgeInsetsZero;
		self.descriptionTextView.delegate = self;
		self.descriptionTextView.editable = YES;
		self.descriptionTextView.font = [UIFont systemFontOfSize:16];
		self.descriptionTextView.backgroundColor = [UIColor clearColor];
		self.descriptionTextView.scrollEnabled = YES;
		self.descriptionTextView.textAlignment = NSTextAlignmentLeft;
		self.descriptionTextView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0);
		self.descriptionTextView.text = [settings objectForKey:specifier.properties[@"key"]] ?: specifier.properties[@"default"];
		self.descriptionTextView.textColor = self.labelColour;
		[self addSubview:self.descriptionTextView];

		self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.descriptionTextView.topAnchor constraintEqualToAnchor:self.headerLabel.bottomAnchor constant:10].active = YES;
		[self.descriptionTextView.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:10].active = YES;
		[self.descriptionTextView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
		[self.descriptionTextView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:10].active = YES;

	}


	return self;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

	UIToolbar *textToolbar = [[UIToolbar alloc] init];
	[textToolbar sizeToFit];
	textToolbar.barStyle = UIBarStyleDefault;
	textToolbar.tintColor = self.tintColour;
	textToolbar.items = [self textToolBarButtons];
	self.descriptionTextView.inputAccessoryView = textToolbar;

	return YES;

}


-(NSArray *)textToolBarButtons {

	NSMutableArray *textButtons = [[NSMutableArray alloc] init];

	[textButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];

	[textButtons addObject:[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)]];

	return [textButtons copy];

}


-(void)textViewDidChange:(UITextView *)textView {

	NSString *textString = self.descriptionTextView.text;

	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	[settings setObject:textString forKey:self.specifier.properties[@"key"]];
	[settings writeToFile:prefsPath atomically:YES];
}


- (void)textViewDidEndEditing:(UITextView *) textView {

	NSString *textString = self.descriptionTextView.text;

	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	[settings setObject:textString forKey:self.specifier.properties[@"key"]];
	[settings writeToFile:prefsPath atomically:YES];

}


-(void)dismissKeyboard {

	[[TDUtilities sharedInstance] haptic:0];

	NSString *textString = self.descriptionTextView.text;

	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	[settings setObject:textString forKey:self.specifier.properties[@"key"]];
	[settings writeToFile:prefsPath atomically:YES];

	[self.descriptionTextView resignFirstResponder];
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
