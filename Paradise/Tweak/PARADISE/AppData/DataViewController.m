#import "DataViewController.h"

#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static UIFontDescriptor *descriptor;
static NSInteger colourPickerIndex = 0;

static NSString *getAppName(NSString *BID){
  SBApplication *app = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:BID];
  return app.displayName;
}


@implementation DataViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  loadPrefs();

  descriptor = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIFontDescriptor class] fromData:appdataCustomFont error:nil];

  self.view.backgroundColor = UIColor.clearColor;
  [self layoutBaseView];
  [self layoutHeaderView];
  [self layoutTableView];
  [self layoutCollectionView];
}


-(instancetype)initWithIconView:(SBIconView*)iconView imgTitle:(NSString*)imgTitle iconID:(NSString*)iconID{
  iconVieww = iconView;
  SBIcon *icon = iconVieww.icon;

  self.bundleIdentifier = icon.applicationBundleID;
  self.appName = imgTitle;
  self.paradiseManager = [NSClassFromString(@"ParadiseManager") initForBundleIdentifier:self.bundleIdentifier];

  self.iconID = iconID;

  NSLog(@"ParadiseDebuggg iconID:-%@", self.iconID);

  return self;
}


-(void)layoutBaseView {
  loadPrefs();
  self.baseView = [[BlurBaseView alloc] init];
  self.baseView.layer.cornerRadius = bottomSheetCornerRadius;
  self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
  self.baseView.clipsToBounds = true;
  [self.view addSubview:self.baseView];

  [self.baseView x:self.view.centerXAnchor];
  [self.baseView height:MAIN_SCREEN_HEIGHT *0.55];
  [self.baseView bottom:self.view.bottomAnchor padding:-10];
  [self.baseView leading:self.view.leadingAnchor padding:10];
  [self.baseView trailing:self.view.trailingAnchor padding:-10];

}


-(void)layoutHeaderView {

  self.headerView = [[UIView alloc] init];
  self.headerView.backgroundColor = UIColor.clearColor;
  [self.baseView addSubview:self.headerView];

  [self.headerView height:130];
  [self.headerView top:self.baseView.topAnchor padding:0];
  [self.headerView leading:self.baseView.leadingAnchor padding:0];
  [self.headerView trailing:self.baseView.trailingAnchor padding:0];


  self.menuButton = [[UIButton alloc] init];
  UIImage *menuImage = [UIImage systemImageNamed:@"ellipsis"];
  [self.menuButton setImage:menuImage forState:UIControlStateNormal];
  self.menuButton.transform = CGAffineTransformMakeRotation(M_PI / 2);
  self.menuButton.tintColor = [UIColor appdataIconColor];
  self.menuButton.menu = [self appMenu];
  self.menuButton.showsMenuAsPrimaryAction = true;
  [self.headerView addSubview:self.menuButton];

  [self.menuButton size:CGSizeMake(40, 40)];
  [self.menuButton top:self.headerView.topAnchor padding:10];
  [self.menuButton trailing:self.headerView.trailingAnchor padding:-10];


  self.settingButton = [[UIButton alloc] init];
  UIImage *settingImage = [UIImage systemImageNamed:@"gear"];
  [self.settingButton setImage:settingImage forState:UIControlStateNormal];
  self.settingButton.tintColor = [UIColor appdataIconColor];
  [self.settingButton addTarget:self action:@selector(presentSettingVC) forControlEvents:UIControlEventTouchUpInside];
  [self.headerView addSubview:self.settingButton];

  [self.settingButton size:CGSizeMake(40, 40)];
  [self.settingButton top:self.headerView.topAnchor padding:10];
  [self.settingButton leading:self.headerView.leadingAnchor padding:10];


  self.appImage = [[UIImageView alloc] init];
  self.appImage.image = iconVieww.iconImageSnapshot;
  self.appImage.layer.cornerRadius = 10;
  self.appImage.clipsToBounds = true;
  [self.headerView addSubview:self.appImage];

  [self.appImage size:CGSizeMake(65, 65)];
  [self.appImage top:self.headerView.topAnchor padding:30];
  [self.appImage x:self.headerView.centerXAnchor];


  self.appLabel = [[UILabel alloc] init];
  if (toggleAppdataCustomFont) {
    self.appLabel.font = [UIFont fontWithDescriptor:descriptor size:18];
  } else {
    self.appLabel.font = [UIFont boldSystemFontOfSize:18];
  }
  self.appLabel.textAlignment = NSTextAlignmentCenter;
  self.appLabel.text = self.appName;
  self.appLabel.textColor = [UIColor appdataFontColor];
  [self.headerView addSubview:self.appLabel];

  [self.appLabel top:self.appImage.bottomAnchor padding:5];
  [self.appLabel x:self.headerView.centerXAnchor];

}


