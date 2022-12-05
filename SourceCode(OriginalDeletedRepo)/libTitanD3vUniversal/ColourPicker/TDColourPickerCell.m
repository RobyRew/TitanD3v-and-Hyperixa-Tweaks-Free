#import "TDColourPickerCell.h"
#import "HEXColour.h"

static UIView *colorPreview;

@implementation TDColourPickerCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

  if (self) {

    specifier.properties[@"height"] = [NSNumber numberWithInt:70];

    self.tintColour = [[TDAppearance sharedInstance] tintColour];
    self.borderColour = [[TDAppearance sharedInstance] borderColour];

    NSString *customIconPath = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", specifier.properties[@"iconName"]];


    self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(13,15,40,40)];
        self.iconImage.image = [[UIImage imageWithContentsOfFile:customIconPath]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.iconImage.layer.cornerRadius = 20;
    self.iconImage.clipsToBounds = true;
    [self addSubview:self.iconImage];


    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(65,17.5,200,20)];
    [self.headerLabel setText:specifier.properties[@"title"]];
    [self.headerLabel setFont:[self.headerLabel.font fontWithSize:15]];
    [self addSubview:self.headerLabel];

    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65,35,200,20)];
    [self.subtitleLabel setText:specifier.properties[@"subtitle"]];
    [self.subtitleLabel setFont:[self.subtitleLabel.font fontWithSize:10]];
    [self addSubview:self.subtitleLabel];

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
  return @selector(openColorPicker);
}


- (SEL)cellAction {
  return @selector(openColorPicker);
}


- (void)openColorPicker {

  NSString *bundleID = self.specifier.properties[@"defaults"];
  NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];
  NSString *hex = [settings objectForKey:self.specifier.properties[@"key"]] ?: self.specifier.properties[@"default"];
  UIColor *currentColor = colorFromHexString(hex);

  UIViewController *prefsController = [self _viewControllerForAncestor];
  [prefsController presentViewController:[[TDColorPickerViewController alloc] initWithColor:currentColor stackType:TDColorSpaceTypeHSBA delegate:self] animated:YES completion:nil];

}


- (void)updatePreview {


  colorPreview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 29)];
  colorPreview.layer.cornerRadius = 14.5;
  colorPreview.layer.borderWidth = 1.5;
  colorPreview.layer.borderColor = self.borderColour.CGColor;

  NSString *bundleID = self.specifier.properties[@"defaults"];
  NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

  NSString *hex = [settings objectForKey:self.specifier.properties[@"key"]] ?: self.specifier.properties[@"default"];

  UIColor *color = colorFromHexString(hex);

  colorPreview.backgroundColor = color;

  [self setAccessoryView:colorPreview];
}


- (void)didMoveToSuperview {
  [super didMoveToSuperview];

  [self updatePreview];

  [self.specifier setTarget:self];
  [self.specifier setButtonAction:@selector(openColorPicker)];

}


- (void)colorPickerDidUpdateColor:(UIColor *)color {

  NSString *hex = stringFromColor(color);

  NSString *bundleID = self.specifier.properties[@"defaults"];
  NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

  [settings setObject:hex forKey:self.specifier.properties[@"key"]];
  [settings writeToFile:prefsPath atomically:YES];

  [self updatePreview];

}

- (void)colorPickerDidChangeColor:(UIColor *)color {

  NSString *hex = stringFromColor(color);

  NSString *bundleID = self.specifier.properties[@"defaults"];
  NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

  [settings setObject:hex forKey:self.specifier.properties[@"key"]];
  [settings writeToFile:prefsPath atomically:YES];

  [self updatePreview];

}


- (void)setFrame:(CGRect)frame {
  inset = 10;
  frame.origin.x += inset;
  frame.size.width -= 2 * inset;
  [super setFrame:frame];
}


// - (void)layoutSubviews {
// 	[super layoutSubviews];

// 	[self.accessoryView setFrame:CGRectOffset(self.accessoryView.frame, -10, 0)];

// }


@end
