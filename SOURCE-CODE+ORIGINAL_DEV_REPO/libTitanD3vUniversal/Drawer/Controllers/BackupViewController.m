#import "BackupViewController.h"
#import "DrawerCell.h"
#import "comman.m"

NSString *TweakName;
NSMutableDictionary *backupDict;

NSString *backupPathPlist = @"/var/mobile/Library/Preferences/com.TitanD3v.LibMainBackup.plist";
NSString *prefsPathTobackup;

__attribute__((unused)) static NSMutableString *outputForShellCommand(NSString *cmd);

@implementation BackupViewController

-(void)viewDidLoad {
  [super viewDidLoad];

  NSString *tweakNameString = [[TDPrefsManager sharedInstance] getTweakName];
  NSString *bundleIDString = [[TDPrefsManager sharedInstance] getBundleID];
  NSString *prefsPathString = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleIDString];

  TweakName = tweakNameString;
  prefsPathTobackup = prefsPathString;
  backupDict = [NSMutableDictionary dictionaryWithContentsOfFile:backupPathPlist][TweakName];
  NSLog(@"zzzzzzzzzzzzzzzzzzz TweakName:-%@ backupDict:-%@", TweakName, backupDict);
  outputForShellCommand([NSString stringWithFormat:@"/bin/mkdir /Library/TitanD3v-Backup/%@", TweakName]);


  self.tintColour = [[TDAppearance sharedInstance] tintColour];
  self.view.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
  self.view.layer.maskedCorners = 12;
  self.view.layer.cornerRadius = 30;
  self.view.layer.cornerCurve = kCACornerCurveContinuous;
  self.view.clipsToBounds = true;

  [self layoutBanner];
  [self layoutTableView];

  backupDict = [NSMutableDictionary dictionaryWithContentsOfFile:backupPathPlist][TweakName];
}


