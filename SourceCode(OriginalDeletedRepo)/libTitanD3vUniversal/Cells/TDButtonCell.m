#import "TDButtonCell.h"

@implementation TDButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		specifier.properties[@"height"] = [NSNumber numberWithInt:70];

		self.tintColour = [[TDAppearance sharedInstance] tintColour];

		customIconPath = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", specifier.properties[@"iconName"]];


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
