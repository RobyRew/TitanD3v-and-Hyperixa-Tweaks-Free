#import "TDDatePickerCell.h"

@implementation TDDatePickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	specifier.properties[@"height"] = [NSNumber numberWithInt:70];

	if (self) {

		self.containerColour = [[TDAppearance sharedInstance] containerColour];
		self.tintColour = [[TDAppearance sharedInstance] tintColour];
		self.labelColour = [[TDAppearance sharedInstance] labelColour];
		self.borderColour = [[TDAppearance sharedInstance] borderColour];

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


		self.dateLabel = [[UILabel alloc]init];
		self.subtitleLabel.font = [UIFont boldSystemFontOfSize:12];
		[self addSubview:self.dateLabel];

		self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.dateLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.dateLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;

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
	return @selector(openDatePicker);
}


- (SEL)cellAction {
	return @selector(openDatePicker);
}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	[self.specifier setTarget:self];
	[self.specifier setButtonAction:@selector(openDatePicker)];


	UIView *blankView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
	[blankView setClipsToBounds:YES];
	[self setAccessoryView:blankView];


	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	NSString *keyString = self.specifier.properties[@"key"];
	NSString *formatString = self.specifier.properties[@"format"];


	if ([settings objectForKey:keyString] != nil) {

		NSDate *existingDate = [settings objectForKey:keyString];
		pickedDateFormat = [[NSDateFormatter alloc] init];
		[pickedDateFormat setDateFormat:formatString];
		pickedDateString = [pickedDateFormat stringFromDate:existingDate];

		self.dateLabel.text = pickedDateString;

	} else {
		self.dateLabel.text = @"No available date";
	}

}


-(void)openDatePicker {


	datePickerVC = [[TDDatePickerVC alloc] init];
	datePickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
	UIViewController *prefsController = [self _viewControllerForAncestor];
	[prefsController presentViewController:datePickerVC animated:YES completion:nil];

	// datePickerVC.view.backgroundColor = UIColor.clearColor;


	self.baseView = [[UIView alloc] init];
	self.baseView.backgroundColor = self.containerColour;
	self.baseView.layer.cornerRadius = 20;
	if (@available(iOS 13.0, *)) {
		self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
	}
	self.baseView.layer.borderWidth = 1;
	self.baseView.layer.borderColor = self.borderColour.CGColor;
	self.baseView.clipsToBounds = true;
	[datePickerVC.view addSubview:self.baseView];

	self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.baseView.heightAnchor constraintEqualToConstant:300.0].active = YES;
	[self.baseView.leadingAnchor constraintEqualToAnchor:datePickerVC.view.leadingAnchor constant:20].active = YES;
	[self.baseView.trailingAnchor constraintEqualToAnchor:datePickerVC.view.trailingAnchor constant:-20].active = YES;
	[self.baseView.bottomAnchor constraintEqualToAnchor:datePickerVC.view.bottomAnchor constant:-20].active = YES;


	self.doneButton = [[UIButton alloc] init];
	self.doneButton.backgroundColor = self.tintColour;
	[self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
	[self.doneButton setTitleColor:self.labelColour forState:UIControlStateNormal];
	[self.doneButton addTarget:self action:@selector(dismissDatePicker) forControlEvents:UIControlEventTouchUpInside];
	self.doneButton.layer.cornerRadius = 10;
	if (@available(iOS 13.0, *)) {
		self.doneButton.layer.cornerCurve = kCACornerCurveContinuous;
	}
	[self.baseView addSubview:self.doneButton];

	self.doneButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.doneButton.widthAnchor constraintEqualToConstant:200.0].active = YES;
	[self.doneButton.heightAnchor constraintEqualToConstant:40.0].active = YES;
	[[self.doneButton centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
	[self.doneButton.bottomAnchor constraintEqualToAnchor:self.baseView.bottomAnchor constant:-10].active = YES;


	self.datePicker = [[UIDatePicker alloc] init];
	[self.datePicker setDatePickerMode:UIDatePickerModeDate];
	[self.datePicker setValue:self.labelColour forKey:@"textColor"];
	[self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
	[self.baseView addSubview:self.datePicker];


	self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
	[self.datePicker.topAnchor constraintEqualToAnchor:self.baseView.topAnchor constant:10].active = YES;
	[self.datePicker.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10].active = YES;
	[self.datePicker.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-10].active = YES;
	[self.datePicker.bottomAnchor constraintEqualToAnchor:self.doneButton.topAnchor constant:-10].active = YES;


	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	NSString *keyString = self.specifier.properties[@"key"];

	if ([settings objectForKey:keyString] != nil) {
		NSDate *existingDate = [settings objectForKey:keyString];
		[self.datePicker setDate:existingDate animated:NO];
	}


}


- (void)datePickerChanged:(UIDatePicker *)datePicker {

	pickedDate = [datePicker date];

	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	[settings setObject:pickedDate forKey:self.specifier.properties[@"key"]];
	[settings writeToFile:prefsPath atomically:YES];


	NSString *keyString = self.specifier.properties[@"key"];
	NSString *formatString = self.specifier.properties[@"format"];

	NSDate *existingDate = [settings objectForKey:keyString];
	pickedDateFormat = [[NSDateFormatter alloc] init];
	[pickedDateFormat setDateFormat:formatString];
	pickedDateString = [pickedDateFormat stringFromDate:existingDate];

	self.dateLabel.text = pickedDateString;

}


-(void)dismissDatePicker {

	[[TDUtilities sharedInstance] haptic:0];

	[UIView animateWithDuration:0.2 animations:^ {
		datePickerVC.blurEffectView.alpha = 0;
	}];

	pickedDate = [self.datePicker date];

	NSString *bundleID = self.specifier.properties[@"defaults"];
	NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

	[settings setObject:pickedDate forKey:self.specifier.properties[@"key"]];
	[settings writeToFile:prefsPath atomically:YES];


	NSString *keyString = self.specifier.properties[@"key"];
	NSString *formatString = self.specifier.properties[@"format"];

	NSDate *existingDate = [settings objectForKey:keyString];
	pickedDateFormat = [[NSDateFormatter alloc] init];
	[pickedDateFormat setDateFormat:formatString];
	pickedDateString = [pickedDateFormat stringFromDate:existingDate];

	self.dateLabel.text = pickedDateString;

	[self performSelector:@selector(dismissVC) withObject:nil afterDelay:0.1];

}


-(void)dismissVC {
	[datePickerVC dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	if (touch.view != datePickerVC.view) {
		return NO;
	}

	return YES;
}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