-(void)layoutBanner {

  self.bannerView = [[UIView alloc] init];
  self.bannerView.clipsToBounds = true;
  [self.view addSubview:self.bannerView];

  self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.bannerView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.bannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.bannerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.bannerView.heightAnchor constraintEqualToConstant:140].active = YES;


  self.iconImage = [[UIImageView alloc] init];
  self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/backup-restore.png"];
  	self.iconImage.layer.cornerRadius = 15;
	self.iconImage.clipsToBounds = true;
  [self.bannerView addSubview:self.iconImage];

  self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.iconImage.heightAnchor constraintEqualToConstant:90].active = YES;
  [self.iconImage.widthAnchor constraintEqualToConstant:90].active = YES;
  [self.iconImage.topAnchor constraintEqualToAnchor:self.bannerView.topAnchor constant:10].active = YES;
  [[self.iconImage centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
  self.titleLabel.font = [UIFont systemFontOfSize:16];
  self.titleLabel.text = @"Backup & Restore";
  [self.bannerView addSubview:self.titleLabel];

  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
  [[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;

}


-(NSString *)dateAndTime{
  NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"HH:mm:ss dd-MM-yyyy"];
  return [dateFormatter stringFromDate:[NSDate date]];
}


-(void)layoutTableView {

  self.tableView = [[UITableView alloc] init];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.view addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;

  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.tableView.topAnchor constraintEqualToAnchor:self.bannerView.bottomAnchor constant:5].active = YES;
  [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;


  UIView *header = [[UIView alloc] init];
  header.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 110);
  header.backgroundColor = UIColor.clearColor;
  self.tableView.tableHeaderView = header;


  self.backupView = [[UIView alloc] init];
  self.backupView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  self.backupView.layer.cornerRadius = 10;
  if(@available(iOS 13.0, *)) {
    self.backupView.layer.cornerCurve = kCACornerCurveContinuous;
  }
      self.backupView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
    self.backupView.layer.borderWidth = 0.5;
  self.backupView.clipsToBounds = true;
  [header addSubview:self.backupView];

  self.backupView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.backupView.heightAnchor constraintEqualToConstant:80].active = YES;
  [self.backupView.widthAnchor constraintEqualToConstant:130].active = YES;
  [[self.backupView centerXAnchor] constraintEqualToAnchor:header.centerXAnchor constant:-75].active = true;
  [[self.backupView centerYAnchor] constraintEqualToAnchor:header.centerYAnchor].active = true;


  self.backupImage = [[UIImageView alloc] init];
  self.backupImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/backup-restore.png"];
  self.backupImage.layer.cornerRadius = 20;
  self.backupImage.clipsToBounds = true;
  [self.backupView addSubview:self.backupImage];

  self.backupImage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.backupImage.heightAnchor constraintEqualToConstant:40].active = YES;
  [self.backupImage.widthAnchor constraintEqualToConstant:40].active = YES;
  [[self.backupImage centerXAnchor] constraintEqualToAnchor:self.backupView.centerXAnchor].active = true;
  [self.backupImage.topAnchor constraintEqualToAnchor:self.backupView.topAnchor constant:10].active = YES;


  self.backupLabel = [[UILabel alloc] init];
  self.backupLabel.textAlignment = NSTextAlignmentCenter;
  self.backupLabel.font = [UIFont systemFontOfSize:12];
  self.backupLabel.text = @"Create new backup";
  self.backupLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.7];
  [self.backupView addSubview:self.backupLabel];

  self.backupLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[self.backupLabel centerXAnchor] constraintEqualToAnchor:self.backupView.centerXAnchor].active = true;
  [self.backupLabel.topAnchor constraintEqualToAnchor:self.backupImage.bottomAnchor constant:10].active = YES;


  self.resetView = [[UIView alloc] init];
  self.resetView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  self.resetView.layer.cornerRadius = 10;
  if(@available(iOS 13.0, *)) {
    self.resetView.layer.cornerCurve = kCACornerCurveContinuous;
  }
      self.resetView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
    self.resetView.layer.borderWidth = 0.5;
  self.resetView.clipsToBounds = true;
  [header addSubview:self.resetView];

  self.resetView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.resetView.heightAnchor constraintEqualToConstant:80].active = YES;
  [self.resetView.widthAnchor constraintEqualToConstant:130].active = YES;
  [[self.resetView centerXAnchor] constraintEqualToAnchor:header.centerXAnchor constant:75].active = true;
  [[self.resetView centerYAnchor] constraintEqualToAnchor:header.centerYAnchor].active = true;


  self.resetImage = [[UIImageView alloc] init];
  self.resetImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/restore.png"];
    self.resetImage.layer.cornerRadius = 20;
  self.resetImage.clipsToBounds = true;
  [self.resetView addSubview:self.resetImage];

  self.resetImage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.resetImage.heightAnchor constraintEqualToConstant:40].active = YES;
  [self.resetImage.widthAnchor constraintEqualToConstant:40].active = YES;
  [[self.resetImage centerXAnchor] constraintEqualToAnchor:self.resetView.centerXAnchor].active = true;
  [self.resetImage.topAnchor constraintEqualToAnchor:self.resetView.topAnchor constant:10].active = YES;


  self.resetLabel = [[UILabel alloc] init];
  self.resetLabel.textAlignment = NSTextAlignmentCenter;
  self.resetLabel.font = [UIFont systemFontOfSize:12];
  self.resetLabel.text = @"Reset to default";
  self.resetLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.7];
  [self.resetView addSubview:self.resetLabel];

  self.resetLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[self.resetLabel centerXAnchor] constraintEqualToAnchor:self.resetView.centerXAnchor].active = true;
  [self.resetLabel.topAnchor constraintEqualToAnchor:self.resetImage.bottomAnchor constant:10].active = YES;


  [self.backupView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(createNewBackup)]];
  [self.resetView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(resetPrefs)]];

}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  backupDict = [NSMutableDictionary dictionaryWithContentsOfFile:backupPathPlist][TweakName];
  return (long long)[backupDict count];
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  DrawerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

  if (cell == nil) {

    cell = [[DrawerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SocialCell"];
  }


  UIView *selectionView = [UIView new];
  selectionView.backgroundColor = [UIColor clearColor];
  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];

  cell.backgroundColor = UIColor.clearColor;

  backupDict = [NSMutableDictionary dictionaryWithContentsOfFile:backupPathPlist][TweakName];
  NSArray *sortedArray = [[backupDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  NSString *index = [NSString stringWithFormat:@"%@", sortedArray[indexPath.row]];

  if([backupDict[index] count] !=0){
    cell.titleLabel.text = backupDict[index][@"name"];
    cell.subtitleLabel.text = backupDict[index][@"time"];
  }

  cell.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/backup-restore.png"];

  return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 70;
}


-(void)showAlert:(NSString*)title msg:(NSString*)msg{

  invokeHapticFeedback();

  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    [[TDUtilities sharedInstance] haptic:0];
  }];
  [alertController addAction:okAction];
  alertController.view.tintColor = self.tintColour;
  [self presentViewController:alertController animated:YES completion:nil];
}

