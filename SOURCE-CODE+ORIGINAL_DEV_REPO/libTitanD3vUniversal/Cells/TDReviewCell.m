#import "TDReviewCell.h"

@implementation TDReviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	specifier.properties[@"height"] = [NSNumber numberWithInt:70];

	if (self) {

		self.tintColour = [[TDAppearance sharedInstance] tintColour];


		self.iconImage = [[UIImageView alloc]init];
		self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/review.png"];
		self.iconImage.layer.cornerRadius = 20;
		self.iconImage.clipsToBounds = true;
		[self addSubview:self.iconImage];

		self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
		[self.iconImage.widthAnchor constraintEqualToConstant:40.0].active = YES;
		[self.iconImage.heightAnchor constraintEqualToConstant:40.0].active = YES;
		[[self.iconImage centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.iconImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:13].active = YES;


		self.headerLabel = [[UILabel alloc] init];
		self.headerLabel.text = @"Write a Review";
		[self.headerLabel setFont:[self.headerLabel.font fontWithSize:17]];
		[self addSubview:self.headerLabel];

		self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[[self.headerLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.headerLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:12].active = YES;


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
	return @selector(openReviewVC);
}


- (SEL)cellAction {
	return @selector(openReviewVC);
}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	[self.specifier setTarget:self];
	[self.specifier setButtonAction:@selector(openReviewVC)];


	UIView *blankView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
	[blankView setClipsToBounds:YES];
	[self setAccessoryView:blankView];

}


-(void)openReviewVC {

	UIViewController *prefsController = [self _viewControllerForAncestor];
	vc = [[TDReviewViewController alloc] init];
	vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
	vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	vc.rateTitle = @"How was your experience?";
	vc.confirmTitle = @"Review";
	vc.rateTitleColor = UIColor.whiteColor;
	[vc onConfirmHandler:^(TDRate rate) {
		switch (rate) {
			case TDRateBad:
			ratingString = @"BAD";
			break;
			case TDRateUgh:
			ratingString = @"UGH";
			break;
			case TDRateOk:
			ratingString = @"OK";
			break;
			case TDRateGood:
			ratingString = @"GOOD";
			break;
		}
		[self composeReview];
		[[TDUtilities sharedInstance] haptic:0];
	}];

	[vc onCancelHandler:^{
		[prefsController dismissViewControllerAnimated:YES completion:nil];
		[[TDUtilities sharedInstance] haptic:0];
	}];

	[prefsController presentViewController:vc animated:YES completion:nil];

}


-(void)composeReview {

	reviewVC = [[UIViewController alloc] init];

	UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, reviewVC.view.frame.size.width, 50)];
	navbar.barTintColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
	navbar.tintColor = self.tintColor;
	[navbar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6], NSForegroundColorAttributeName, nil]];

	UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"Write a Review"];

	UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelReview:)];
	navItem.leftBarButtonItem = cancelBtn;

	UIBarButtonItem* submitBtn = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitReview:)];
	navItem.rightBarButtonItem = submitBtn;

	[navbar setItems:@[navItem]];
	[reviewVC.view addSubview:navbar];

	if (@available(iOS 13.0, *)) {
		reviewVC.modalInPresentation = true;
	}

	[vc presentViewController:reviewVC animated:YES completion:nil];


	reviewVC.view.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];


	self.reviewTextField = [[UITextField alloc] init];
	self.reviewTextField.font = [UIFont systemFontOfSize:15];
	self.reviewTextField.placeholder = @"Your Name";
	self.reviewTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	self.reviewTextField.keyboardType = UIKeyboardTypeDefault;
	self.reviewTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.reviewTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	self.reviewTextField.delegate = self;
	self.reviewTextField.textColor = UIColor.whiteColor;
	self.reviewTextField.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
	self.reviewTextField.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
	self.reviewTextField.layer.cornerRadius = 10;
	self.reviewTextField.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
	self.reviewTextField.layer.borderWidth = 0.5;
	[reviewVC.view addSubview:self.reviewTextField];

	[self.reviewTextField top:navbar.bottomAnchor padding:15];
	[self.reviewTextField leading:reviewVC.view.leadingAnchor padding:10];
	[self.reviewTextField trailing:reviewVC.view.trailingAnchor padding:-10];
	[self.reviewTextField height:44];

	[self.reviewTextField becomeFirstResponder];


	UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
	self.reviewTextField.leftView = paddingView;
	self.reviewTextField.leftViewMode = UITextFieldViewModeAlways;


	self.reviewTextView = [[UITextView alloc] init];
	self.reviewTextView.editable = YES;
	self.reviewTextView.userInteractionEnabled = YES;
	self.reviewTextView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
	self.reviewTextView.scrollEnabled = YES;
	self.reviewTextView.delegate = self;
	self.reviewTextView.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
	self.reviewTextView.font = [UIFont systemFontOfSize:17];
	self.reviewTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
	self.reviewTextView.textColor = UIColor.whiteColor;
	self.reviewTextView.layer.cornerRadius = 10;
	self.reviewTextView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
	self.reviewTextView.layer.borderWidth = 0.5;
	[reviewVC.view addSubview:self.reviewTextView];

	[self.reviewTextView top:self.reviewTextField.bottomAnchor padding:10];
	[self.reviewTextView leading:reviewVC.view.leadingAnchor padding:10];
	[self.reviewTextView trailing:reviewVC.view.trailingAnchor padding:-10];
	[self.reviewTextView height:230];


	self.placeholderLabel = [[UILabel alloc] init];
	self.placeholderLabel.text = @"Description";
	self.placeholderLabel.alpha = 1;
	self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
	self.placeholderLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha:0.4];
	[self.reviewTextView addSubview:self.placeholderLabel];

	[self.placeholderLabel top:self.reviewTextView.bottomAnchor padding:10];
	[self.placeholderLabel leading:self.reviewTextView.leadingAnchor padding:14];

	if (@available(iOS 13.0, *)) {
		self.reviewTextField.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
		self.reviewTextView.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
	}

}


