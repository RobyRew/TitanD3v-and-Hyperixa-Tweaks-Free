#import "TDHeaderCell.h"

@implementation TDHeaderCell

- (id)initWithSpecifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
  if (self) {

    self.headerLabel = [[UILabel alloc] initWithFrame:[self frame]];
    [self.headerLabel setNumberOfLines:0];
    [self.headerLabel setText:specifier.properties[@"title"]];
    [self.headerLabel setBackgroundColor:[UIColor clearColor]];
    self.headerLabel.textAlignment = NSTextAlignmentLeft;
    [self.headerLabel setFont:[UIFont boldSystemFontOfSize:22]];
    [self addSubview:self.headerLabel];

  }
  return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
  return 40.f;
}

- (void)setFrame:(CGRect)frame {
  if (![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/shuffle.dylib"]) {
    inset = 10;
    frame.origin.x += inset;
    frame.size.width -= 2 * inset;
    [super setFrame:frame];
  } else {
    inset = 0;
    frame.origin.x += inset;
    frame.size.width -= 2 * inset;
    [super setFrame:frame];
  }

  BOOL cellInset = [[TDPrefsManager sharedInstance] externalCellInset];

  if (cellInset) {
    inset = 10;
    frame.origin.x += inset;
    frame.size.width -= 2 * inset;
    [super setFrame:frame];
  }
}

@end
