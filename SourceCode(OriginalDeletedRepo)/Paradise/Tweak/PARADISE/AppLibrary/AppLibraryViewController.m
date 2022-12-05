#import "AppLibraryViewController.h"

static UIFontDescriptor *descriptor;
static NSInteger colourPickerIndex = 0;

@implementation AppLibraryViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  loadPrefs();

  descriptor = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIFontDescriptor class] fromData:appdataCustomFont error:nil];

  self.view.backgroundColor = UIColor.clearColor;
  [self layoutBaseView];
  [self layoutHeaderView];
  [self layoutTableView];
}

-(instancetype)initWithHash:(NSString*)imgHash imgTitle:(NSString*)imgTitle iconView:(SBIconView*)iconView{

  self.imgHash = imgHash;
  self.iconView = iconView;
  self.imgTitle = imgTitle;
  NSLog(@"ParadiseDebug initWithHash self.imgHash:-%@, iconView:-%@" ,self.imgHash, self.iconView);
  return self;

}

-(void)layoutBaseView {

  self.baseView = [[BlurBaseView alloc] init];
  self.baseView.layer.cornerRadius = bottomSheetCornerRadius;
  self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
  self.baseView.clipsToBounds = true;
  [self.view addSubview:self.baseView];

  [self.baseView x:self.view.centerXAnchor];
  [self.baseView height:MAIN_SCREEN_HEIGHT *0.40];
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


  self.iconImage = [[UIImageView alloc] init];
  self.iconImage.image = self.iconView.iconImageSnapshot;
  if(!self.iconImage.image) {
    self.iconImage.image = [[UIImage systemImageNamed:@"square.grid.2x2.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  }
  self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
  self.iconImage.layer.cornerRadius = 10;
  self.iconImage.clipsToBounds = true;
  self.iconImage.tintColor = [UIColor appdataIconColor];
  [self.headerView addSubview:self.iconImage];

  [self.iconImage size:CGSizeMake(65, 65)];
  [self.iconImage top:self.headerView.topAnchor padding:10];
  [self.iconImage x:self.headerView.centerXAnchor];


  self.titleLabel = [[UILabel alloc] init];
  if (toggleAppdataCustomFont) {
    self.titleLabel.font = [UIFont fontWithDescriptor:descriptor size:14];
  } else {
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
  }
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.text = self.imgTitle;
  self.titleLabel.textColor = [UIColor appdataFontColor];
  [self.headerView addSubview:self.titleLabel];

  [self.titleLabel top:self.iconImage.bottomAnchor padding:5];
  [self.titleLabel x:self.headerView.centerXAnchor];

}


-(void)layoutTableView {

  self.listArray = [[NSArray alloc] initWithObjects:@"Rename", @"Label Colour", @"Label Background Colour", @"Reset Name", @"Reset Label Colour", @"Reset Label Background Colour", nil];

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


  if (indexPath.row == 1) {

    ColourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"colourCell"];

    if (cell == nil) {
      cell = [[ColourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"colourCell"];
    }

    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;

    cell.backgroundColor = UIColor.clearColor;
    cell.titleLabel.text = [self.listArray objectAtIndex:indexPath.row];

    NSString *keyC = [NSString stringWithFormat:@"%@-Color", self.imgHash];
    NSData *decodedData = [[TDTweakManager sharedInstance] objectForKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
    UIColor *savedColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    if (decodedData != nil) {
      cell.colourView.backgroundColor = savedColour;
    } else {
      cell.colourView.backgroundColor = UIColor.whiteColor;
    }

    return cell;

  } else if (indexPath.row == 2) {

    ColourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"colourCell"];

    if (cell == nil) {
      cell = [[ColourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"colourCell"];
    }

    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;

    cell.backgroundColor = UIColor.clearColor;
    cell.titleLabel.text = [self.listArray objectAtIndex:indexPath.row];

    NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", self.imgHash];
    NSData *decodedData = [[TDTweakManager sharedInstance] objectForKey:keyBG ID:@"com.TitanD3v.ParadisePrefs"];
    UIColor *savedColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    if (decodedData != nil) {
      cell.colourView.backgroundColor = savedColour;
    } else {
      cell.colourView.backgroundColor = UIColor.whiteColor;
    }

    return cell;

  } else {


    LibraryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iconCell"];

    if (cell == nil) {
      cell = [[LibraryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iconCell"];
    }

    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;

    cell.backgroundColor = UIColor.clearColor;
    cell.titleLabel.text = [self.listArray objectAtIndex:indexPath.row];

    if (indexPath.row == 0) { // Rename
      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/rename.png"];
    } else if (indexPath.row == 3) { // Reset label
      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/reset.png"];
    } else if (indexPath.row == 4) { // Reset label colour
      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/reset.png"];
    } else if (indexPath.row == 5) { // Reset label background colour
      cell.accessoriesImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/reset.png"];
      cell.separatorInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, CGFLOAT_MAX);

    }

    return cell;

  }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self invokeHapticFeedback];

  if (indexPath.row == 0) { // Rename

    [self renameLabel];

  } else if (indexPath.row == 1) { // Label colour

    colourPickerIndex = 0;
    [self presentColourPickerVC];

  } else if (indexPath.row == 2) { // Label Background colour

    colourPickerIndex = 1;
    [self presentColourPickerVC];

  } else if (indexPath.row == 3) { // Reset label

    NSString *keyT = [NSString stringWithFormat:@"%@-Title", self.imgHash];
    [[TDTweakManager sharedInstance] setObject:@"" forKey:keyT ID:@"com.TitanD3v.ParadisePrefs"];
    [self showAlertWithTitle:@"Paradise" message:@"Label has been Reset successfully"];

  } else if (indexPath.row == 4) { // Reset label colour

    NSString *keyC = [NSString stringWithFormat:@"%@-Color", self.imgHash];
    [[TDTweakManager sharedInstance] removeObjectForKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
    [self.iconView _updateLabel];
    [self showAlertWithTitle:@"Paradise" message:@"Label colour has been Reset successfully"];

    NSIndexPath *_indexPath1 = [NSIndexPath indexPathForItem:1 inSection:0];
    ColourCell *cell = (ColourCell *)[self.tableView cellForRowAtIndexPath:_indexPath1];
    cell.colourView.backgroundColor = UIColor.whiteColor;

  } else if (indexPath.row == 5) { // Reset label background colour

    NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", self.imgHash];
    [[TDTweakManager sharedInstance] removeObjectForKey:keyBG ID:@"com.TitanD3v.ParadisePrefs"];
    [self.iconView _updateLabel];
    [self showAlertWithTitle:@"Paradise" message:@"Label background colour has been Reset successfully"];

    NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
    ColourCell *cell = (ColourCell *)[self.tableView cellForRowAtIndexPath:_indexPath2];
    cell.colourView.backgroundColor = UIColor.whiteColor;

  }

  [self.iconView _updateLabel];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
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


-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message {

  UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [self.iconView _updateLabel];
  }];

  [alert addAction:defaultAction];
  [self presentViewController:alert animated:YES completion:nil];

}

-(void)renameLabel{

  UIAlertController * alert = [UIAlertController  alertControllerWithTitle:@"Change Label Title"
  message:@"\nEnter New Title"
  preferredStyle:UIAlertControllerStyleAlert];

  [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"Enter New Title";
  }];

  UIAlertAction* chngButton = [UIAlertAction actionWithTitle:@"Change"
  style:UIAlertActionStyleDefault
  handler:^(UIAlertAction * action) {

    NSString *newTitle = alert.textFields.firstObject.text;
    NSString *keyT = [NSString stringWithFormat:@"%@-Title", self.imgHash];

    self.titleLabel.text = newTitle;
    [self.tableView reloadData];

    [[TDTweakManager sharedInstance] setObject:newTitle forKey:keyT ID:@"com.TitanD3v.ParadisePrefs"];
    [self.iconView _updateLabel];

  }];

  UIAlertAction* clButton = [UIAlertAction actionWithTitle:@"Cancel"
  style:UIAlertActionStyleDefault
  handler:^(UIAlertAction * action) {

    [alert dismissViewControllerAnimated:YES completion:nil];

  }];

  [alert addAction:chngButton];
  [alert addAction:clButton];
  [self presentViewController:alert animated:YES completion:nil];
}


-(void)presentColourPickerVC { // (SGWC) index == 0 for label colour, 1 for label background colour on lib only

  UIColor *previewColour;

  if (colourPickerIndex == 0) {
    NSIndexPath *_indexPath1 = [NSIndexPath indexPathForItem:1 inSection:0];
    ColourCell *cell = (ColourCell *)[self.tableView cellForRowAtIndexPath:_indexPath1];
    previewColour = cell.colourView.backgroundColor;
  } else if (colourPickerIndex == 1) {
    NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
    ColourCell *cell = (ColourCell *)[self.tableView cellForRowAtIndexPath:_indexPath2];
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
  NSString *keyC = [NSString stringWithFormat:@"%@-Color", self.imgHash];
  NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", self.imgHash];

  NSIndexPath *_indexPath1 = [NSIndexPath indexPathForItem:1 inSection:0];
  NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];

  if (colourPickerIndex == 0) {
    [[TDTweakManager sharedInstance] setObject:encodedData forKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
    ColourCell *cell = (ColourCell *)[self.tableView cellForRowAtIndexPath:_indexPath1];
    cell.colourView.backgroundColor = cpSelectedColour;
    NSLog(@"ParadiseDebug colorPickerViewControllerDidFinish 0 :-%@", encodedData);
  } else if (colourPickerIndex == 1) {
    [[TDTweakManager sharedInstance] setObject:encodedData forKey:keyBG ID:@"com.TitanD3v.ParadisePrefs"];
    ColourCell *cell = (ColourCell *)[self.tableView cellForRowAtIndexPath:_indexPath2];
    cell.colourView.backgroundColor = cpSelectedColour;
    NSLog(@"ParadiseDebug colorPickerViewControllerDidFinish 1 :-%@", encodedData);
  }

  [self.iconView _updateLabel];

}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{

  UIColor *cpSelectedColour = viewController.selectedColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:cpSelectedColour];
  NSString *keyC = [NSString stringWithFormat:@"%@-Color", self.imgHash];
  NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", self.imgHash];

  NSIndexPath *_indexPath1 = [NSIndexPath indexPathForItem:1 inSection:0];
  NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];

  if (colourPickerIndex == 0) {
    [[TDTweakManager sharedInstance] setObject:encodedData forKey:keyC ID:@"com.TitanD3v.ParadisePrefs"];
    ColourCell *cell = (ColourCell *)[self.tableView cellForRowAtIndexPath:_indexPath1];
    cell.colourView.backgroundColor = cpSelectedColour;
    NSLog(@"ParadiseDebug colorPickerViewControllerDidFinish 0 :-%@", encodedData);
  } else if (colourPickerIndex == 1) {
    [[TDTweakManager sharedInstance] setObject:encodedData forKey:keyBG ID:@"com.TitanD3v.ParadisePrefs"];
    ColourCell *cell = (ColourCell *)[self.tableView cellForRowAtIndexPath:_indexPath2];
    cell.colourView.backgroundColor = cpSelectedColour;
    NSLog(@"ParadiseDebug colorPickerViewControllerDidFinish 1 :-%@", encodedData);
  }

  [self.iconView _updateLabel];

}
@end
