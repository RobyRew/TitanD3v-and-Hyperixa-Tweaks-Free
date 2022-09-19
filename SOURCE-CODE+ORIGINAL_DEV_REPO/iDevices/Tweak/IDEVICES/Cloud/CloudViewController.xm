#import "CloudViewController.h"

// static MBManagerClient *mbManagerClient;
// static MBStateInfo *mbSInfo;

@implementation CloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loadPrefs();
   
    self.view.backgroundColor = [UIColor backgroundColour];
    
    UIWindow *keyWindow = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }

    keyWindow.tintColor = [UIColor accentColour];
    self.view.tintColor = [UIColor accentColour];

    self.icloudTimer = nil;
    
    [self layoutViews];
    [self layoutHeaderView];
    [self checkStatus];
}


-(void)layoutHeaderView {
    
    self.headerView = [[CDHeaderView alloc] initWithTitle:@"iCloud" accent:[UIColor accentColour] leftIcon:@"chevron.left" leftAction:@selector(pushBackVC)];
    self.headerView.leftButton.backgroundColor = [UIColor.navBarButtonColour colorWithAlphaComponent:0.5];
    self.headerView.titleLabel.textColor = UIColor.coverTitleColour;
    [self.view addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 75)];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.topAnchor padding:0];
}


-(void)layoutViews {
    
    self.containerView = [[UIView alloc] init];
    self.containerView.layer.cornerRadius = 25;
    self.containerView.layer.cornerCurve = kCACornerCurveContinuous;
    self.containerView.layer.maskedCorners = 12;
    self.containerView.clipsToBounds = YES;
    [self.view addSubview:self.containerView];
    
    [self.containerView size:CGSizeMake(self.view.frame.size.width, 380)];
    [self.containerView x:self.view.centerXAnchor];
    [self.containerView top:self.view.topAnchor padding:0];


    UIImageView *wallpaper = [[UIImageView alloc] init];
    if (toggleCustomCoverImage) {
    wallpaper.image = [UIImage imageWithData:customCoverImage];
    } else {
    wallpaper.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/iDevices.bundle/Assets/Default/cover-image.png"];
    }
    wallpaper.contentMode = UIViewContentModeScaleAspectFill;
    [self.containerView addSubview:wallpaper];
    
    [wallpaper fill];


    self.backupProgressView = [[DeviceUsageView alloc] initWithFrame:CGRectZero];
    self.backupProgressView.backgroundColor = UIColor.clearColor;
    self.backupProgressView.progressColor = UIColor.backupProgressColour;
    self.backupProgressView.progressStrokeColor = UIColor.backupProgressColour;
    self.backupProgressView.emptyLineStrokeColor = UIColor.clearColor;
    self.backupProgressView.emptyLineColor = [UIColor.backupProgressColour colorWithAlphaComponent:0.4];
    self.backupProgressView.fontColor = UIColor.clearColor;
    self.backupProgressView.progressLineWidth = 14;
    self.backupProgressView.valueFontSize = 10;
    self.backupProgressView.unitFontSize = 8;
    self.backupProgressView.emptyLineWidth = 14;
    self.backupProgressView.emptyCapType = kCGLineCapRound;
    self.backupProgressView.progressAngle = 100;
    self.backupProgressView.progressRotationAngle = 50;
    self.backupProgressView.alpha = 0;
    [self.containerView addSubview:self.backupProgressView];
    
    [self.backupProgressView size:CGSizeMake(210, 210)];
    [self.backupProgressView x:self.containerView.centerXAnchor];
    [self.backupProgressView y:self.containerView.centerYAnchor padding:15];
    

    self.cloudButton = [[CloudButton alloc] initWithAction:@selector(prepareBackUp)];
    self.cloudButton.layer.cornerRadius = 80;
    [self.containerView addSubview:self.cloudButton];
    
    [self.cloudButton size:CGSizeMake(160, 160)];
    [self.cloudButton x:self.containerView.centerXAnchor];
    [self.cloudButton y:self.containerView.centerYAnchor padding:15];

    
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.textColor = [UIColor.coverTitleColour colorWithAlphaComponent:0.6];
    self.statusLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.statusLabel.text = @"Back up in progress";
    self.statusLabel.alpha = 0;
    [self.containerView addSubview:self.statusLabel];
    
    [self.statusLabel x:self.containerView.centerXAnchor];
    [self.statusLabel bottom:self.containerView.bottomAnchor padding:-20];
    
    
    self.toggleView = [[MemoryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"switch.2"]];
    self.toggleView.title.text = @"Enable/Disable";
    self.toggleView.subtitle.text = @"iCloud back up";
    self.toggleView.iconView.backgroundColor = [UIColor.tealColour colorWithAlphaComponent:0.4];
    self.toggleView.icon.tintColor = UIColor.tealColour;
    [self.view addSubview:self.toggleView];
    
    [self.toggleView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.toggleView x:self.view.centerXAnchor];
    [self.toggleView top:self.containerView.bottomAnchor padding:20];
    

    MBManagerClient *mbManagerClient = [[%c(MBManager) alloc] init];
    BOOL isBackupEnabled = [mbManagerClient isBackupEnabled];
    self.toggleSwitch = [[UISwitch alloc] init];
    self.toggleSwitch.thumbTintColor = UIColor.secondarySystemBackgroundColor;
    [self.toggleSwitch addTarget:self action:@selector(toggleBackup:) forControlEvents:UIControlEventValueChanged];
    [self.toggleSwitch setOn:isBackupEnabled animated:NO];
    self.toggleSwitch.onTintColor = UIColor.tealColour;
    [self.toggleView addSubview:self.toggleSwitch];
    
    [self.toggleSwitch y:self.toggleView.centerYAnchor];
    [self.toggleSwitch trailing:self.toggleView.trailingAnchor padding:-10];

    
    self.dateView = [[MemoryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"calendar"]];
    self.dateView.title.text = @"Last Backup";
    self.dateView.subtitle.text = [[DataManager sharedInstance] lastiCloudBackUpDate];
    self.dateView.iconView.backgroundColor = [UIColor.redColour colorWithAlphaComponent:0.4];
    self.dateView.icon.tintColor = UIColor.redColour;
    [self.view addSubview:self.dateView];
    
    [self.dateView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.dateView x:self.view.centerXAnchor];
    [self.dateView top:self.toggleView.bottomAnchor padding:10];

   //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateStatus) userInfo:nil repeats:YES];
    
}


