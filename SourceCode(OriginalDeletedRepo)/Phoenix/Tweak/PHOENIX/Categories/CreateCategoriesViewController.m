#import "CreateCategoriesViewController.h"


@implementation CreateCategoriesViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.systemBackgroundColor;
  UIWindow *keyWindow = nil;
  NSArray *windows = [[UIApplication sharedApplication] windows];
  for (UIWindow *window in windows) {
    if (window.isKeyWindow) {
      keyWindow = window;
      break;
    }
  }

  keyWindow.tintColor = [[SettingManager sharedInstance] accentColour];
  self.view.tintColor = [[SettingManager sharedInstance] accentColour];
  self.accentColour = [[SettingManager sharedInstance] accentColour];

  self.iconArray = [[CreateCategoryDataSource sharedInstance] iconData];
  self.colourArray = [[CreateCategoryDataSource sharedInstance] colourData];

  [self layoutScrollView];
  [self setupScrollViewData];
  [self.textField becomeFirstResponder];
  [self layoutHeaderView];
}


-(void)layoutScrollView {

  self.pageArray = [[NSMutableArray alloc] init];
  [self.pageArray addObject:@"Categories Name"];
  [self.pageArray addObject:@"Icons"];
  [self.pageArray addObject:@"Colour"];


  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.backgroundColor = [UIColor clearColor];
  self.scrollView.pagingEnabled = YES;
  self.scrollView.clipsToBounds = NO;
  [self.scrollView setShowsHorizontalScrollIndicator:NO];
  [self.scrollView setShowsVerticalScrollIndicator:NO];
  self.scrollView.scrollEnabled = NO;
  [self.view addSubview:self.scrollView];

}


-(void)setupScrollViewData {

  [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width * self.pageArray.count, self.view.frame.size.height)];

  [self.scrollView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

  int i = 0;

  for (NSString *string in self.pageArray) {

    if ([string isEqualToString:@"Categories Name"]) {
      [self namePage:i];
    } else if ([string isEqualToString:@"Icons"]) {
      [self iconsPage:i];
    } else if ([string isEqualToString:@"Colour"]) {
      [self colourPage:i];
    }

    i = i + 1;
  }

}


-(void)layoutHeaderView {

  self.headerView = [[TDHeaderView alloc] initWithTitle:@"" accent:self.accentColour leftIcon:@"xmark" leftAction:@selector(dismissVC)];
  self.headerView.leftButton.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.headerView.rightButton.alpha = 0;
  [self.view addSubview:self.headerView];

  [self.headerView size:CGSizeMake(self.view.frame.size.width, 75)];
  [self.headerView x:self.view.centerXAnchor];
  [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];

}


-(void)namePage:(int)page {

  UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * page, 0, self.view.frame.size.width, self.view.frame.size.height)];
  [self.scrollView addSubview:baseView];


  UIImageView *icon = [[UIImageView alloc] init];
  icon.image = [UIImage systemImageNamed:@"folder.fill"];
  icon.contentMode = UIViewContentModeScaleAspectFit;
  icon.tintColor = UIColor.tertiaryLabelColor;
  [baseView addSubview:icon];

  [icon size:CGSizeMake(70, 70)];
  [icon x:baseView.centerXAnchor];
  [icon top:baseView.topAnchor padding:80];


  UILabel *header = [[UILabel alloc] init];
  header.textAlignment = NSTextAlignmentCenter;
  header.textColor = UIColor.labelColor;
  header.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBlack];
  header.text = @"Category Name";
  [baseView addSubview:header];

  [header x:baseView.centerXAnchor];
  [header top:icon.bottomAnchor padding:15];


  self.textField = [[UITextField alloc] init];
  self.textField.layer.cornerRadius = 12;
  self.textField.layer.cornerCurve = kCACornerCurveContinuous;
  self.textField.font = [UIFont systemFontOfSize:18];
  self.textField.placeholder = @"Categories name...";
  self.textField.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.textField.tintColor = self.accentColour;
  self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textField.keyboardType = UIKeyboardTypeASCIICapable;
  self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.textField.delegate = self;
  [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
  [baseView addSubview:self.textField];

  [self.textField size:CGSizeMake(self.view.frame.size.width-40, 45)];
  [self.textField x:baseView.centerXAnchor];
  [self.textField top:header.bottomAnchor padding:30];

  UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(15,0,10,45)];
  leftView.backgroundColor = [UIColor clearColor];
  self.textField.leftView = leftView;
  self.textField.leftViewMode = UITextFieldViewModeAlways;


  self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
  self.textField.inputAccessoryView = self.toolView;


  self.nameButton = [[CategoriesNextButton alloc] initWithIcon:@"arrow.right" title:@"Icon" accent:self.accentColour action:@selector(pushToIconPage)];
  self.nameButton.layer.cornerRadius = 25;
  self.nameButton.alpha = 0.7;
  self.nameButton.enabled = NO;
  [self.toolView addSubview:self.nameButton];

  [self.nameButton size:CGSizeMake(180, 50)];
  [self.nameButton x:self.toolView.centerXAnchor];
  [self.nameButton y:self.toolView.centerYAnchor];

}