-(void)sendReview:(NSString*)subject msg:(NSString*)msg tweak:(NSString*)tweak name:(NSString*)name {
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	NSString *url = @"https://payments.titand3v.com/review-mail.php?send=YES";
	NSString *finalsubject = [subject stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
	NSString *finalmsg = [msg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
	NSString *finaltweak = [tweak stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
	NSString *finalname = [name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
	NSString *finalURL = [NSString stringWithFormat:@"%@&subject=%@&msg=%@&tweak=%@&name=%@", url, finalsubject, finalmsg, finaltweak, finalname];
	[request setURL:[NSURL URLWithString:finalURL]];
	[request setHTTPMethod:@"GET"];

	NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	[[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
	}] resume];
}


-(void)submitReview:(UIBarButtonItem*)item{

	[[TDUtilities sharedInstance] haptic:0];

	if (self.reviewTextView.text && self.reviewTextView.text.length && self.reviewTextField.text && self.reviewTextField.text.length > 0) {

		NSString *rating = [NSString stringWithFormat:@"%@", ratingString];
		NSString *messageString = self.reviewTextView.text;
		NSString *tweakString = self.specifier.properties[@"tweakName"];
		NSString *nameString = self.reviewTextField.text;

		[self sendReview:rating msg:messageString tweak:tweakString name:nameString];

		[reviewVC dismissViewControllerAnimated:YES completion:nil];
		[vc dismissViewControllerAnimated:YES completion:nil];
		[self performSelector:@selector(showFeedbackAlert) withObject:nil afterDelay:1.0];

	} else {
		[self showEmptyFieldAlert];

	}

}


-(void)showEmptyFieldAlert {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"The review or name is blank and you will need to add your name or nickname, write a review before you can submit your review" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

	}];
	[alertController addAction:okAction];
	alertController.view.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
	[reviewVC presentViewController:alertController animated:YES completion:nil];
}


-(void)showFeedbackAlert {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Thank you for your feedback 😀" message:@"" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

	}];
	[alertController addAction:okAction];
	alertController.view.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
	UIViewController *prefsController = [self _viewControllerForAncestor];
	[prefsController presentViewController:alertController animated:YES completion:nil];

}


- (void)textViewDidBeginEditing:(UITextView *)textView {

	if ([textView.text isEqualToString:@""]) {
		self.placeholderLabel.alpha = 1;
	} else {
		self.placeholderLabel.alpha = 0;
	}
}


- (void)textViewDidChange:(UITextView *)textView{

	if ([textView.text isEqualToString:@""]) {
		self.placeholderLabel.alpha = 1;
	} else {
		self.placeholderLabel.alpha = 0;
	}
}


- (void)textViewDidEndEditing:(UITextView *)textView {

	if ([textView.text isEqualToString:@""]) {
		self.placeholderLabel.alpha = 1;
	} else {
		self.placeholderLabel.alpha = 0;
	}
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

	UIToolbar *textToolbar = [[UIToolbar alloc] init];
	[textToolbar sizeToFit];
	if (@available(iOS 13.0, *)) {
		textToolbar.barStyle = UIStatusBarStyleDarkContent;
	}
	textToolbar.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
	textToolbar.items = [self textToolBarButtons];
	self.reviewTextView.inputAccessoryView = textToolbar;

	if (@available(iOS 13.0, *)) {
		self.reviewTextView.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
	}

	return YES;

}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

	UIToolbar *textToolbar = [[UIToolbar alloc] init];
	[textToolbar sizeToFit];
	if (@available(iOS 13.0, *)) {
		textToolbar.barStyle = UIStatusBarStyleDarkContent;
	}
	textToolbar.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
	textToolbar.items = [self textToolBarButtons];
	self.reviewTextField.inputAccessoryView = textToolbar;

	if (@available(iOS 13.0, *)) {
		self.reviewTextField.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
	}

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
	[self.reviewTextField resignFirstResponder];
	[self.reviewTextView resignFirstResponder];
}


-(void)cancelReview:(UIBarButtonItem*)item {
	[[TDUtilities sharedInstance] haptic:0];
	[reviewVC dismissViewControllerAnimated:YES completion:nil];
	[vc dismissViewControllerAnimated:YES completion:nil];
}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