-(void)checkStatus {

   MBManagerClient *mbManagerClient = [[%c(MBManager) alloc] init];
   MBStateInfo *mbSInfo = [mbManagerClient backupState];

    bool isBackupEnabled = [mbManagerClient isBackupEnabled];
    int state = mbSInfo.state;


   if(isBackupEnabled && state != 2) {

    self.cloudButton.title.text = @"Start\nBackup";
    self.cloudButton.backgroundColor = UIColor.backupStartButtonColour;
    [UIView animateWithDuration:0.1 animations:^{
    self.statusLabel.alpha = 0;
    self.backupProgressView.alpha = 0;
    }];

    self.icloudTimer = nil;
    [self.icloudTimer invalidate];
   }


if(!isBackupEnabled) {

    self.cloudButton.title.text = @"Start\nBackup";
    self.cloudButton.backgroundColor = UIColor.backupStartButtonColour;
    [UIView animateWithDuration:0.1 animations:^{
    self.statusLabel.alpha = 0;
    self.backupProgressView.alpha = 0;
    }];

    self.icloudTimer = nil;
    [self.icloudTimer invalidate];
   }


  if (state == 2) {

    self.cloudButton.title.text = @"Cancel\nBackup";
    self.cloudButton.backgroundColor = UIColor.backupCancelButtonColour;
    [UIView animateWithDuration:0.1 animations:^{
    self.statusLabel.alpha = 1;
    self.backupProgressView.alpha = 1;
    }];

   if (!self.icloudTimer) {
   self.icloudTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateStatus) userInfo:nil repeats:YES];
   }

  }


  self.dateView.subtitle.text = [[DataManager sharedInstance] lastiCloudBackUpDate];


}


-(void)prepareBackUp {

   MBManagerClient *mbManagerClient = [[%c(MBManager) alloc] init];
   MBStateInfo *mbSInfo = [mbManagerClient backupState];

    bool isBackupEnabled = [mbManagerClient isBackupEnabled];
    int state = mbSInfo.state;
    NSError *error = nil;

   if(isBackupEnabled && state != 2) {
   [mbManagerClient startBackupWithError:&error];
   }


  if (state == 2) {
  [mbManagerClient cancel];
  }


  if (!isBackupEnabled) {
      [self showAlertWithTitle:@"Sorry!" subtitle:@"Your iCloud backup is disabled, please enable iCloud backup if you wish to backup."];
  }

 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
  [self checkStatus];
 });
    
}


-(void)updateStatus {

   MBManagerClient *mbManagerClient = [[%c(MBManager) alloc] init];
   MBStateInfo *mbSInfo = [mbManagerClient backupState];

  bool isBackupEnabled = [mbManagerClient isBackupEnabled];
  int state = mbSInfo.state;
   float progress = mbSInfo.progress;

//self.statusLabel.text = [NSString stringWithFormat:@"%f", progress];

if (state == 2) {

    [UIView animateWithDuration:0.1 animations:^{
 
        self.backupProgressView.value = progress;
        self.backupProgressView.maxValue = 1.000000;
    }];

}


if(isBackupEnabled && state != 2) {

self.icloudTimer = nil;
[self.icloudTimer invalidate];
[UIView animateWithDuration:0.1 animations:^{
self.backupProgressView.alpha = 0;
}];

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
  [self checkStatus];
 });

}


}





-(void)toggleBackup:(UISwitch *)sender {
    MBManagerClient *mbManagerClient = [[%c(MBManager) alloc] init];
    [mbManagerClient setBackupEnabled:sender.on];

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
  [self checkStatus];
 });

}


-(void)pushBackVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