-(void)fileManager:(NSString *)mode fromPath:(NSString*)fromPath toPath:(NSString*)toPath{
  NSLog(@"zzzzzzzzzzzzzzzzzzz didSelectRowAtIndexPath mode:-%@", mode);

  if([mode isEqualToString:@"replace"]){
    NSString *cmd = [NSString stringWithFormat:@"/bin/rm %@", toPath];
    outputForShellCommand(cmd);
    cmd = [NSString stringWithFormat:@"/bin/cp %@ %@", fromPath, toPath];
    outputForShellCommand(cmd);
    NSLog(@"zzzzzzzzzzzzzzzzzzz didSelectRowAtIndexPath replace toPath:-%@, fromPath:-%@", toPath, fromPath);
  }

  if([mode isEqualToString:@"copy"]){
    NSString *cmd = [NSString stringWithFormat:@"/bin/cp %@ %@ 2>/tmp/2.txt 1>/tmp/1.txt", fromPath, toPath];
    outputForShellCommand(cmd);
    NSLog(@"zzzzzzzzzzzzzzzzzzz didSelectRowAtIndexPath copy toPath:-%@, fromPath:-%@", toPath, fromPath);
  }

  if([mode isEqualToString:@"delete"]){
    NSString *cmd = [NSString stringWithFormat:@"/bin/rm %@", fromPath];
    outputForShellCommand(cmd);
    NSLog(@"zzzzzzzzzzzzzzzzzzz didSelectRowAtIndexPath delete toPath:-%@, fromPath:-%@", toPath, fromPath);
  }
}

-(void)writeBackup:(NSString *)key value:(NSDictionary*)value{
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:backupPathPlist]];
  if (![settings objectForKey:TweakName] || [settings[TweakName] count] == 0) {
    [settings setObject:[NSMutableDictionary new] forKey:TweakName];
  }
  NSLog(@"zzzzzzzzzzzzzzzzzzz writeBackup11111 key:-%@ , value:-%@", key, value);
  [(NSMutableDictionary*)settings[TweakName] setObject:value forKey:key];
  [settings writeToFile:backupPathPlist atomically:YES];
}

