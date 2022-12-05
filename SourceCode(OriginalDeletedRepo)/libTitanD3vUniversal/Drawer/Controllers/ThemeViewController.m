#import "ThemeViewController.h"


@implementation ThemeViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tintColour = [[TDAppearance sharedInstance] tintColour];
    self.view.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
  self.view.layer.maskedCorners = 12;
  self.view.layer.cornerRadius = 30;
  self.view.layer.cornerCurve = kCACornerCurveContinuous;
  self.view.clipsToBounds = true;

  [self layoutBannerView];
  [self layoutCollectionView];

}


-(void)layoutBannerView {

  self.bannerView = [[BlurBannerView alloc] init];
  self.bannerView.clipsToBounds = true;
  [self.view addSubview:self.bannerView];

  self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.bannerView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.bannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.bannerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.bannerView.heightAnchor constraintEqualToConstant:140].active = YES;


  self.iconImage = [[UIImageView alloc] init];
  self.iconImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/themes.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIColor *iconTint = [self.tintColour colorWithAlphaComponent:0.7];
  self.iconImage.tintColor = iconTint;
  [self.bannerView addSubview:self.iconImage];

  self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.iconImage.heightAnchor constraintEqualToConstant:70].active = YES;
  [self.iconImage.widthAnchor constraintEqualToConstant:70].active = YES;
  [self.iconImage.topAnchor constraintEqualToAnchor:self.bannerView.topAnchor constant:10].active = YES;
  [[self.iconImage centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.textColor = UIColor.whiteColor;
  self.titleLabel.font = [UIFont systemFontOfSize:16];
  self.titleLabel.text = @"Themes";
  [self.bannerView addSubview:self.titleLabel];

  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
  [[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;
}


-(void)layoutCollectionView {

  self.themeArray = [[NSArray alloc] initWithObjects:@"Navigation Bar", @"Tint", @"Background", @"Cells", @"Label", @"Banner", @"Container", @"Border",  nil];

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = UIColor.clearColor;
  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.collectionView setShowsHorizontalScrollIndicator:NO];
  [self.collectionView setShowsVerticalScrollIndicator:NO];
  [self.collectionView registerClass:[ThemeCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.view addSubview:self.collectionView];

  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;

  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.collectionView.topAnchor constraintEqualToAnchor:self.bannerView.bottomAnchor constant:20].active = YES;
  [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
  [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
  [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;

}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.themeArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  ThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  cell.backgroundColor = UIColor.clearColor;
  cell.titleLabel.text = [self.themeArray objectAtIndex:indexPath.row];

  if (indexPath.row == 0) {
    cell.colourView.backgroundColor = [[TDAppearance sharedInstance] navigationBarColour];
  } else if (indexPath.row == 1) {
    cell.colourView.backgroundColor = [[TDAppearance sharedInstance] tintColour];
  } else if (indexPath.row == 2) {
    cell.colourView.backgroundColor = [[TDAppearance sharedInstance] backgroundColour];
  } else if (indexPath.row == 3) {
    cell.colourView.backgroundColor = [[TDAppearance sharedInstance] cellColour];
  } else if (indexPath.row == 4) {
    cell.colourView.backgroundColor = [[TDAppearance sharedInstance] labelColour];
  } else if (indexPath.row == 5) {
    cell.colourView.backgroundColor = [[TDAppearance sharedInstance] bannerColour];
  } else if (indexPath.row == 6) {
    cell.colourView.backgroundColor = [[TDAppearance sharedInstance] containerColour];
  } else if (indexPath.row == 7) {
    cell.colourView.backgroundColor = [[TDAppearance sharedInstance] borderColour];
  }

  return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

  return CGSizeMake(100, 120);

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  invokeHapticFeedback();

  colourPickerIndex = indexPath.row;
  UIColor *currentColor;

  if (indexPath.row == 0) {
    currentColor = [[TDAppearance sharedInstance] navigationBarColour];
  } else if (indexPath.row == 1) {
    currentColor = [[TDAppearance sharedInstance] tintColour];
  } else if (indexPath.row == 2) {
    currentColor = [[TDAppearance sharedInstance] backgroundColour];
  } else if (indexPath.row == 3) {
    currentColor = [[TDAppearance sharedInstance] cellColour];
  } else if (indexPath.row == 4) {
    currentColor = [[TDAppearance sharedInstance] labelColour];
  } else if (indexPath.row == 5) {
    currentColor = [[TDAppearance sharedInstance] bannerColour];
  } else if (indexPath.row == 6) {
    currentColor = [[TDAppearance sharedInstance] containerColour];
  } else if (indexPath.row == 7) {
    currentColor = [[TDAppearance sharedInstance] borderColour];
  }


  [self presentViewController:[[TDColorPickerViewController alloc] initWithColor:currentColor stackType:TDColorSpaceTypeHSBA delegate:self] animated:YES completion:nil];

}


-(void)colorPickerDidUpdateColor:(UIColor *)color {

  NSString *hex = stringFromColor(color);


  if (colourPickerIndex == 0) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"navigationBarTheme"];
  } else if (colourPickerIndex == 1) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"tintTheme"];
  } else if (colourPickerIndex == 2) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"backgroundTheme"];
  } else if (colourPickerIndex == 3) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"cellTheme"];
  } else if (colourPickerIndex == 4) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"labelTheme"];
  } else if (colourPickerIndex == 5) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"bannerTheme"];
  } else if (colourPickerIndex == 6) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"containerTheme"];
  } else if (colourPickerIndex == 7) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"borderTheme"];
  }

  [self.collectionView reloadData];

}


-(void)colorPickerDidChangeColor:(UIColor *)color {

  NSString *hex = stringFromColor(color);

  if (colourPickerIndex == 0) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"navigationBarTheme"];
  } else if (colourPickerIndex == 1) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"tintTheme"];
  } else if (colourPickerIndex == 2) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"backgroundTheme"];
  } else if (colourPickerIndex == 3) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"cellTheme"];
  } else if (colourPickerIndex == 4) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"labelTheme"];
  } else if (colourPickerIndex == 5) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"bannerTheme"];
  } else if (colourPickerIndex == 6) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"containerTheme"];
  } else if (colourPickerIndex == 7) {
    [[TDPrefsManager sharedInstance] setObject:hex forKey:@"borderTheme"];
  }

  [self.collectionView reloadData];

}

-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

@end