-(void)iconsPage:(int)page {

  UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * page, 0, self.view.frame.size.width, self.view.frame.size.height)];
  [self.scrollView addSubview:baseView];


  UIImageView *icon = [[UIImageView alloc] init];
  icon.image = [UIImage systemImageNamed:@"sparkles"];
  icon.contentMode = UIViewContentModeScaleAspectFit;
  icon.tintColor = UIColor.tertiaryLabelColor;
  [baseView addSubview:icon];

  [icon size:CGSizeMake(70, 70)];
  [icon x:baseView.centerXAnchor];
  [icon top:baseView.topAnchor padding:80];


  UILabel *header = [[UILabel alloc] init];
  header.textAlignment = NSTextAlignmentCenter;
  header.textColor = UIColor.labelColor;
  header.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBlack];
  header.text = @"Icon";
  [baseView addSubview:header];

  [header x:baseView.centerXAnchor];
  [header top:icon.bottomAnchor padding:15];


  self.iconButton = [[CategoriesNextButton alloc] initWithIcon:@"arrow.right" title:@"Colour" accent:self.accentColour action:@selector(pushToColourPage)];
  self.iconButton.layer.cornerRadius = 25;
  self.iconButton.alpha = 0.7;
  self.iconButton.enabled = NO;
  [baseView addSubview:self.iconButton];

  [self.iconButton size:CGSizeMake(180, 50)];
  [self.iconButton x:baseView.centerXAnchor];
  [self.iconButton bottom:self.view.bottomAnchor padding:-40];


  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  self.iconCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.iconCollectionView.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.iconCollectionView.layer.cornerRadius = 15;
  self.iconCollectionView.layer.cornerCurve = kCACornerCurveContinuous;
  self.iconCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.iconCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.iconCollectionView setShowsHorizontalScrollIndicator:NO];
  [self.iconCollectionView setShowsVerticalScrollIndicator:NO];
  [self.iconCollectionView registerClass:[CategoriesIconCell class] forCellWithReuseIdentifier:@"IconCell"];
  [baseView addSubview:self.iconCollectionView];

  [self.iconCollectionView width:self.view.frame.size.width-40];
  [self.iconCollectionView x:baseView.centerXAnchor];
  [self.iconCollectionView top:header.bottomAnchor padding:30];
  [self.iconCollectionView bottom:self.iconButton.topAnchor padding:-30];

  self.iconCollectionView.delegate = self;
  self.iconCollectionView.dataSource = self;
}