-(void)layoutTableView {

  self.listArray = [[NSArray alloc] initWithObjects:@"BundleID", @"Bundle", @"Container", nil];

  self.tableView = [[UITableView alloc] init];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;
  self.tableView.showsVerticalScrollIndicator = NO;
  if (toggleAppdataColour) {
    [self.tableView setSeparatorColor:[[TDTweakManager sharedInstance] colourForKey:@"appdataSeparatorColour" defaultValue:@"FFFFFF" ID:BID]];
  }
  [self.baseView addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;


  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.tableView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor].active = YES;
  [self.tableView.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10].active = YES;
  [self.tableView.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-10].active = YES;
  [self.tableView.bottomAnchor constraintEqualToAnchor:self.baseView.bottomAnchor constant:-5].active = YES;

  self.tableView.tableFooterView = [UIView new];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


  IconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iconCell"];

  if (cell == nil) {
    cell = [[IconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iconCell"];
  }

  UIView *selectionView = [UIView new];
  selectionView.backgroundColor = UIColor.clearColor;
  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
  cell.backgroundColor = UIColor.clearColor;

  cell.backgroundColor = UIColor.clearColor;
  cell.titleLabel.text = [self.listArray objectAtIndex:indexPath.row];


  if (indexPath.row == 0) { // Bundle ID

    cell.subtitleLabel.text = self.bundleIdentifier;
    cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/copy.png"];

  } else if (indexPath.row == 1) { // Bundle path

    cell.subtitleLabel.text = self.paradiseManager.bundlePATH;
    cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/folder.png"];

  } else if (indexPath.row == 2) { // Container path

    cell.subtitleLabel.text = self.paradiseManager.containerPATH;
    cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/folder.png"];
    cell.separatorInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, CGFLOAT_MAX);

    if ([cell.subtitleLabel.text isEqualToString:@"(null)"]) {
      cell.subtitleLabel.text = @"No container available";
    }
  }

  return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self invokeHapticFeedback];

  switch (indexPath.row) {

    case 0:  { // Copy bundle ID

      UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
      pasteboard.string = self.bundleIdentifier;

      NSString *messageString = [NSString stringWithFormat:@"The bundle ID for %@ was saved to your clipboard.", self.bundleIdentifier];

      UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Paradise" message:messageString preferredStyle:UIAlertControllerStyleAlert];

      UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];

      [alert addAction:defaultAction];
      [self presentViewController:alert animated:YES completion:nil];

      break;
    }

    case 1:  { // Open bundle in filza

      UIApplication *filza = [UIApplication sharedApplication];
      NSString *appPath = [NSString stringWithFormat:@"filza:/%@", self.paradiseManager.bundlePATH];
      NSURL *URL = [NSURL URLWithString:appPath];
      [filza openURL:URL options:@{} completionHandler:nil];

      break;
    }

    case 2: { // Open container in filza

      UIApplication *filza = [UIApplication sharedApplication];
      NSString *appPath = [NSString stringWithFormat:@"filza:/%@", self.paradiseManager.containerPATH];
      NSURL *URL = [NSURL URLWithString:appPath];
      [filza openURL:URL options:@{} completionHandler:nil];

      break;
    }
    default: break;
  }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 70;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}


- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
    cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
    cell.alpha = 0.5;
  } completion:nil];
}


- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
    cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
    cell.alpha = 1;
  } completion:nil];
}


-(void)invokeHapticFeedback {
  if (toggleAppdataHaptic) {

    if (appdataHapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (appdataHapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (appdataHapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }

  }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  if (touches.anyObject.view == self.view) {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self invokeHapticFeedback];
  } else if (touches.anyObject.view != self.baseView) {
    [self.baseView resignFirstResponder];
  }
}


-(UIMenu *)appMenu {

  UIAction *copyAction = [UIAction actionWithTitle:@"Copy App Info" image:[UIImage systemImageNamed:@"doc.plaintext.fill"] identifier:nil handler:^(UIAction *action) {

    NSString *appInfo = [NSString stringWithFormat:@"App Name: %@ \n\nVersion: %@ \n\nSize: %@ \n\nBundleID: %@ \n\nBundle Path: %@ \n\nContainer Path: %@", self.appLabel.text, self.paradiseManager.version, self.paradiseManager.diskUsageString, self.bundleIdentifier, self.paradiseManager.bundlePATH, self.paradiseManager.containerPATH];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = appInfo;
    [self showAlertWithTitle:@"App Info" message:@"The app information have been added to your clipboard."];
  }];


  UIAction *exportAction = [UIAction actionWithTitle:@"Export App Info" image:[UIImage systemImageNamed:@"square.and.arrow.up.fill"] identifier:nil handler:^(UIAction *action) {

    NSString *appInfo = [NSString stringWithFormat:@"App Name: %@ \n\nVersion: %@ \n\nSize: %@ \n\nBundleID: %@ \n\nBundle Path: %@ \n\nContainer Path: %@", self.appLabel.text, self.paradiseManager.version, self.paradiseManager.diskUsageString, self.bundleIdentifier, self.paradiseManager.bundlePATH, self.paradiseManager.containerPATH];
    [self exportListWithString:appInfo];
  }];


  UIAction *tutorialAction = [UIAction actionWithTitle:@"Show Tutorial" image:[UIImage systemImageNamed:@"questionmark.circle.fill"] identifier:nil handler:^(UIAction *action) {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTutorialNotification" object:self];
     [self dismissViewControllerAnimated:YES completion:nil];
  }];

  return [UIMenu menuWithTitle:@"App Settings" children:@[copyAction, exportAction, tutorialAction]];
}


-(void)layoutCollectionView {

  UIView *header = [[TDView alloc] init];
  header.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 155);
  header.backgroundColor = UIColor.clearColor;
  self.tableView.tableHeaderView = header;


  self.accessoriesLabel = [[UILabel alloc] init];
  if (toggleAppdataCustomFont) {
    self.accessoriesLabel.font = [UIFont fontWithDescriptor:descriptor size:16];
  } else {
    self.accessoriesLabel.font = [UIFont boldSystemFontOfSize:16];
  }
  self.accessoriesLabel.textAlignment = NSTextAlignmentLeft;
  self.accessoriesLabel.text = @"Accessories";
  self.accessoriesLabel.textColor = [UIColor appdataFontColor];
  [header addSubview:self.accessoriesLabel];

  [self.accessoriesLabel top:header.topAnchor padding:5];
  [self.accessoriesLabel leading:header.leadingAnchor padding:10];


  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = UIColor.clearColor;
  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.collectionView setShowsHorizontalScrollIndicator:NO];
  [self.collectionView setShowsVerticalScrollIndicator:NO];
  [self.collectionView registerClass:[AccessoriesCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.collectionView registerClass:[AccessoriesColourCell class] forCellWithReuseIdentifier:@"ColourCell"];
  [header addSubview:self.collectionView];

  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;

  [self.collectionView top:self.accessoriesLabel.bottomAnchor padding:5];
  [self.collectionView leading:header.leadingAnchor padding:10];
  [self.collectionView trailing:header.trailingAnchor padding:-10];
  [self.collectionView height:80];


  self.infoLabel = [[UILabel alloc] init];
  if (toggleAppdataCustomFont) {
    self.infoLabel.font = [UIFont fontWithDescriptor:descriptor size:16];
  } else {
    self.infoLabel.font = [UIFont boldSystemFontOfSize:16];
  }
  self.infoLabel.textAlignment = NSTextAlignmentLeft;
  self.infoLabel.text = [NSString stringWithFormat:@"%@ Info", self.appName];
  self.infoLabel.textColor = [UIColor appdataFontColor];
  [header addSubview:self.infoLabel];

  [self.infoLabel top:self.collectionView.bottomAnchor padding:25];
  [self.infoLabel leading:header.leadingAnchor padding:10];
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {


  if (indexPath.row == 2) {

    AccessoriesColourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColourCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.clearColor;
    cell.titleLabel.text = @"Label Colour";

    NSString *keyC = [NSString stringWithFormat:@"%@-Color", self.iconID];
    NSData *decodedData = [[TDTweakManager sharedInstance] objectForKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
    UIColor *savedColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    if (decodedData != nil) {
      cell.colourView.backgroundColor = savedColour;
    } else {
      cell.colourView.backgroundColor = UIColor.whiteColor;
    }

    return cell;

  } else if (indexPath.row == 3) {

    AccessoriesColourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColourCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.clearColor;
    cell.titleLabel.text = @"Label BG \nColour";

    NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", self.iconID];
    NSData *decodedData = [[TDTweakManager sharedInstance] objectForKey:keyBG defaultValue:nil ID:@"com.TitanD3v.ParadisePrefs"];
    UIColor *savedColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    if (decodedData) {
      cell.colourView.backgroundColor = savedColour;
    } else {
      cell.colourView.backgroundColor = UIColor.whiteColor;
    }

    return cell;

  } else {

    AccessoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    cell.backgroundColor = UIColor.clearColor;

    if (indexPath.row == 0) {

      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/icon-editor.png"];
      cell.titleLabel.text = @"Icon Editor";

    } else if (indexPath.row == 1) {

      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/rename.png"];
      cell.titleLabel.text = @"Rename";

    } else if (indexPath.row == 4) {

      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/offload.png"];
      cell.titleLabel.text = @"Offload App";

    } else if (indexPath.row == 5) {

      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/uninstall.png"];
      cell.titleLabel.text = @"Uninstall App";

    } else if (indexPath.row == 6) {

      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/uninstall.png"];
      cell.titleLabel.text = @"Uninstall \nMulti Apps";

    } else if (indexPath.row == 7) {

      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/reset.png"];
      cell.titleLabel.text = @"Reset Name";

    } else if (indexPath.row == 8) {

      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/reset.png"];
      cell.titleLabel.text = @"Reset Label \nColour";

    } else if (indexPath.row == 9) {

      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/reset.png"];
      cell.titleLabel.text = @"Reset Label \nBG Colour";

    }

    return cell;

  }

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(130, 80);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  [self invokeHapticFeedback];
  [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

  if (indexPath.row == 0) {

    [[TDTweakManager sharedInstance] setObject:self.appName forKey:@"paradiseAppName" ID:@"com.TitanD3v.ParadiseEditor"];
    [[TDTweakManager sharedInstance] setObject:self.bundleIdentifier forKey:@"paradiseBundleID" ID:@"com.TitanD3v.ParadiseEditor"];
    [[TDUtilities sharedInstance] launchApp:@"com.TitanD3v.Paradise"];

  } else if (indexPath.row == 1) {

    NSString *messageString = [NSString stringWithFormat:@"The name for %@ will be changed to entered name.", self.appName];

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Paradise" message:messageString preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
      textField.placeholder = @"Enter New Name";
    }];

    UIAlertAction* changeAction = [UIAlertAction actionWithTitle:@"Change" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
      NSString *newAppName = alert.textFields.firstObject.text;
      NSString *keyT = [NSString stringWithFormat:@"%@-Title", self.iconID];
      [[TDTweakManager sharedInstance] setObject:newAppName forKey:keyT ID:@"com.TitanD3v.ParadisePrefs"];
      self.infoLabel.text = [NSString stringWithFormat:@"%@ Info", alert.textFields.firstObject.text];
      self.appLabel.text = alert.textFields.firstObject.text;
      [iconVieww _updateLabel];
    }];

    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
    }];


    [alert addAction:changeAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

  } else if (indexPath.row == 2) {

    colourPickerIndex = 0;
    [self presentColourPickerVC];

  } else if (indexPath.row == 3) {

    colourPickerIndex = 1;
    [self presentColourPickerVC];

  } else if (indexPath.row == 4) {

    NSString *messageString = [NSString stringWithFormat:@"Are you sure you want to offload %@?", self.appName];

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Paradise" message:messageString preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *offloadAction = [UIAlertAction actionWithTitle:@"Offload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

      [NSClassFromString(@"IXAppInstallCoordinator") demoteAppToPlaceholderWithBundleID:self.bundleIdentifier forReason:1 waitForDeletion:YES completion:^{

        dispatch_async(dispatch_get_main_queue(), ^{
          [self dismissViewControllerAnimated:YES completion:nil];
        });
      }];

    }];

    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
    }];


    [alert addAction:offloadAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

  } else if (indexPath.row == 5) {

    [NSClassFromString(@"IXAppInstallCoordinator") uninstallAppWithBundleID:self.bundleIdentifier requestUserConfirmation:YES waitForDeletion:YES completion:^{

      dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
      });
    }];


  } else if (indexPath.row == 6) {

    [self presentUninstallAppsVC];

  } else if (indexPath.row == 7) { // (SGWC) need to fix label isn't showing default app name when reset

  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Paradise" message:@"Are you sure you want to reset Application name to default name?" preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction* resetAction = [UIAlertAction actionWithTitle:@"Reset" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    NSString *keyT = [NSString stringWithFormat:@"%@-Title", self.iconID];
    [[TDTweakManager sharedInstance] setObject:@"" forKey:keyT ID:@"com.TitanD3v.ParadisePrefs"];
    self.appName =  getAppName(self.iconID);
    self.infoLabel.text = [NSString stringWithFormat:@"%@ Info", self.appName];
    self.appLabel.text = self.appName;
    [iconVieww _updateLabel];
    [self.tableView reloadData];

  }];

  UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
  }];

  [alert addAction:resetAction];
  [alert addAction:cancelAction];
  [self presentViewController:alert animated:YES completion:nil];

} else if (indexPath.row == 8) { // (SGWC) here you need to reset label colour

  NSString *keyC = [NSString stringWithFormat:@"%@-Color", self.iconID];
  //[[TDTweakManager sharedInstance] setObject:@"" forKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
  [[TDTweakManager sharedInstance] removeObjectForKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
  [iconVieww _updateLabel];

  [self showAlertWithTitle:@"Paradise" message:@"Label colour has been Reset successfully"];

  NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
  AccessoriesColourCell *cell = (AccessoriesColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath2];
  cell.colourView.backgroundColor = UIColor.whiteColor;

} else if (indexPath.row == 9) { // (SGWC) here you need to reset label background colour

  NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", self.iconID];
  //[[TDTweakManager sharedInstance] setObject:@"" forKey:keyBG ID:@"com.TitanD3v.ParadisePrefs"];
  [[TDTweakManager sharedInstance] removeObjectForKey:keyBG ID:@"com.TitanD3v.ParadisePrefs"];
  [iconVieww _updateLabel];

  [self showAlertWithTitle:@"Paradise" message:@"Label background colour has been Reset successfully"];

  NSIndexPath *_indexPath3 = [NSIndexPath indexPathForItem:3 inSection:0];
  AccessoriesColourCell *cell = (AccessoriesColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath3];
  cell.colourView.backgroundColor = UIColor.whiteColor;

}

}

