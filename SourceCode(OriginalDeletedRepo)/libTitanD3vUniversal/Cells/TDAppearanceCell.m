#import "TDAppearanceCell.h"
//#import "../Global-Prefs.h"

@implementation TDAppearanceCell {
  UIStackView *_stackView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier specifier:specifier];

  if(self) {

    specifier.properties[@"height"] = [NSNumber numberWithInt:160];

    NSMutableArray *optionViewArray = [[NSMutableArray alloc] init];
    NSDictionary *options = [specifier propertyForKey:@"options"];

    for(NSString *key in options) {
      NSDictionary *optionProperties = [options objectForKey:key];

      NSString *customIconPath = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Appearance/%@.png", [optionProperties objectForKey:@"imageName"]];

      TDAppearanceOptionView *optionView = [[TDAppearanceOptionView alloc] initWithFrame:CGRectZero appearanceOption:[optionProperties objectForKey:@"appearanceOption"]];
      optionView.delegate = self;
      optionView.label.text = [optionProperties objectForKey:@"title"];
      optionView.previewImage = [[UIImage imageWithContentsOfFile:customIconPath]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
      optionView.tag = [[optionProperties objectForKey:@"arrangement"] integerValue];
      optionView.translatesAutoresizingMaskIntoConstraints = NO;

      [optionViewArray addObject:optionView];
    }


    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    _stackView = [[UIStackView alloc] initWithArrangedSubviews:[optionViewArray sortedArrayUsingDescriptors:@[ascendingSort]]];
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.distribution = UIStackViewDistributionFillEqually;
    _stackView.spacing = 0;
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_stackView];

    for(TDAppearanceOptionView *view in _stackView.arrangedSubviews) {
      view.enabled = [view.appearanceOption isEqual:[specifier performGetter]];
      view.highlighted = [view.appearanceOption isEqual:[specifier performGetter]];
    }

    [NSLayoutConstraint activateConstraints:@[
    [_stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
    [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
    [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    [_stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
    ]];
  }

  return self;
}


-(void)selectedOption:(TDAppearanceOptionView *)option {
  [self.specifier performSetterWithValue:option.appearanceOption];

  for(TDAppearanceOptionView *view in _stackView.arrangedSubviews) {
    [view updateViewForAppearance:option.appearanceOption];
  }
}


- (void)setFrame:(CGRect)frame {
  inset = 10;
  frame.origin.x += inset;
  frame.size.width -= 2 * inset;
  [super setFrame:frame];
}

@end
