#include "TDAppsCell.h"
#include "TDAppList.h"
#include "TDAppListController.h"

@interface TDAppListController ()
@property(nonatomic, retain) TDResultsTableController *resultsTableController;
@end

static UIView *selectionView;
static NSString *headerTitle;
static NSString *prefPath;


@implementation TDAppListController

- (void)viewWillAppear:(BOOL)arg1 {
  [super viewWillAppear:arg1];

  self.navigationBarColour = [[TDAppearance sharedInstance] navigationBarColour];
  self.tintColour = [[TDAppearance sharedInstance] tintColour];
  self.backgroundColour = [[TDAppearance sharedInstance] backgroundColour];
  self.labelColour = [[TDAppearance sharedInstance] labelColour];

  UIWindow *keyWindow = nil;
  NSArray *windows = [[UIApplication sharedApplication] windows];
  for (UIWindow *window in windows) {
    if (window.isKeyWindow) {
      keyWindow = window;
      break;
    }
  }

  keyWindow.tintColor = self.tintColour;


  UINavigationBar *bar = self.navigationController.navigationController.navigationBar;
  bar.barTintColor = self.navigationBarColour;
  bar.tintColor = self.tintColour;
  [[UIButton appearance]setTintColor:self.tintColour];
  self.view.tintColor = self.tintColour;


  self.view.backgroundColor = self.backgroundColour;


  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.backgroundColor = self.backgroundColour;
  [self.view addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;

  NSDictionary *properties = self.specifier.properties;
  self.preferencesSuiteName = properties[@"defaults"];
  self.preferencesKey = properties[@"key"];
  self.postNotification = properties[@"postNotification"];
  self.isLimitApps = [properties[@"limitApps"] boolValue];
  self.appsCapacity = [properties[@"appsCapacity"] intValue];

  NSString *appList = [properties[@"appList"] lowercaseString];
  if ([appList isEqualToString:@"allapps"]) {
    headerTitle = @"All Applications";
    self.fullAppList = [TDAppList.allApps copy];
  } else if ([appList isEqualToString:@"userapps"]) {
    headerTitle = @"All User Apps";
    self.fullAppList = [TDAppList.userApps copy];
  } else if ([appList isEqualToString:@"systemapps"]) {
    headerTitle = @"All System Apps";
    self.fullAppList = [TDAppList.systemApps copy];
  } else if ([appList isEqualToString:@"audioapps"]) {
    headerTitle = @"All Audio Apps";
    self.fullAppList = [TDAppList.audioApps copy];
  }

  self.appList = self.fullAppList;

  // if (!([self.preferencesSuiteName length] == 0 || [self.preferencesKey length] == 0)) {
  //     NSUserDefaults *preferences = [[NSUserDefaults alloc]
  //         initWithSuiteName:self.preferencesSuiteName];
  //     self.selectedApps =
  //         [[preferences objectForKey:self.preferencesKey] mutableCopy];
  // } else {
  //     [self errorAlert];
  // }

  prefPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", self.preferencesSuiteName];
  NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:prefPath];
  NSArray *apps;

  if ([[NSFileManager defaultManager] fileExistsAtPath:prefPath]) {
    apps = prefs[self.preferencesKey];
  } else {
    apps = @[];
  }

  self.preferencesAppList = apps;
}


- (void)viewDidLoad {
  [super viewDidLoad];

  self.resultsTableController = [TDResultsTableController new];
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
  self.searchController.searchResultsUpdater = self;
  self.searchController.delegate = self;
  self.searchController.searchBar.delegate = self;
  self.searchController.hidesNavigationBarDuringPresentation = false;
  self.searchController.searchBar.searchBarStyle = UISearchBarStyleProminent;
  self.searchController.searchBar.placeholder = @"App";
  self.searchController.searchBar.tintColor = UIColor.whiteColor;
  self.searchController.searchBar.barTintColor =[UIColor colorWithRed:53.0 / 255.0 green:59.0 / 255.0 blue:68.0 / 255.0 alpha:1.0];
  self.searchController.hidesNavigationBarDuringPresentation = true;
  self.searchController.searchBar.keyboardAppearance = UIKeyboardAppearanceDark;

  [[UITextField appearanceWhenContainedInInstancesOfClasses:@ [[UISearchBar class]]] setTintColor:UIColor.blackColor];
  self.searchController.view.backgroundColor = [UIColor colorWithRed:53 / 255.0 green:59 / 255.0 blue:68.0 / 255.0 alpha:0.75];
  self.definesPresentationContext = YES;

  self.resultsTableController.searchResult = [[NSMutableArray alloc] init];

  // UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]
  //     initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
  //                          target:self
  //                          action:@selector(toggleSearch)];

  UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleAll)];

  self.navigationItem.rightBarButtonItems = @[actionButton];
}


