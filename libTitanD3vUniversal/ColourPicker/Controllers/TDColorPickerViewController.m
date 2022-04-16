#import "TDColorPickerViewController.h"
#import "TDColorSliderStackView.h"
#import "UIColor+ChromaPicker_Internal.h"
#import "TDColorDisplayView.h"


@interface TDColorPickerViewController ()
@property (nonatomic, strong) UIStackView *viewStack;
@property (nonatomic, strong) TDColorDisplayView *colorDisplayView;
@property (nonatomic, strong) TDColorSliderStackView *sliderStackView;
@property (nonatomic, strong) UISegmentedControl *typeSelectionView;
@property (nonatomic, strong) UICollectionView *colorCollectionView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *grabberView;
@property (nonatomic, strong) NSArray<TDColorCollection *> *colorDataSource;
@end


@implementation TDColorPickerViewController

- (instancetype)initWithColor:(UIColor *)color stackType:(TDColorSpaceType)stackType delegate:(id<TDColorPickerDelegate>)delegate {

  if (self == [super init]) {
    self.delegate = delegate;
    self.currentColor = color;

    _sliderStackView = [[TDColorSliderStackView alloc] initWithColor:color stackType:stackType delegate:self];
    _colorDisplayView = [[TDColorDisplayView alloc] initWithColor:color];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];


  self.blurEffectView = [[UIVisualEffectView alloc] init];
  self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
  self.blurEffectView.alpha = 0;
  self.blurEffectView.userInteractionEnabled = true;
  [self.view insertSubview:self.blurEffectView atIndex:0];

  self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
  [self.blurEffectView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;


  UITapGestureRecognizer *dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
  dismissGesture.delegate = self;
  [self.blurEffectView addGestureRecognizer:dismissGesture];


  [self performSelector:@selector(setDimming) withObject:nil afterDelay:0.3];


  self.tintColour = [[TDAppearance sharedInstance] tintColour];
  self.containerColour = [[TDAppearance sharedInstance] containerColour];
  self.borderColour = [[TDAppearance sharedInstance] borderColour];


  UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
  layout.itemSize = CGSizeMake(30, 30);
  layout.headerReferenceSize = CGSizeMake(40, 30);
  layout.minimumInteritemSpacing = 8;
  layout.minimumLineSpacing = 8;
  layout.scrollDirection = UICollectionViewScrollDirectionVertical;

  _colorCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  _colorCollectionView.backgroundColor = nil;
  _colorCollectionView.dataSource = self;
  _colorCollectionView.delegate = self;
  _colorCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
  [_colorCollectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"CELL"];
  [_colorCollectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];

  [self setColorCollection:_colorCollection];

  _backgroundView = [UIView new];
  _backgroundView.layer.cornerRadius = 16;
  _backgroundView.layer.masksToBounds = YES;
  if (@available(iOS 13.0, *)) {
    _backgroundView.layer.cornerCurve = kCACornerCurveContinuous;
  }
  _backgroundView.layer.borderWidth = 1;
  _backgroundView.layer.borderColor = self.borderColour.CGColor;
  _backgroundView.backgroundColor = self.containerColour;
  [self.view addSubview:_backgroundView];

  _grabberView = [UIView new];
  _grabberView.layer.cornerRadius = 3;
  _grabberView.layer.masksToBounds = YES;
  _grabberView.backgroundColor = self.tintColour;
  [self.view addSubview:_grabberView];

  _typeSelectionView = [UISegmentedControl new];
  [_typeSelectionView addTarget:self action:@selector(setStackType:) forControlEvents:UIControlEventValueChanged];
  [_typeSelectionView insertSegmentWithTitle:@"HSB" atIndex:0 animated:NO];
  [_typeSelectionView insertSegmentWithTitle:@"RGB" atIndex:1 animated:NO];
  [_typeSelectionView insertSegmentWithTitle:@"CMYK" atIndex:2 animated:NO];
  [_typeSelectionView insertSegmentWithTitle:@"Picker" atIndex:3 animated:NO];
  _typeSelectionView.selectedSegmentIndex = 0;
  if (@available(iOS 13.0, *)) {
    _typeSelectionView.selectedSegmentTintColor = self.tintColour;
  }
  [self.view addSubview:_typeSelectionView];

  [self.view addSubview:_sliderStackView];

  _viewStack = [UIStackView new];
  _viewStack.axis = UILayoutConstraintAxisVertical;
  _viewStack.alignment = UIStackViewAlignmentFill;
  _viewStack.distribution = UIStackViewDistributionFill;
  _viewStack.spacing = 8;
  [_backgroundView addSubview:_viewStack];

  [_viewStack addArrangedSubview:_colorDisplayView];
  [_viewStack addArrangedSubview:_typeSelectionView];
  [_viewStack addArrangedSubview:_sliderStackView];

  _viewStack.translatesAutoresizingMaskIntoConstraints = NO;
  _grabberView.translatesAutoresizingMaskIntoConstraints = NO;
  _sliderStackView.translatesAutoresizingMaskIntoConstraints = NO;
  _typeSelectionView.translatesAutoresizingMaskIntoConstraints = NO;
  _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
  [_grabberView.widthAnchor constraintEqualToConstant:75],
  [_grabberView.heightAnchor constraintEqualToConstant:6],
  [_grabberView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
  [_grabberView.topAnchor constraintEqualToAnchor:_backgroundView.topAnchor constant:12],

  [_backgroundView.heightAnchor constraintEqualToAnchor:_viewStack.heightAnchor constant:46],
  [_backgroundView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-32],
  [_backgroundView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],
  [_backgroundView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-16],

  [_viewStack.leadingAnchor constraintEqualToAnchor:_backgroundView.leadingAnchor constant:16],
  [_viewStack.trailingAnchor constraintEqualToAnchor:_backgroundView.trailingAnchor constant:-16],
  [_viewStack.bottomAnchor constraintEqualToAnchor:_backgroundView.bottomAnchor constant:-16],

  [_colorDisplayView.heightAnchor constraintEqualToConstant: 40]
  ]];

  // if (@available(iOS 13, *)) {
  //   if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
  //     _backgroundView.backgroundColor = [UIColor colorWithRed: 0.14 green: 0.14 blue: 0.14 alpha: 1.00];
  //     _grabberView.backgroundColor = [UIColor colorWithRed: 0.20 green: 0.20 blue: 0.20 alpha: 1.00];
  //   } else {
  //     _backgroundView.backgroundColor = [UIColor colorWithRed: 0.92 green: 0.92 blue: 0.92 alpha: 1.00];
  //     _grabberView.backgroundColor = [UIColor colorWithRed: 0.88 green: 0.88 blue: 0.88 alpha: 1.00];
  //   }
  // } else {
  //   _backgroundView.backgroundColor = [UIColor colorWithRed: 0.92 green: 0.92 blue: 0.92 alpha: 1.00];
  //   _grabberView.backgroundColor = [UIColor colorWithRed: 0.88 green: 0.88 blue: 0.88 alpha: 1.00];
  // }
}