-(void)deleteAndUpdate:(NSString *)key{
  NSMutableDictionary *settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:backupPathPlist]];
  [settings[TweakName] removeObjectForKey:key];
  [settings writeToFile:backupPathPlist atomically:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  invokeHapticFeedback();

  backupDict = [NSMutableDictionary dictionaryWithContentsOfFile:backupPathPlist][TweakName];
  NSArray *sortedArray = [[backupDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  NSString *index = [NSString stringWithFormat:@"%@", sortedArray[indexPath.row]];
  NSLog(@"zzzzzzzzzzzzzzzzzzz didSelectRowAtIndexPath index:-%@", index);
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Options" message:@"" preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *filzaAction = [UIAlertAction actionWithTitle:@"Open in Filza" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"filza://%@", backupDict[index][@"filePath"]]] options:@{} completionHandler:nil];
    [[TDUtilities sharedInstance] haptic:0];
  }];
  [alertController addAction:filzaAction];

  UIAlertAction *restoreAction = [UIAlertAction actionWithTitle:@"Restore Backup" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    NSString *filePath = backupDict[index][@"filePath"];
    NSLog(@"zzzzzzzzzzzzzzzzzzz Restore:-%d", [[NSFileManager defaultManager] fileExistsAtPath:filePath]);
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
      [self fileManager:@"replace" fromPath:filePath toPath:prefsPathTobackup];
      [self showAlert:TweakName msg:@"Backup restored successfuly"];
    }
    else{
      NSString *msg = [NSString stringWithFormat:@"Backup file not found for %@.\nPls delete this Backup and create new Backup", backupDict[index][@"name"]];
      [self showAlert:TweakName msg:msg];
    }
    [[TDUtilities sharedInstance] haptic:0];
  }];
  [alertController addAction:restoreAction];

  UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete Backup" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    NSString *filePath = backupDict[index][@"filePath"];
    NSLog(@"zzzzzzzzzzzzzzzzzzz deleteAction:-%@, filePath:-%@", backupDict[index][@"name"], filePath);
    [self deleteAndUpdate:backupDict[index][@"name"]];
    [self fileManager:@"delete" fromPath:filePath toPath:nil];
    [self.tableView reloadData];
    [self showAlert:TweakName msg:@"Backup deleted successfuly"];
    [[TDUtilities sharedInstance] haptic:0];
  }];
  [alertController addAction:deleteAction];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

  }];
  [alertController addAction:cancelAction];

  [self presentViewController:alertController animated:YES completion:nil];
  alertController.view.tintColor = self.tintColour;

  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)createNewBackup {

  invokeHapticFeedback();

  backupDict = [NSMutableDictionary dictionaryWithContentsOfFile:backupPathPlist][TweakName];

  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Create New Backup:" message:@"Backup Name" preferredStyle:UIAlertControllerStyleAlert];
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = @"Backup name...";
  }];

  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Create Backup" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    NSString *backupName = alertController.textFields.firstObject.text;
    if(!backupDict[backupName]){
      backupDict = [NSMutableDictionary dictionaryWithContentsOfFile:backupPathPlist][TweakName];
      NSString *backupFile = [NSString stringWithFormat:@"/Library/TitanD3v-Backup/%@/%@.plist", TweakName, backupName];
      NSDictionary *dic = @{@"name" : backupName, @"filePath" : backupFile, @"time" : [self dateAndTime]};
      NSLog(@"zzzzzzzzzzzzzzzzzzz backupName:-%@ backupFile:-%@, dic:-%@", backupName, backupFile, dic);

      if([[NSFileManager defaultManager] fileExistsAtPath:prefsPathTobackup]){
        [self writeBackup:backupName value:dic];
        [self fileManager:@"copy" fromPath:prefsPathTobackup toPath:backupFile];
        [self.tableView reloadData];
      }
      else
      [self showAlert:TweakName msg:[NSString stringWithFormat:@"Backup can not be created because %@ prefs file doesn't exists.", TweakName]];
    }
    else{
      [self showAlert:TweakName msg:[NSString stringWithFormat:@"Backup with name %@ already exists\n\nPls use another name and try again.", backupName]];
      [self createNewBackup];
    }
    [[TDUtilities sharedInstance] haptic:0];
  }];
  [alertController addAction:confirmAction];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
  }];
  [alertController addAction:cancelAction];
  alertController.view.tintColor = self.tintColour;
  [self presentViewController:alertController animated:YES completion:nil];

}

-(void)resetPrefs {

  invokeHapticFeedback();

  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Reset" message:@"Are you sure you want to reset your preference settings to default?" preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [self fileManager:@"delete" fromPath:prefsPathTobackup toPath:nil];
    [self showAlert:TweakName msg:@"Prefs reset successful"];
    [[TDUtilities sharedInstance] haptic:0];
  }];
  [alertController addAction:confirmAction];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
  }];
  [alertController addAction:cancelAction];
  alertController.view.tintColor = self.tintColour;
  [self presentViewController:alertController animated:YES completion:nil];
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

-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

@end
