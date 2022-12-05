#import "SpeedyUninstallAppsViewController.h"

@implementation SpeedyUninstallAppsViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.clipsToBounds = true;
  self.view.backgroundColor = UIColor.clearColor;

  self.baseView = [[BlurBaseView alloc] init];
  [self.view addSubview:self.baseView];
  [self.baseView fill];

  [self layoutAccessoriesView];
  [self layoutTableView];

}


-(void)layoutAccessoriesView {

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textColor = UIColor.labelColor;
  self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.text = @"All Applications";
  [self.view addSubview:self.titleLabel];

  [self.titleLabel x:self.view.centerXAnchor];
  [self.titleLabel top:self.view.topAnchor padding:20];


  self.cancelButton = [[UIButton alloc] init];
  [self.cancelButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
  [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
  [self.cancelButton setTitleColor:UIColor.systemRedColor forState:UIControlStateNormal];
  self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
  [self.view addSubview:self.cancelButton];

  [self.cancelButton size:CGSizeMake(70, 30)];
  [self.cancelButton x:self.view.centerXAnchor];
  [self.cancelButton bottom:self.view.bottomAnchor padding:-15];


  self.uninstallButton = [[UIButton alloc] init];
  [self.uninstallButton addTarget:self action:@selector(presentUninstallConfirmation) forControlEvents:UIControlEventTouchUpInside];
  [self.uninstallButton setTitle:@"Uninstall" forState:UIControlStateNormal];
  [self.uninstallButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  self.uninstallButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
  self.uninstallButton.backgroundColor = UIColor.systemBlueColor;
  self.uninstallButton.enabled = NO;
  self.uninstallButton.alpha = 0.7;
  self.uninstallButton.layer.cornerRadius = 10;
  self.uninstallButton.layer.cornerCurve = kCACornerCurveContinuous;
  [self.view addSubview:self.uninstallButton];

  [self.uninstallButton size:CGSizeMake(200, 50)];
  [self.uninstallButton x:self.view.centerXAnchor];
  [self.uninstallButton bottom:self.cancelButton.topAnchor padding:-10];

}


-(void)layoutTableView {

  self.fullAppList = [[UninstallAppList userApps] mutableCopy];
  _appsToUninstall = [NSMutableDictionary new];
  _selectedApps = [NSMutableDictionary new];


  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;
  [self.view addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;

  [self.tableView setAllowsMultipleSelection:YES];
  [self.tableView setAllowsMultipleSelectionDuringEditing:YES];

  [self.tableView top:self.titleLabel.bottomAnchor padding:10];
  [self.tableView leading:self.view.leadingAnchor padding:0];
  [self.tableView trailing:self.view.trailingAnchor padding:0];
  [self.tableView bottom:self.uninstallButton.topAnchor padding:-10];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.fullAppList count];
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  UninstallAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

  if (cell == nil) {

    cell = [[UninstallAppsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
  }

  UIView *selectionView = [UIView new];
  selectionView.backgroundColor = UIColor.clearColor;
  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];


  NSString *BID = [NSString stringWithFormat:@"%@", [[self.fullAppList objectAtIndex:indexPath.row] objectForKey:@"bundleID"]];

  cell.backgroundColor = UIColor.clearColor;

  cell.appImage.image = [UIImage _applicationIconImageForBundleIdentifier:BID format:2 scale:[UIScreen mainScreen].scale];
  cell.appnameLabel.text = [[self.fullAppList objectAtIndex:indexPath.row] objectForKey:@"name"];
  cell.appBIDLabel.text = [[self.fullAppList objectAtIndex:indexPath.row] objectForKey:@"bundleID"];


  if ([[_selectedApps valueForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] boolValue]) {

    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
  } else {
    [cell setAccessoryType:UITableViewCellAccessoryNone];
  }

  return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];

  if (thisCell.accessoryType == UITableViewCellAccessoryNone) {

    thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
    NSString *BID = [self.fullAppList objectAtIndex:indexPath.row][@"bundleID"];
    [_appsToUninstall setValue:BID forKey:BID];
    [_selectedApps setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
  }
  else if(_appsToUninstall.count !=0){
    NSString *BID = [self.fullAppList objectAtIndex:indexPath.row][@"bundleID"];
    thisCell.accessoryType = UITableViewCellAccessoryNone;
    [_appsToUninstall removeObjectForKey:BID];
    [_selectedApps setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
  }


  [self checkStatus];
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 70;
}


-(void)presentUninstallConfirmation {

  UIAlertController * alertController = [UIAlertController  alertControllerWithTitle:@"Speedy" message:@"Are you sure you want to uninstall those Applications?" preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *uninstallAction = [UIAlertAction actionWithTitle:@"Uninstall" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [self uninstallApps];
  }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {}];

  [alertController addAction:uninstallAction];
  [alertController addAction:cancelAction];
  [self presentViewController:alertController animated:YES completion:nil];

}


-(void)checkStatus {

  if (_appsToUninstall.count != 0) {
    [UIView animateWithDuration:0.2 animations:^ {
      self.uninstallButton.enabled = YES;
      self.uninstallButton.alpha = 1.0;
    }];
  } else {
    [UIView animateWithDuration:0.2 animations:^ {
      self.uninstallButton.enabled = NO;
      self.uninstallButton.alpha = 0.7;
    }];
  }

}


-(void)uninstallApps {

  __block NSString *message = [NSString stringWithFormat:@"Uninstalling apps 0/%ld", _appsToUninstall.count];
  UIAlertController * alertController = [UIAlertController  alertControllerWithTitle:@"Speedy"
  message:message
  preferredStyle:UIAlertControllerStyleAlert];

  [self presentViewController:alertController animated:YES completion:nil];

  long counts = 0;

  for (NSString *bundleIdentifier in _appsToUninstall.allKeys){
    counts++;

    [NSClassFromString(@"IXAppInstallCoordinator") uninstallAppWithBundleID:bundleIdentifier requestUserConfirmation:NO waitForDeletion:NO completion:^{
      dispatch_async(dispatch_get_main_queue(), ^{

        message = [NSString stringWithFormat:@"Uninstalling apps %ld/%ld", counts, _appsToUninstall.count];
        NSLog(@"spotiLove bundleIdentifier:-%@, message:-%@", bundleIdentifier, message);
        alertController.message = message;
        [self deleteKey:bundleIdentifier];
      });
    }];
  }


  [self refreshTable];
  [alertController dismissViewControllerAnimated:YES completion:nil];

  [UIView animateWithDuration:0.2 animations:^ {
    self.uninstallButton.enabled = NO;
    self.uninstallButton.alpha = 0.7;
  }];

}


-(void)refreshTable {
  [self.tableView reloadData];
}


-(void)deleteKey:(NSString*)key{
  for(NSMutableDictionary *appData in self.fullAppList) {
    if([appData[@"bundleID"] isEqual:key]) {
      [self.fullAppList removeObject:appData];
      [_appsToUninstall removeObjectForKey:key];
      break;
    }
  }

  if(_appsToUninstall.count == 0){
    self.navigationItem.rightBarButtonItem = nil;
  }
  [_selectedApps removeAllObjects];
  [self refreshTable];
}


-(void)dismissVC {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
