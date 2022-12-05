#import "TDTermsAndConditionsCell.h"

@implementation TDTermsAndConditionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	specifier.properties[@"height"] = [NSNumber numberWithInt:70];

	if (self) {

		self.tintColour = [[TDAppearance sharedInstance] tintColour];


		self.iconImage = [[UIImageView alloc]init];
		self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Terms&Conditions/terms-and-conditions.png"];
		self.iconImage.layer.cornerRadius = 20;
		self.iconImage.clipsToBounds = true;
		[self addSubview:self.iconImage];

		self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
		[self.iconImage.widthAnchor constraintEqualToConstant:40.0].active = YES;
		[self.iconImage.heightAnchor constraintEqualToConstant:40.0].active = YES;
		[[self.iconImage centerYAnchor] constraintEqualToAnchor:self.centerYAnchor].active = true;
		[self.iconImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:13].active = YES;


		self.headerLabel = [[UILabel alloc] init];
		self.headerLabel.text = @"Terms & Conditions";
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
	return @selector(openTermsConditionsVC);
}


- (SEL)cellAction {
	return @selector(openTermsConditionsVC);
}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	[self.specifier setTarget:self];
	[self.specifier setButtonAction:@selector(openTermsConditionsVC)];


	UIView *blankView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 30, 30)];
	[blankView setClipsToBounds:YES];
	[self setAccessoryView:blankView];

}


-(void)openTermsConditionsVC {
    TDTermsAndConditionsVC *tvc = [[TDTermsAndConditionsVC alloc] init];
    UIViewController *prefsController = [self _viewControllerForAncestor];
	[prefsController presentViewController:tvc animated:YES completion:nil];
}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
