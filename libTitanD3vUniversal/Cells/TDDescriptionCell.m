#import "TDDescriptionCell.h"

@implementation TDDescriptionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		self.labelColour = [[TDAppearance sharedInstance] labelColour];


		self.headerLabel = [[UILabel alloc] init];
		[self.headerLabel setText:specifier.properties[@"title"]];
		[self.headerLabel setFont:[UIFont boldSystemFontOfSize:19]];
		self.headerLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.headerLabel];

		self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.headerLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
		[self.headerLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;


		self.descriptionTextView = [[UITextView alloc] init];
		self.descriptionTextView.clipsToBounds = YES;
		self.descriptionTextView.contentInset = UIEdgeInsetsZero;
		self.descriptionTextView.delegate = self;
		self.descriptionTextView.editable = NO;
		self.descriptionTextView.font = [UIFont systemFontOfSize:16];
		self.descriptionTextView.backgroundColor = [UIColor clearColor];
		self.descriptionTextView.scrollEnabled = YES;
		self.descriptionTextView.textAlignment = NSTextAlignmentLeft;
		self.descriptionTextView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0);
		self.descriptionTextView.text = specifier.properties[@"description"];
		self.descriptionTextView.textColor = self.labelColour;
		[self addSubview:self.descriptionTextView];

		self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.descriptionTextView.topAnchor constraintEqualToAnchor:self.headerLabel.bottomAnchor constant:15].active = YES;
		[self.descriptionTextView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
		[self.descriptionTextView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
		[self.descriptionTextView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:10].active = YES;

	}


	return self;
}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
