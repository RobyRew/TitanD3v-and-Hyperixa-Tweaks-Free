#import "TDImageCell.h"

@implementation TDImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
		NSString *imagePath = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, specifier.properties[@"imagePath"]];

		self.bannerImage = [[UIImageView alloc] initWithFrame:self.bounds];
		self.bannerImage.clipsToBounds = YES;
		self.bannerImage.contentMode = UIViewContentModeScaleAspectFill;
		self.bannerImage.image = [[UIImage imageWithContentsOfFile:imagePath]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		[self addSubview:self.bannerImage];

	}

	return self;
}


- (void)layoutSubviews {
	[super layoutSubviews];

	self.bannerImage.frame = self.bounds;

}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