-(void)colourPage:(int)page {

  UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * page, 0, self.view.frame.size.width, self.view.frame.size.height)];
  [self.scrollView addSubview:baseView];


  UIImageView *icon = [[UIImageView alloc] init];
  icon.image = [UIImage systemImageNamed:@"paintpalette.fill"];
  icon.contentMode = UIViewContentModeScaleAspectFit;
  icon.tintColor = UIColor.tertiaryLabelColor;
  [baseView addSubview:icon];

  [icon size:CGSizeMake(70, 70)];
  [icon x:baseView.centerXAnchor];
  [icon top:baseView.topAnchor padding:80];


  UILabel *header = [[UILabel alloc] init];
  header.textAlignment = NSTextAlignmentCenter;
  header.textColor = UIColor.labelColor;
  header.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBlack];
  header.text = @"Colour";
  [baseView addSubview:header];

  [header x:baseView.centerXAnchor];
  [header top:icon.bottomAnchor padding:15];


  self.colourButton = [[CategoriesNextButton alloc] initWithIcon:@"arrow.right" title:@"Create" accent:self.accentColour action:@selector(saveNewCategory)];
  self.colourButton.layer.cornerRadius = 25;
  self.colourButton.alpha = 0.7;
  self.colourButton.enabled = NO;
  [baseView addSubview:self.colourButton];

  [self.colourButton size:CGSizeMake(180, 50)];
  [self.colourButton x:baseView.centerXAnchor];
  [self.colourButton bottom:self.view.bottomAnchor padding:-40];


  self.customColour = [[CategoriesColourSection alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"eyedropper.halffull"]];
  self.customColour.iconView.backgroundColor = [self.accentColour colorWithAlphaComponent:0.4];
  self.customColour.icon.tintColor = self.accentColour;
  self.customColour.title.text = @"Custom colour";
  self.customColour.colourView.backgroundColor = UIColor.systemIndigoColor;
  [baseView addSubview:self.customColour];

  [self.customColour size:CGSizeMake(self.view.frame.size.width-40, 70)];
  [self.customColour x:baseView.centerXAnchor];
  [self.customColour bottom:self.colourButton.topAnchor padding:-25];

  [self.customColour addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentColourPickerVC)]];


  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  self.colourCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.colourCollectionView.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.colourCollectionView.layer.cornerRadius = 15;
  self.colourCollectionView.layer.cornerCurve = kCACornerCurveContinuous;
  self.colourCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.colourCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.colourCollectionView setShowsHorizontalScrollIndicator:NO];
  [self.colourCollectionView setShowsVerticalScrollIndicator:NO];
  [self.colourCollectionView registerClass:[CategoriesColourCell class] forCellWithReuseIdentifier:@"ColourCell"];
  [baseView addSubview: self.colourCollectionView];

  [self.colourCollectionView width:self.view.frame.size.width-40];
  [self.colourCollectionView x:baseView.centerXAnchor];
  [self.colourCollectionView top:header.bottomAnchor padding:30];
  [self.colourCollectionView bottom:self.customColour.topAnchor padding:-20];

  self.colourCollectionView.delegate = self;
  self.colourCollectionView.dataSource = self;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if (collectionView == self.iconCollectionView) {
    return self.iconArray.count;
  } else {
    return self.colourArray.count;
  }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  if (collectionView == self.iconCollectionView) {

    CategoriesIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IconCell" forIndexPath:indexPath];

    CategoriesIconModel *model = [self.iconArray objectAtIndex:indexPath.row];

    cell.backgroundColor = UIColor.clearColor;
    cell.baseView.backgroundColor = [self.accentColour colorWithAlphaComponent:0.4];
    cell.iconImage.tintColor = self.accentColour;
    cell.iconImage.image = [UIImage systemImageNamed:model.imageName];

    if (self.didSelectIcon) {
      if (indexPath.row == self.iconSelectedIndex) {
        cell.iconImage.image = [UIImage systemImageNamed:@"checkmark"];
        cell.iconImage.tintColor = UIColor.whiteColor;
      }
    }

    return cell;

  } else {

    CategoriesColourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColourCell" forIndexPath:indexPath];

    CategoriesColourModel *model = [self.colourArray objectAtIndex:indexPath.row];

    cell.backgroundColor = UIColor.clearColor;
    cell.baseView.backgroundColor = [self colorWithHexString:model.colourHEX];
    cell.iconImage.tintColor = UIColor.whiteColor;

    if (self.didSelectColour) {
      if (indexPath.row == self.colourSelectedIndex) {
        cell.iconImage.image = [UIImage systemImageNamed:@"checkmark"];
      }
    }

    return cell;

  }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat width = (self.view.frame.size.width-110)/3;
  return CGSizeMake(width, width-30);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 10.0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(20,20,20,20);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  if (collectionView == self.iconCollectionView) {

    self.iconButton.alpha = 1;
    self.iconButton.enabled = YES;

    self.didSelectIcon = YES;
    self.iconSelectedIndex = indexPath.row;

    CategoriesIconModel *model = [self.iconArray objectAtIndex:indexPath.row];
    self.iconName = model.imageName;

    [self.iconCollectionView reloadData];

  } else {

    CategoriesColourModel *model = [self.colourArray objectAtIndex:indexPath.row];

    self.didSelectColour = YES;
    self.colourSelectedIndex = indexPath.row;
    self.colourButton.alpha = 1;
    self.colourButton.enabled = YES;
    self.categoryColour = model.colourHEX;
    [self.colourCollectionView reloadData];
  }

}


