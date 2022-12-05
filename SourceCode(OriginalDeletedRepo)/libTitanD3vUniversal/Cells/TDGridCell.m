#import "TDGridCell.h"
#import "TDPrimraryController.h"
#import "TDSecondaryController.h"
#import "TDExternalController.h"

@implementation GridButton
@end


@implementation TDGridCell

- (id)initWithSpecifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
	specifier.properties[@"height"] = [NSNumber numberWithInt:150];
	return self;
}


- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	self.tintColour = [[TDAppearance sharedInstance] tintColour];

	leftIconPathString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", self.specifier.properties[@"leftIconName"]];
	middleIconPathString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", self.specifier.properties[@"middleIconName"]];
	rightIconPathString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", self.specifier.properties[@"rightIconName"]];

	leftIconImage = [[UIImage imageNamed:leftIconPathString]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	middleIconImage = [[UIImage imageNamed:middleIconPathString]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	rightIconImage = [[UIImage imageNamed:rightIconPathString]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];


	UIStackView *stack = [[UIStackView alloc] initWithFrame:self.bounds];
	stack.axis = UILayoutConstraintAxisHorizontal;
	stack.alignment = UIStackViewAlignmentCenter;
	stack.distribution = UIStackViewDistributionEqualSpacing;
	stack.spacing = 20;
	stack.translatesAutoresizingMaskIntoConstraints = false;


	UIStackView *leftStack = [[UIStackView alloc] initWithFrame:CGRectMake(20, 20, 80, 120)];
	leftStack.axis = UILayoutConstraintAxisVertical;
	leftStack.alignment = UIStackViewAlignmentCenter;
	leftStack.distribution = UIStackViewDistributionEqualSpacing;
	leftStack.spacing = 15;
	leftStack.translatesAutoresizingMaskIntoConstraints = false;


	GridButton *leftButton = [[GridButton alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
	leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
	leftButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	[leftButton setImage:leftIconImage forState:UIControlStateNormal];
	leftButton.tag = 1;
	leftButton.clipsToBounds = YES;
	[leftButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
	leftButton.imageView.clipsToBounds = true;
	leftButton.imageView.layer.cornerRadius = 10;
	if (@available(iOS 13.0, *)) {
		leftButton.imageView.layer.cornerCurve = kCACornerCurveContinuous;
	}
	leftButton.layer.masksToBounds = NO;
	leftButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
	leftButton.identifier = self.specifier.properties[@"leftClass"];
	if ([self.specifier.properties[@"classID"] isEqualToString:@"primrary"]) {
		[leftButton addTarget:[[TDPrimraryController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	} else if ([self.specifier.properties[@"classID"] isEqualToString:@"secondary"]) {
		[leftButton addTarget:[[TDSecondaryController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	} else if ([self.specifier.properties[@"classID"] isEqualToString:@"external"]) {
		[leftButton addTarget:[[TDExternalController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	}
	[leftStack addArrangedSubview:leftButton];
	[leftButton.widthAnchor constraintEqualToConstant:80].active = true;
	[leftButton.heightAnchor constraintEqualToConstant:80].active = true;


	UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
	leftLabel.text = self.specifier.properties[@"leftTitle"];
	leftLabel.font = [UIFont boldSystemFontOfSize:12];
	leftLabel.textAlignment = NSTextAlignmentCenter;
	[leftStack addArrangedSubview:leftLabel];
	[stack addArrangedSubview:leftStack];


	UIStackView *middleStack = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 80, 120)];
	middleStack.axis = UILayoutConstraintAxisVertical;
	middleStack.alignment = UIStackViewAlignmentCenter;
	middleStack.distribution = UIStackViewDistributionEqualSpacing;
	middleStack.spacing = 15;
	middleStack.translatesAutoresizingMaskIntoConstraints = YES;


	GridButton *middleButton = [[GridButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
	middleButton.center = CGPointMake(CGRectGetMidX(self.bounds), middleButton.center.y);
	middleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
	middleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	[middleButton setImage:middleIconImage forState:UIControlStateNormal];
	middleButton.imageView.clipsToBounds = true;
	middleButton.imageView.layer.cornerRadius = 10;
	if (@available(iOS 13.0, *)) {
		middleButton.imageView.layer.cornerCurve = kCACornerCurveContinuous;
	}
	middleButton.tag = 3;
	middleButton.clipsToBounds = YES;
	[middleButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
	middleButton.layer.masksToBounds = NO;
	middleButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
	middleButton.identifier = self.specifier.properties[@"middleClass"];
	if ([self.specifier.properties[@"classID"] isEqualToString:@"primrary"]) {
		[middleButton addTarget:[[TDPrimraryController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	} else if ([self.specifier.properties[@"classID"] isEqualToString:@"secondary"]) {
		[middleButton addTarget:[[TDSecondaryController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	} else if ([self.specifier.properties[@"classID"] isEqualToString:@"external"]) {
		[middleButton addTarget:[[TDExternalController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	}
	[middleStack addArrangedSubview:middleButton];
	[middleButton.widthAnchor constraintEqualToConstant:80].active = true;
	[middleButton.heightAnchor constraintEqualToConstant:80].active = true;


	UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
	middleLabel.text = self.specifier.properties[@"middleTitle"];
	middleLabel.font = [UIFont boldSystemFontOfSize:12];
	middleLabel.textAlignment = NSTextAlignmentCenter;
	[middleStack addArrangedSubview:middleLabel];
	[stack addArrangedSubview:middleStack];


	UIStackView *rightStack = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 80, 120)];
	rightStack.axis = UILayoutConstraintAxisVertical;
	rightStack.alignment = UIStackViewAlignmentCenter;
	rightStack.distribution = UIStackViewDistributionEqualSpacing;
	rightStack.spacing = 15;
	rightStack.translatesAutoresizingMaskIntoConstraints = false;


	GridButton *rightButton = [[GridButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
	rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
	rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	[rightButton setImage:rightIconImage forState:UIControlStateNormal];
	rightButton.imageView.clipsToBounds = true;
	rightButton.imageView.layer.cornerRadius = 10;
	if (@available(iOS 13.0, *)) {
		rightButton.imageView.layer.cornerCurve = kCACornerCurveContinuous;
	}
	rightButton.tag = 2;
	rightButton.clipsToBounds = YES;
	[rightButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
	rightButton.layer.masksToBounds = NO;
	rightButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
	rightButton.identifier = self.specifier.properties[@"rightClass"];
	if ([self.specifier.properties[@"classID"] isEqualToString:@"primrary"]) {
		[rightButton addTarget:[[TDPrimraryController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	} else if ([self.specifier.properties[@"classID"] isEqualToString:@"secondary"]) {
		[rightButton addTarget:[[TDSecondaryController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	} else if ([self.specifier.properties[@"classID"] isEqualToString:@"external"]) {
		[rightButton addTarget:[[TDExternalController alloc] init] action:@selector(openController:) forControlEvents:UIControlEventTouchUpInside];
	}
	[rightStack addArrangedSubview:rightButton];
	[rightButton.widthAnchor constraintEqualToConstant:80].active = true;
	[rightButton.heightAnchor constraintEqualToConstant:80].active = true;
	[stack addArrangedSubview:rightStack];


	UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
	rightLabel.text = self.specifier.properties[@"rightTitle"];
	rightLabel.font = [UIFont boldSystemFontOfSize:12];
	rightLabel.textAlignment = NSTextAlignmentCenter;
	[rightStack addArrangedSubview:rightLabel];
	[stack addArrangedSubview:rightStack];


	[self addSubview:stack];
	[stack.topAnchor constraintEqualToAnchor:self.topAnchor constant:20].active = true;
	[stack.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-40].active = true;
	[stack.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:-40].active = true;
	[stack.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-40].active = true;
	[stack.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = true;
	[stack.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = true;

}


- (CGFloat)preferredHeightForWidth:(CGFloat)width {
	return 100.0;
}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