-(void)presentColourPickerVC {

  UIColor *previewColour;

  if (colourPickerIndex == 0) {
    NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
    AccessoriesColourCell *cell = (AccessoriesColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath2];
    previewColour = cell.colourView.backgroundColor;
  } else if (colourPickerIndex == 1) {
    NSIndexPath *_indexPath3 = [NSIndexPath indexPathForItem:3 inSection:0];
    AccessoriesColourCell *cell = (AccessoriesColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath3];
    previewColour = cell.colourView.backgroundColor;
  }

  UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
  colourPickerVC.delegate = self;
  colourPickerVC.selectedColor = previewColour;
  [self presentViewController:colourPickerVC animated:YES completion:nil];

}

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{

  UIColor *cpSelectedColour = viewController.selectedColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:cpSelectedColour];
  NSString *keyC = [NSString stringWithFormat:@"%@-Color", self.iconID];
  NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", self.iconID];

  NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
  NSIndexPath *_indexPath3 = [NSIndexPath indexPathForItem:3 inSection:0];

  if (colourPickerIndex == 0) {
    [[TDTweakManager sharedInstance] setObject:encodedData forKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
    AccessoriesColourCell *cell = (AccessoriesColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath2];
    cell.colourView.backgroundColor = cpSelectedColour;
    NSLog(@"ParadiseDebug colorPickerViewControllerDidFinish 0 :-%@", encodedData);
  } else if (colourPickerIndex == 1) {
    [[TDTweakManager sharedInstance] setObject:encodedData forKey:keyBG ID:@"com.TitanD3v.ParadisePrefs"];
    AccessoriesColourCell *cell = (AccessoriesColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath3];
    cell.colourView.backgroundColor = cpSelectedColour;
    NSLog(@"ParadiseDebug colorPickerViewControllerDidFinish 1 :-%@", encodedData);
  }

  [iconVieww _updateLabel];

}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{

  UIColor *cpSelectedColour = viewController.selectedColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:cpSelectedColour];
  NSString *keyC = [NSString stringWithFormat:@"%@-Color", self.iconID];
  NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", self.iconID];

  NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
  NSIndexPath *_indexPath3 = [NSIndexPath indexPathForItem:3 inSection:0];

  if (colourPickerIndex == 0) {
    [[TDTweakManager sharedInstance] setObject:encodedData forKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
    AccessoriesColourCell *cell = (AccessoriesColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath2];
    cell.colourView.backgroundColor = cpSelectedColour;
    NSLog(@"ParadiseDebug colorPickerViewControllerDidFinish 0 :-%@", encodedData);
  } else if (colourPickerIndex == 1) {
    [[TDTweakManager sharedInstance] setObject:encodedData forKey:keyBG ID:@"com.TitanD3v.ParadisePrefs"];
    AccessoriesColourCell *cell = (AccessoriesColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath3];
    cell.colourView.backgroundColor = cpSelectedColour;
    NSLog(@"ParadiseDebug colorPickerViewControllerDidFinish 1 :-%@", encodedData);
  }

  [iconVieww _updateLabel];

}

-(void)presentUninstallAppsVC {

  UninstallAppsViewController *uvc = [[UninstallAppsViewController alloc] init];
  uvc.modalInPresentation = YES;
  [self presentViewController:uvc animated:YES completion:nil];
}


-(void)presentSettingVC {

  [self invokeHapticFeedback];

  ParadiseSettingViewController *svc = [[ParadiseSettingViewController alloc] init];
  svc.modalInPresentation = YES;
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:svc];
  [self presentViewController:navController animated:YES completion:nil];

}


-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message {

  UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [iconVieww _updateLabel];
  }];

  [alert addAction:defaultAction];
  [self presentViewController:alert animated:YES completion:nil];

}


-(void)exportListWithString:(NSString *)info {

  NSArray *dataToShare = @[info];

  UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:dataToShare applicationActivities:nil];
  controller.excludedActivityTypes = @[UIActivityTypeAirDrop];
  [self presentViewController:controller animated:YES completion:nil];

  [controller setCompletionWithItemsHandler:^(UIActivityType _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {

  }];

}


- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {

  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
    cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
    cell.alpha = 0.5;
  } completion:nil];

}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {

  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
    cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
    cell.alpha = 1;
  } completion:nil];

}

@end