- (void)textFieldDidChange:(UITextField *)textField {
  [self updateCategoryNameWithString:textField.text];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
  [self updateCategoryNameWithString:textField.text];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  [self updateCategoryNameWithString:textField.text];
  return YES;
}


-(void)updateCategoryNameWithString:(NSString *)category {
  if (self.textField && self.textField.text.length > 0) {
    self.nameButton.alpha = 1.0;
    self.nameButton.enabled = YES;
  } else {
    self.nameButton.alpha = 0.7;
    self.nameButton.enabled = NO;
  }
}


-(void)pushToIconPage {
  [self.textField resignFirstResponder];
  [self scrollToPage:1];
}


-(void)pushToColourPage {
  [self scrollToPage:2];
}


-(void)presentColourPickerVC {
  UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
  colourPickerVC.delegate = self;
  colourPickerVC.selectedColor = self.customColour.colourView.backgroundColor;
  colourPickerVC.supportsAlpha = NO;
  [self presentViewController:colourPickerVC animated:YES completion:nil];
}


- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{
  self.colourButton.alpha = 1;
  self.colourButton.enabled = YES;
  self.didSelectColour = NO;
  [self.colourCollectionView reloadData];
  UIColor *cpSelectedColour = viewController.selectedColor;
  self.customColour.colourView.backgroundColor = cpSelectedColour;
  self.categoryColour = [self hexStringFromColor:cpSelectedColour];
}


- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{
  self.colourButton.alpha = 1;
  self.colourButton.enabled = YES;
  self.didSelectColour = NO;
  [self.colourCollectionView reloadData];
  UIColor *cpSelectedColour = viewController.selectedColor;
  self.customColour.colourView.backgroundColor = cpSelectedColour;
  self.categoryColour = [self hexStringFromColor:cpSelectedColour];
}


-(void)saveNewCategory {

  self.categoryName = self.textField.text;

  //NSString *plistName = [self.categoryName stringByReplacingOccurrencesOfString:@" " withString:@""];
  //NSLog(@"categories name: %@ plistname: %@ icon: %@ colour: %@", self.categoryName, plistName, self.iconName, self.categoryColour);
  //NSString *prefPath = @"/var/mobile/Library/Preferences/PaletteCollections.plist";

  // [IMPORTANT] need to post notification to write new categories to plist
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/Categories.plist", aDocumentsDirectory];

  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  self.mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

  NSString *withID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000.0)];
  NSDictionary *data = @{@"id" : withID, @"categoriesName" : self.categoryName, @"categoriesColour" : self.categoryColour, @"categoriesIcon" : self.iconName};
  [self.mutableDict setValue:data forKey:withID];
  [self.mutableDict writeToFile:plistPath atomically:YES];

  [self.delegate didCreatedNewCategory];

  [self dismissVC];
}


-(void)scrollToPage:(NSInteger)page {
  CGPoint offset = CGPointMake(page * self.scrollView.frame.size.width, 0);
  [self.scrollView setContentOffset:offset animated:YES];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

  }];

  [alert addAction:defaultAction];

  [self presentViewController:alert animated:YES completion:nil];
}


-(void)dismissVC {
  [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSString *)hexStringFromColor:(UIColor *)color {
  const CGFloat *components = CGColorGetComponents(color.CGColor);

  CGFloat r = components[0];
  CGFloat g = components[1];
  CGFloat b = components[2];

  return [NSString stringWithFormat:@"%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
}


-(UIColor*)colorWithHexString:(NSString*)hex {

  NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

  if ([cString length] < 6) return [UIColor grayColor];

  if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];

  if ([cString length] != 6) return  [UIColor grayColor];

  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];

  range.location = 2;
  NSString *gString = [cString substringWithRange:range];

  range.location = 4;
  NSString *bString = [cString substringWithRange:range];

  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];

  return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
