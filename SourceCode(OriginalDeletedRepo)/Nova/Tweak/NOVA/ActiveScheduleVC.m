#import "ActiveScheduleVC.h"
#import "ScheduleManager.h"

NSMutableArray *todaysSchedules;
NSMutableArray *futureSchedules;
NSMutableArray *sentSchedules;
NSTimer *tableRefresher;
ScheduleManager *sharedInstance;

@implementation ActiveScheduleVC

- (void)viewDidLoad {
  [super viewDidLoad];


  loadPrefs();

  self.view.backgroundColor = [UIColor backgroundColour];

  if (toggleWallpaper) {
      UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
      backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
      backgroundImage.image = [UIImage imageWithData:wallpaperImage];
      [self.view addSubview:backgroundImage];
  }

  self.title = @"Schedule Messages";

  if (toggleCustomColour) {
    self.navigationController.navigationBar.barTintColor = [[TDTweakManager sharedInstance] colourForKey:@"navbarColour" defaultValue:@"FFFFFF" ID:BID];
  }
  self.navigationController.navigationBar.tintColor = [UIColor accentColour];
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor fontColour]}];

  UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createSchedule)];
  self.navigationItem.rightBarButtonItem = createButton;

  UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"gear"] style:UIBarButtonItemStylePlain target:self action:@selector(presentSettingVC)];
  self.navigationItem.leftBarButtonItem = settingButton;

  [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.Nova/ActiveScheduleVCReload" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
      [self reloadTableData];
    });
  }];

  tableRefresher = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(reloadTableData) userInfo:nil repeats:YES];

  todaysSchedules = [NSMutableArray new];
  [self loadSchedules];
  [self layoutTableView];
}


-(void)loadSchedules{
  sharedInstance  = [[ScheduleManager sharedInstance] init];
  todaysSchedules = [sharedInstance getTodaysSchedules];
  futureSchedules = [sharedInstance getFutureSchedules];
  sentSchedules   = [sharedInstance getSentSchedules];
}

-(void)reloadTableData{
  [self loadSchedules];
  [self.tableView reloadData];
}

-(void)layoutTableView {

  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.view addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  if (section == 0) { // Today
    return [todaysSchedules count];
  } else if (section == 1) { // Future
    return [futureSchedules count];
  } else { // Sent
    return [sentSchedules count];
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
  headerLabel.textColor = [UIColor fontColour];
  headerLabel.textAlignment = NSTextAlignmentLeft;
  headerLabel.font = [UIFont boldSystemFontOfSize:16];
  [sectionHeaderView addSubview:headerLabel];

  if (section == 0) {
    headerLabel.text = @"Today";
  } else if (section == 1) {
    headerLabel.text = @"Future";
  } else {
    headerLabel.text = @"Sent";
  }

  return sectionHeaderView;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  ActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

  if (cell == nil) {

    cell = [[ActiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  }


  UIView *selectionView = [UIView new];
  selectionView.backgroundColor = UIColor.clearColor;
  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
  cell.backgroundColor = UIColor.clearColor;

  if (indexPath.section == 0) { // Today

    cell.iconImage.image = [[UIImage systemImageNamed:@"clock.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.iconImage.tintColor = [UIColor clockColour];
    cell.remainingView.backgroundColor = [UIColor remainingBackgroundColour];

    NSString *remainingLabel = [sharedInstance getTimeLeft:todaysSchedules[indexPath.row][@"scheduleLabel"]];

    cell.avatarImage.image = [UIImage imageWithContentsOfFile:todaysSchedules[indexPath.row][@"avatarImage"]];
    cell.remainingLabel.text = remainingLabel;
    cell.recipientLabel.text = todaysSchedules[indexPath.row][@"recipientLabel"];
    cell.messageLabel.text = todaysSchedules[indexPath.row][@"messageLabel"];
    cell.scheduleLabel.text = [sharedInstance dateToStr:todaysSchedules[indexPath.row][@"scheduleLabel"]];

  } else if (indexPath.section == 1) { // Future

    cell.iconImage.image = [[UIImage systemImageNamed:@"clock.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.iconImage.tintColor = [UIColor clockColour];
    cell.remainingView.backgroundColor = [UIColor remainingBackgroundColour];

    NSString *remainingLabel = [sharedInstance getTimeLeft:futureSchedules[indexPath.row][@"scheduleLabel"]];

    cell.avatarImage.image = [UIImage imageWithContentsOfFile:futureSchedules[indexPath.row][@"avatarImage"]];
    cell.remainingLabel.text = remainingLabel;
    cell.recipientLabel.text = futureSchedules[indexPath.row][@"recipientLabel"];
    cell.messageLabel.text = futureSchedules[indexPath.row][@"messageLabel"];
    cell.scheduleLabel.text = [sharedInstance dateToStr:futureSchedules[indexPath.row][@"scheduleLabel"]];


  } else if (indexPath.section == 2) { // Sent

    cell.iconImage.image = [[UIImage systemImageNamed:@"checkmark.circle.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.iconImage.tintColor = [UIColor checkmarkColour];
    cell.remainingView.backgroundColor = [UIColor sentBackgroundColour];
    cell.remainingLabel.text = @"SENT";

    cell.avatarImage.image = [UIImage imageWithContentsOfFile:sentSchedules[indexPath.row][@"avatarImage"]];
    cell.recipientLabel.text = sentSchedules[indexPath.row][@"recipientLabel"];
    cell.messageLabel.text = sentSchedules[indexPath.row][@"messageLabel"];
    cell.scheduleLabel.text = [sharedInstance dateToStr:sentSchedules[indexPath.row][@"scheduleLabel"]];

  }

  return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 200;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {

  }
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {

  UIContextualAction *clearAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) { // Today
      [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/deleteScheduleWithId" object:nil userInfo:@{@"withID" : todaysSchedules[indexPath.row][@"id"]} deliverImmediately:YES];
    } else if (indexPath.section == 1) { // Future
      [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/deleteScheduleWithId" object:nil userInfo:@{@"withID" : futureSchedules[indexPath.row][@"id"]} deliverImmediately:YES];
    } else if (indexPath.section == 2) { // Sent
      [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/deleteScheduleWithId" object:nil userInfo:@{@"withID" : sentSchedules[indexPath.row][@"id"]} deliverImmediately:YES];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
      [self reloadTableData];
    });

  }];

  UIImage *transparentImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Nova.bundle/Assets/transparent.png"];
  UIImage *trashImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Nova.bundle/Assets/trash.png"];
  CGSize sacleSize = CGSizeMake(50, 50);
  UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
  [trashImage drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
  UIImage * resizedTrashImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  clearAction.image = resizedTrashImage;
  clearAction.backgroundColor = [UIColor colorWithPatternImage:transparentImage];


  UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:@[clearAction]];

  return configuration;

}


-(void)createSchedule {

[self invokeHapticFeedback];

  CreateScheduleVC *nvc = [[CreateScheduleVC alloc] init];
  [self.navigationController pushViewController:nvc animated:YES];

}

-(void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [tableRefresher invalidate];
  tableRefresher = nil;
}


-(void)presentSettingVC {

  [self invokeHapticFeedback];

  [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/PresentSetting" object:nil userInfo:nil deliverImmediately:YES];

	// SettingViewController *svc = [[SettingViewController alloc] init];
  // svc.modalInPresentation = YES;
  // UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:svc];
	// [self presentViewController:navController animated:YES completion:nil];
  
}


-(void)invokeHapticFeedback {
    if (toggleHaptic) {
    if (hapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (hapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (hapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }
  }
}

@end