-(void)setDimming {
  [UIView animateWithDuration:0.4 animations:^ {
    self.blurEffectView.alpha = 1;
  }];
}


-(void)tapGestureFired {
  [[TDUtilities sharedInstance] haptic:0];

  [UIView animateWithDuration:0.2 animations:^ {
    self.blurEffectView.alpha = 0;
  }];
  [self performSelector:@selector(dismissVC) withObject:nil afterDelay:0.1];
}


-(void)dismissVC {
  [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  if (self.delegate && [self.delegate respondsToSelector:@selector(colorPickerDismissedWithColor:)]) {
    [self.delegate colorPickerDismissedWithColor:self.currentColor];
  }

  [UIView animateWithDuration:0.25 animations:^{
    self.view.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
  } completion:^(BOOL finished) {

  }];
}


- (void)colorPickerDidUpdateColor:(UIColor *)color {
  self.currentColor = color;
  _colorDisplayView.color = color;
  if (self.delegate && [self.delegate respondsToSelector:@selector(colorPickerDidUpdateColor:)]) {
    [self.delegate colorPickerDidUpdateColor:self.currentColor];
  }

}


- (void)colorPickerDidChangeColor:(UIColor *)color {
  if (self.delegate && [self.delegate respondsToSelector:@selector(colorPickerDidChangeColor:)]) {
    [self.delegate colorPickerDidChangeColor:self.currentColor];
  }

}


- (UIModalPresentationStyle)modalPresentationStyle {
  return UIModalPresentationOverCurrentContext;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  if (touches.anyObject.view == self.view) {
    //[self dismissViewControllerAnimated:YES completion:nil];
  } else if (touches.anyObject.view != _colorDisplayView) {
    [_colorDisplayView resignFirstResponder];
  }
}


- (void)setStackType:(UISegmentedControl *)sender {

  if (sender.selectedSegmentIndex < 3) {
    if (![_viewStack.arrangedSubviews containsObject:_sliderStackView]) {
      [_colorCollectionView removeFromSuperview];
      [_viewStack addArrangedSubview:_sliderStackView];
    }
  } else {
    if (![_viewStack.arrangedSubviews containsObject:_colorCollectionView]) {
      [_sliderStackView removeFromSuperview];
      [_colorCollectionView.heightAnchor constraintEqualToConstant:200].active = YES;
      [_viewStack addArrangedSubview:_colorCollectionView];
    }
  }

  switch (sender.selectedSegmentIndex) {
    case 0: { [_sliderStackView configureForStackType:TDColorSpaceTypeHSBA color:self.currentColor]; } break;
    case 1: { [_sliderStackView configureForStackType:TDColorSpaceTypeRGBA color:self.currentColor]; } break;
    case 2: { [_sliderStackView configureForStackType:TDColorSpaceTypeCMYKA color:self.currentColor]; } break;
    case 3: { } break;
    default: { [_sliderStackView configureForStackType:TDColorSpaceTypeHSBA color:self.currentColor]; } break;
  }
}


- (void)setColor:(UIColor *)color {
  self.currentColor = color;
  _colorDisplayView.color = color;
  [_sliderStackView setColor:color];
}


- (void)setColorCollection:(TDColorCollection *)colorCollection {
  _colorCollection = colorCollection;

  NSArray *defaultColors = @[
  [TDColorCollection defaultSystemColorsCollection],
  [TDColorCollection defaultPrimaryColorsCollection],
  [TDColorCollection defaultHueColorsCollection]
  ];

  _colorDataSource = colorCollection ? [@[colorCollection] arrayByAddingObjectsFromArray:defaultColors] : defaultColors;
  [_colorCollectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return _colorDataSource.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return _colorDataSource[section].count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
  cell.backgroundColor = _colorDataSource[indexPath.section].colors[indexPath.row];
  cell.layer.cornerRadius = 15;
  cell.layer.masksToBounds = YES;
  cell.layer.borderWidth = 1;
  if (@available(iOS 13.0, *)) {
    cell.layer.borderColor = UIColor.tertiarySystemFillColor.CGColor;
  } else {
    cell.layer.borderColor = UIColor.whiteColor.CGColor;
  }
  return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

  UICollectionReusableView *headerView;

  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADER" forIndexPath:indexPath];

    NSInteger labelTag = 0x2727272;
    UILabel *label = [headerView viewWithTag:labelTag];

    if (!label) {
      label = [UILabel new];
      [headerView addSubview:label];
      [label setTag:labelTag];
      if (@available(iOS 13.0, *)) {
        [label setTextColor:UIColor.secondaryLabelColor];
      } else {
        [label setTextColor:UIColor.blackColor];
      }
      [label setTranslatesAutoresizingMaskIntoConstraints:NO];
      [NSLayoutConstraint activateConstraints:@[
      [label.topAnchor constraintEqualToAnchor:headerView.topAnchor],
      [label.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor],
      [label.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor],
      [label.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor]
      ]];
    }

    label.text = _colorDataSource[indexPath.section].title.uppercaseString;
  }

  return headerView;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(40, 40);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView deselectItemAtIndexPath:indexPath animated:YES];
  [self colorPickerDidUpdateColor:_colorDataSource[indexPath.section].colors[indexPath.row]];
}

// - (void) traitCollectionDidChange: (UITraitCollection *) previousTraitCollection {

//   if (@available(iOS 13, *)) {
//     if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
//       _backgroundView.backgroundColor = [UIColor colorWithRed: 0.14 green: 0.14 blue: 0.14 alpha: 1.00];
//       _grabberView.backgroundColor = [UIColor colorWithRed: 0.20 green: 0.20 blue: 0.20 alpha: 1.00];
//     } else {
//       _backgroundView.backgroundColor = [UIColor colorWithRed: 0.92 green: 0.92 blue: 0.92 alpha: 1.00];
//       _grabberView.backgroundColor = [UIColor colorWithRed: 0.88 green: 0.88 blue: 0.88 alpha: 1.00];
//     }
//   } else {
//     _backgroundView.backgroundColor = [UIColor colorWithRed: 0.92 green: 0.92 blue: 0.92 alpha: 1.00];
//     _grabberView.backgroundColor = [UIColor colorWithRed: 0.88 green: 0.88 blue: 0.88 alpha: 1.00];
//   }

// }

@end