-(int)getDisAppCnt{
  NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:prefPath];
  return [prefs[self.preferencesKey] count];
}


-(void)toggleAll{

  [[TDUtilities sharedInstance] haptic:0];

  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"App List" message:@"Enable or disable all apps" preferredStyle:UIAlertControllerStyleAlert];

  [alert addAction:[UIAlertAction actionWithTitle:@"Select All" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

    [[TDUtilities sharedInstance] haptic:0];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    //int i = [self getDisAppCnt];
    int i = 0;
    NSLog(@"aaaaaa iiiiiiiiiiii:-%d,", i);
    for(; i < self.fullAppList.count; i++){
      // int maxApps = i + [self getDisAppCnt];
      NSLog(@"aaaaaa isLimitApps:-%d, appsCapacity:-%ld", self.isLimitApps, (long)self.appsCapacity);

      if(self.isLimitApps && i  > self.appsCapacity-1){
        NSString *msg = [NSString stringWithFormat:@"You can't enable more than %ld apps", (long)self.appsCapacity];

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:msg preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];

        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];

        NSLog(@"aaaaaa [list count]:-%ld,", [list count]);
        if([list count] ==0)
        return;
        self.preferencesAppList = [list copy];
        [self updatePreferencesAppList];
        [self.tableView reloadData];
        return;
      }
      [list addObject:self.fullAppList[i][@"bundleID"]];
    }
    self.preferencesAppList = [list copy];
    [self updatePreferencesAppList];
    [self.tableView reloadData];
  }]];


  [alert addAction:[UIAlertAction actionWithTitle:@"Unselect All" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    self.preferencesAppList = @[];
    [self updatePreferencesAppList];
    [self.tableView reloadData];
    [[TDUtilities sharedInstance] haptic:0];
  }]];


  [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [alert dismissViewControllerAnimated:YES completion:nil];
  }]];

  [self presentViewController:alert animated:YES completion:nil];
}


- (void)toggleSearch {
  if (self.searchController.active) {
    self.searchController.active = NO;
  } else {
    self.searchController.active = YES;
  }
}


- (void)errorAlert {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error loading prefs" message:@"Oh no! Something went wrong!" preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
  }];

  [alert addAction:okAction];
  [self presentViewController:alert animated:YES completion:nil];
}


