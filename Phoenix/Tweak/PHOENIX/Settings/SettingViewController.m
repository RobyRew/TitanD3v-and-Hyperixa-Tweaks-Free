#import "SettingViewController.h"


@implementation SettingViewController

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

  [self layoutHeaderView];
  [self layoutTableView];
}


-(void)layoutHeaderView {

  self.headerView = [[TDHeaderView alloc] initWithTitle:@"Settings" accent:UIColor.systemBlueColor leftIcon:@"xmark" leftAction:@selector(dismissVC) rightIcon:@"checkmark" rightAction:@selector(applyChanges)];
  self.headerView.leftButton.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.headerView.leftButton.tintColor = self.accentColour;
  self.headerView.rightButton.backgroundColor = self.accentColour;
  self.headerView.rightButton.tintColor = UIColor.whiteColor;
  self.headerView.rightButton.alpha = 0;
  [self.view addSubview:self.headerView];

  [self.headerView size:CGSizeMake(self.view.frame.size.width, 70)];
  [self.headerView x:self.view.centerXAnchor];
  [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];
}


-(void)layoutTableView {

  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.view addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;

  [self.tableView top:self.headerView.bottomAnchor padding:20];
  [self.tableView leading:self.view.leadingAnchor padding:0];
  [self.tableView trailing:self.view.trailingAnchor padding:0];
  [self.tableView bottom:self.view.bottomAnchor padding:0];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 3;
  } else if (section == 1) {
    return 1;
  } else {
    return 4;
  }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 35.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

  UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width -15, 45)];
  sectionHeaderView.backgroundColor = UIColor.clearColor;
  sectionHeaderView.layer.cornerRadius = 15;
  sectionHeaderView.clipsToBounds = true;

  UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, sectionHeaderView.frame.size.height /2 -9, 200, 18)];
  headerLabel.backgroundColor = [UIColor clearColor];
  headerLabel.textColor = UIColor.tertiaryLabelColor;
  headerLabel.textAlignment = NSTextAlignmentLeft;
  headerLabel.font = [UIFont boldSystemFontOfSize:16];
  [sectionHeaderView addSubview:headerLabel];

  if (section == 0) {
    headerLabel.text = @"General";
  } else if (section == 1) {
    headerLabel.text = @"Accent";
  } else {
    headerLabel.text = @"Actions Colour";
  }

  return sectionHeaderView;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  if (indexPath.section == 0) {

    SettingSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
      cell = [[SettingSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }


    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;

    if (indexPath.row == 0) {

      cell.iconView.backgroundColor = [UIColor.systemPinkColor colorWithAlphaComponent:0.4];
      cell.iconImage.image = [UIImage systemImageNamed:@"heart.fill"];
      cell.iconImage.tintColor = UIColor.systemPinkColor;
      cell.titleLabel.text = @"Favourites";
      cell.subtitleLabel.text = @"Show favourites";
      [cell.toggleSwitch addTarget:self action:@selector(toggleFavourites:) forControlEvents:UIControlEventValueChanged];
      [cell.toggleSwitch setOn:[[SettingManager sharedInstance] boolForKey:@"showFavourites" defaultValue:YES] animated:NO];
      cell.toggleSwitch.onTintColor = UIColor.systemPinkColor;

    } else if (indexPath.row == 1) {

      cell.iconView.backgroundColor = [UIColor.systemIndigoColor colorWithAlphaComponent:0.4];
      cell.iconImage.image = [UIImage systemImageNamed:@"waveform"];
      cell.iconImage.tintColor = UIColor.systemIndigoColor;
      cell.titleLabel.text = @"Haptic";
      cell.subtitleLabel.text = @"Enable haptic feedback";
      [cell.toggleSwitch addTarget:self action:@selector(toggleHaptic:) forControlEvents:UIControlEventValueChanged];
      [cell.toggleSwitch setOn:[[SettingManager sharedInstance] boolForKey:@"enableHaptic" defaultValue:NO] animated:NO];
      cell.toggleSwitch.onTintColor = UIColor.systemIndigoColor;
    
    } else if (indexPath.row == 2) {
            
      cell.iconView.backgroundColor = [UIColor.systemOrangeColor colorWithAlphaComponent:0.4];
      cell.iconImage.image = [UIImage systemImageNamed:@"eye.fill"];
      cell.iconImage.tintColor = UIColor.systemOrangeColor;
      cell.titleLabel.text = @"Contacts";
      cell.subtitleLabel.text = @"Hide phone number & email";
      [cell.toggleSwitch addTarget:self action:@selector(toggleHideContactsDetails:) forControlEvents:UIControlEventValueChanged];
      [cell.toggleSwitch setOn:[[SettingManager sharedInstance] boolForKey:@"hideContactsDetails" defaultValue:NO] animated:NO];
      cell.toggleSwitch.onTintColor = UIColor.systemIndigoColor;
    }

    return cell;

  } else if (indexPath.section == 1) {

    SettingColourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
      cell = [[SettingColourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;

    cell.iconView.backgroundColor = [UIColor.systemYellowColor colorWithAlphaComponent:0.4];
    cell.iconImage.image = [UIImage systemImageNamed:@"paintpalette.fill"];
    cell.iconImage.tintColor = UIColor.systemYellowColor;
    cell.titleLabel.text = @"Accent";
    cell.subtitleLabel.text = @"Global accent colour";
    cell.colourView.backgroundColor = [[SettingManager sharedInstance] accentColour];

    return cell;

  } else {

    SettingColourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
      cell = [[SettingColourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;


    if (indexPath.row == 0) {

      cell.iconView.backgroundColor = [UIColor.systemGreenColor colorWithAlphaComponent:0.4];
      cell.iconImage.image = [UIImage systemImageNamed:@"phone.fill"];
      cell.iconImage.tintColor = UIColor.systemGreenColor;
      cell.titleLabel.text = @"Call";
      cell.subtitleLabel.text = @"Action button colour";
      cell.colourView.backgroundColor = [[SettingManager sharedInstance] callButtonColour];

    } else if (indexPath.row == 1) {

      cell.iconView.backgroundColor = [UIColor.systemBlueColor colorWithAlphaComponent:0.4];
      cell.iconImage.image = [UIImage systemImageNamed:@"message.fill"];
      cell.iconImage.tintColor = UIColor.systemBlueColor;
      cell.titleLabel.text = @"Message";
      cell.subtitleLabel.text = @"Action button colour";
      cell.colourView.backgroundColor = [[SettingManager sharedInstance] messageButtonColour];

    } else if (indexPath.row == 2) {

      cell.iconView.backgroundColor = [UIColor.systemTealColor colorWithAlphaComponent:0.4];
      cell.iconImage.image = [UIImage systemImageNamed:@"envelope.fill"];
      cell.iconImage.tintColor = UIColor.systemTealColor;
      cell.titleLabel.text = @"Email";
      cell.subtitleLabel.text = @"Action button colour";
      cell.colourView.backgroundColor = [[SettingManager sharedInstance] emailButtonColour];

    } else if (indexPath.row == 3) {

      cell.iconView.backgroundColor = [UIColor.systemRedColor colorWithAlphaComponent:0.4];
      cell.iconImage.image = [UIImage systemImageNamed:@"trash.fill"];
      cell.iconImage.tintColor = UIColor.systemRedColor;
      cell.titleLabel.text = @"Delete";
      cell.subtitleLabel.text = @"Action button colour";
      cell.colourView.backgroundColor = [[SettingManager sharedInstance] deleteButtonColour];

    }

    return cell;
  }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 75;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

  if (indexPath.section == 1) {
    self.colourPickerIndex = 0;
    [self presentColourPickerVC];
  }

  if (indexPath.section == 2) {

    if (indexPath.row == 0) {
      self.colourPickerIndex = 1;
    } else if (indexPath.row == 1) {
      self.colourPickerIndex = 2;
    } else if (indexPath.row == 2) {
      self.colourPickerIndex = 3;
    } else if (indexPath.row == 3) {
      self.colourPickerIndex = 4;
    }

    [self presentColourPickerVC];
  }

}


-(void)toggleFavourites:(UISwitch *)sender {
  [self didMakeChanges];
  [[SettingManager sharedInstance] setBool:sender.on forKey:@"showFavourites"];
}


-(void)toggleHaptic:(UISwitch *)sender {
  [self didMakeChanges];
  [[SettingManager sharedInstance] setBool:sender.on forKey:@"enableHaptic"];
}


-(void)toggleHideContactsDetails:(UISwitch *)sender {
    [self didMakeChanges];
    [[SettingManager sharedInstance] setBool:sender.on forKey:@"hideContactsDetails"];
}


-(void)presentColourPickerVC {

  UIColor *previewColour;

  if (self.colourPickerIndex == 0) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    previewColour = cell.colourView.backgroundColor;
  } else if (self.colourPickerIndex == 1) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    previewColour = cell.colourView.backgroundColor;
  } else if (self.colourPickerIndex == 2) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    previewColour = cell.colourView.backgroundColor;
  } else if (self.colourPickerIndex == 3) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:2 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    previewColour = cell.colourView.backgroundColor;
  } else if (self.colourPickerIndex == 4) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    previewColour = cell.colourView.backgroundColor;
  }

  UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
  colourPickerVC.delegate = self;
  colourPickerVC.selectedColor = previewColour;
  [self presentViewController:colourPickerVC animated:YES completion:nil];

}


- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{
  [self didMakeChanges];
  UIColor *cpSelectedColour = viewController.selectedColor;

  if (self.colourPickerIndex == 0) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"accentColour"];
  } else if (self.colourPickerIndex == 1) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"callButtonColour"];
  } else if (self.colourPickerIndex == 2) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"messageButtonColour"];
  } else if (self.colourPickerIndex == 3) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:2 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"emailButtonColour"];
  } else if (self.colourPickerIndex == 4) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"deleteButtonColour"];
  }

}


- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{
  [self didMakeChanges];
  UIColor *cpSelectedColour = viewController.selectedColor;

  if (self.colourPickerIndex == 0) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"accentColour"];
  } else if (self.colourPickerIndex == 1) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"callButtonColour"];
  } else if (self.colourPickerIndex == 2) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"messageButtonColour"];
  } else if (self.colourPickerIndex == 3) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:2 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"emailButtonColour"];
  } else if (self.colourPickerIndex == 4) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:2];
    SettingColourCell *cell = (SettingColourCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.colourView.backgroundColor = cpSelectedColour;
    [[SettingManager sharedInstance] setObject:[self hexStringFromColor:cpSelectedColour] forKey:@"deleteButtonColour"];
  }

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


-(void)dismissVC {
  [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)didMakeChanges {
  self.headerView.rightButton.alpha = 1;
  self.modalInPresentation = YES;
}


-(void)applyChanges {

  // UIApplication *app = [UIApplication sharedApplication];
  // [app performSelector:@selector(suspend)];
  // [NSThread sleepForTimeInterval:1.0];
  [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Phoenix/RelaunchPhoneApp" object:nil userInfo:nil deliverImmediately:YES];
  exit(0);

}

@end