static void writeToPlist(NSString *key, NSArray *value){
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  NSLog(@"aaaaaa writeToPlist value:-%@", value);

  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
  if (![settings objectForKey:key]) {
    [settings setObject:[NSMutableDictionary new] forKey:key];
  }
  [settings setObject:value forKey:key];
  [settings writeToFile:prefPath atomically:YES];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.fullAppList count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 35.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

  UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width -10, 120.0)];
  sectionHeaderView.backgroundColor = UIColor.clearColor;
  sectionHeaderView.clipsToBounds = true;

  UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  headerLabel.backgroundColor = [UIColor clearColor];
  headerLabel.textColor = self.labelColour;

  headerLabel.textAlignment = NSTextAlignmentLeft;
  headerLabel.font = [UIFont boldSystemFontOfSize:26];
  [sectionHeaderView addSubview:headerLabel];

  headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[headerLabel centerYAnchor] constraintEqualToAnchor:sectionHeaderView.centerYAnchor].active = true;
  [headerLabel.leadingAnchor constraintEqualToAnchor:sectionHeaderView.leadingAnchor constant:15].active = YES;

  switch (section) {
    case 0:
    headerLabel.text = headerTitle;
    return sectionHeaderView;
    break;
    default:
    break;
  }

  return sectionHeaderView;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  TDAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

  if (cell == nil) {

    cell = [[TDAppsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
  }

  selectionView = [UIView new];
  selectionView.backgroundColor = UIColor.clearColor;

  UISwitch *appSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
  appSwitch.onTintColor = self.tintColour;
  appSwitch.tag = [[NSString stringWithFormat:@"%ld%ld", (long)indexPath.section + 1, (long)indexPath.row] intValue];
  [appSwitch addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventPrimaryActionTriggered];
  [cell setAccessoryView:appSwitch];

  if ([self.preferencesAppList containsObject:[[self.fullAppList objectAtIndex:indexPath.row] objectForKey:@"bundleID"]]) {
    [appSwitch setOn:YES animated:NO];
  }

  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
  cell.backgroundColor = UIColor.clearColor;
  cell.appImage.image = [UIImage _applicationIconImageForBundleIdentifier:[[self.fullAppList objectAtIndex:indexPath.row] objectForKey:@"bundleID"] format:2 scale:[UIScreen mainScreen].scale];
  cell.appnameLabel.text = [[self.fullAppList objectAtIndex:indexPath.row] objectForKey:@"name"];
  cell.appBIDLabel.text = [[self.fullAppList objectAtIndex:indexPath.row] objectForKey:@"bundleID"];
  return cell;
}


- (void)updatePreferencesAppList {
  writeToPlist(self.preferencesKey, self.preferencesAppList);
  if (self.postNotification) {
    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterPostNotification(
      r, (CFStringRef)self.postNotification, NULL, NULL, true);
    }
  }

  - (void)updateSwitch:(UISwitch *)appSwitch {
    NSString *tag = [NSString stringWithFormat:@"%ld", (long)appSwitch.tag];
    NSInteger section = [[tag substringToIndex:1] intValue] - 1;
    NSInteger row = [[tag substringFromIndex:1] intValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    BOOL on = [(UISwitch *)cell.accessoryView isOn];
    int maxApps = [self getDisAppCnt];

    // [(UISwitch *)cell.accessoryView setOn:NO animated:NO];

    NSLog(@"aaaaaa isLimitApps:-%d, maxApps:-%ld appsCapacity:-%ld", self.isLimitApps, (long)maxApps, (long)self.appsCapacity);
    NSLog(@"aaaaaaaa maxApps:-%ld, on:-%d", (long)maxApps, on);
    if(self.isLimitApps && maxApps >= self.appsCapacity && on){
      NSString *msg = [NSString stringWithFormat:@"You can't disable more than %ld apps", (long)self.appsCapacity];

      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Can't Enable" message:msg preferredStyle:UIAlertControllerStyleAlert];

      UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [(UISwitch *)cell.accessoryView setOn:NO animated:NO];
      }];

      [alert addAction:okAction];
      [self presentViewController:alert animated:YES completion:nil];

    } else{

      NSString *bundleIdentifier = [[self.fullAppList objectAtIndex:indexPath.row] objectForKey:@"bundleID"];

      NSMutableArray *list = [[NSMutableArray alloc] init];

      if(self.preferencesAppList)
      list = [self.preferencesAppList mutableCopy];

      if (!on) {
        [list removeObject:bundleIdentifier];
      } else {
        [list addObject:bundleIdentifier];
      }

      NSLog(@"aaaaaa updateSwitch bundleIdentifier:-%@, list:-%@", bundleIdentifier, list);

      self.preferencesAppList = [list mutableCopy];
      NSLog(@"aaaaaa updateSwitch preferencesAppList:-%@", self.preferencesAppList);

      [self updatePreferencesAppList];
    }
  }


  - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
  }


  -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  }


  -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
  }


  - (void)searchWithText:(NSString *)text {

    if (text.length == 0) {
      self.fullAppList = self.appList;
      [self.resultsTableController.searchTable reloadData];

    } else {
      NSMutableArray *mutableList = [[NSMutableArray alloc] init];
      int count = 0;
      for(NSDictionary *data in self.appList){
        NSString *appName = data[@"name"];
        if ([appName.lowercaseString rangeOfString:text.lowercaseString].location != NSNotFound) {
          [mutableList addObject:data];
          count++;
        }
      }
      self.fullAppList = [mutableList copy];
      self.resultsTableController.searchResult = [mutableList copy];
    }

    [self.resultsTableController.searchTable reloadData];
  }


  - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)text {
    [self searchWithText:text];
  }


  - (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
  }


  - (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self searchWithText:searchBar.text];
  }


  - (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar setText:@""];
    self.resultsTableController.searchEnabled = NO;
    [self.resultsTableController.searchTable reloadData];
  }


  - (void)presentSearchController:(UISearchController *)searchController {
    [self presentViewController:self.searchController animated:YES completion:nil];
    self.resultsTableController.searchTable.delegate = self;
    self.resultsTableController.searchTable.dataSource = self;
    self.resultsTableController.searchTable.tableFooterView = [UIView new];
    self.resultsTableController.searchTable.separatorInset =
    UIEdgeInsetsMake(0, 10, 0, 10);
    self.resultsTableController.searchTable.separatorColor = UIColor.whiteColor;
  }


  - (void)updateSearchResultsForSearchController:
  (UISearchController *)searchController {
  }

  @end
