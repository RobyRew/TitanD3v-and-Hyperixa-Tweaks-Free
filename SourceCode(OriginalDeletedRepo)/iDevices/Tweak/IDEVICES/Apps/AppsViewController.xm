#import "AppsViewController.h"
#import <AppList/AppList.h>

NSMutableDictionary *appsDict;

@implementation AppsViewController

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

    appsDict = [[NSMutableDictionary alloc] init];
    [self getSystemApps];

    
    [self layoutHeaderView];
    [self layoutCollectionView];
}


-(void)layoutHeaderView {
    
    self.containerView = [[UIView alloc] init];
    self.containerView.layer.cornerRadius = 25;
    self.containerView.layer.cornerCurve = kCACornerCurveContinuous;
    self.containerView.layer.maskedCorners = 12;
    self.containerView.clipsToBounds = YES;
    [self.view addSubview:self.containerView];
    
    [self.containerView size:CGSizeMake(self.view.frame.size.width, 200)];
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
    
    
    self.headerView = [[CDHeaderView alloc] initWithTitle:@"" accent:[UIColor accentColour] leftIcon:@"chevron.left" leftAction:@selector(pushBackVC)];
    self.headerView.leftButton.backgroundColor = [UIColor.navBarButtonColour colorWithAlphaComponent:0.5];
    [self.containerView addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 75)];
    [self.headerView x:self.containerView.centerXAnchor];
    [self.headerView top:self.containerView.topAnchor padding:0];
    
    
    self.headerIcon = [[UIImageView alloc] init];
    self.headerIcon.contentMode = UIViewContentModeScaleAspectFit;
    self.headerIcon.image = [UIImage systemImageNamed:@"apps.iphone"];
    self.headerIcon.tintColor = UIColor.coverIconColour;
    [self.containerView addSubview:self.headerIcon];
    
    [self.headerIcon size:CGSizeMake(75, 75)];
    [self.headerIcon x:self.containerView.centerXAnchor];
    [self.headerIcon top:self.headerView.bottomAnchor padding:-10];
    
    
    self.headerTitle = [[UILabel alloc] init];
    self.headerTitle.textAlignment = NSTextAlignmentCenter;
    self.headerTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    self.headerTitle.textColor = UIColor.coverTitleColour;
    self.headerTitle.text = @"Apps";
    [self.containerView addSubview:self.headerTitle];
    
    [self.headerTitle x:self.containerView.centerXAnchor];
    [self.headerTitle top:self.headerIcon.bottomAnchor padding:10];

}


-(void)layoutCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[AppCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView top:self.containerView.bottomAnchor padding:5];
    [self.collectionView leading:self.view.leadingAnchor padding:0];
    [self.collectionView trailing:self.view.trailingAnchor padding:0];
    [self.collectionView bottom:self.view.bottomAnchor padding:-5];
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [appsDict count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    AppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;

    NSArray *arrayList = [appsDict allKeys];
    arrayList = [arrayList sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableDictionary *appData = appsDict[arrayList[indexPath.row]];

    NSString *openedString = [[TDTweakManager sharedInstance] objectForKey:appData[@"appId"] defaultValue:@"N/A" ID:BID];
    
    cell.titleLabel.text = appData[@"appName"];
    if ([openedString isEqualToString:@"N/A"]) {
    cell.subtitleLabel.text = @"You haven't opened this app yet.";
    } else {
    cell.subtitleLabel.text = [NSString stringWithFormat:@"Last opened on %@", openedString];
    }
    cell.iconImage.image = [UIImage _applicationIconImageForBundleIdentifier:appData[@"appId"] format:2 scale:[UIScreen mainScreen].scale];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width  = self.view.frame.size.width-40;
    return CGSizeMake(width, 65);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 20.0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,20,0,20);
}


-(void)pushBackVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)getSystemApps {

  NSDictionary *apps = [[ALApplicationList sharedApplicationList] applications];
  NSArray *blacklist = [NSArray arrayWithObjects:@"com.apple.Magnifier",
  @"com.apple.InCallService",
  @"com.apple.RemoteiCloudQuotaUI",
  @"com.apple.PublicHealthRemoteUI",
  @"com.apple.CarPlaySplashScreen",
  @"com.apple.iMessageAppsViewService",
  @"com.apple.BarcodeScanner",
  @"com.apple.HealthENLauncher",
  @"com.apple.AXUIViewService",
  @"com.apple.AppSSOUIService",
  @"com.apple.CarPlaySettings",
  @"com.apple.mobilesms.compose",
  @"com.apple.BusinessChatViewService",
  @"com.apple.DiagnosticsService",
  @"com.apple.CTNotifyUIService",
  @"com.apple.HealthPrivacyService",
  @"com.apple.WebContentFilter.remoteUI.WebContentAnalysisUI",
  @"com.apple.ScreenshotServicesService",
  @"com.apple.FTMInternal",
  @"com.apple.carkit.DNDBuddy",
  @"com.apple.PreBoard",
  @"com.apple.datadetectors.DDActionsService",
  @"com.apple.DemoApp",
  @"com.apple.CoreAuthUI",
  @"com.apple.SubcredentialUIService",
  @"com.apple.MailCompositionService",
  @"com.apple.Diagnostics",
  @"com.apple.AuthKitUIService",
  @"com.apple.TVRemote",
  @"com.apple.gamecenter.GameCenterUIService",
  @"com.apple.PrintKit.Print-Center",
  @"com.apple.sidecar",
  @"com.apple.AccountAuthenticationDialog",
  @"com.apple.PassbookUIService",
  @"com.apple.siri",
  @"com.apple.CloudKit.ShareBear",
  @"com.apple.HealthENBuddy",
  @"com.apple.SafariViewService",
  @"com.apple.SIMSetupUIService",
  @"com.apple.CompassCalibrationViewService",
  @"com.apple.PhotosViewService",
  @"com.apple.MusicUIService",
  @"com.apple.TrustMe",
  @"com.apple.Home.HomeUIService",
  @"com.apple.CTCarrierSpaceAuth",
  @"com.apple.StoreDemoViewService",
  @"com.apple.susuiservice",
  @"com.apple.social.SLYahooAuth",
  @"com.apple.Spotlight",
  @"com.apple.fieldtest",
  @"com.apple.WebSheet",
  @"com.apple.iad.iAdOptOut",
  @"com.apple.dt.XcodePreviews",
  @"com.apple.appleseed.FeedbackAssistant",
  @"com.apple.FontInstallViewService",
  @"com.apple.ScreenSharingViewService",
  @"com.apple.SharedWebCredentialViewService",
  @"com.apple.CheckerBoard",
  @"com.apple.DataActivation",
  @"com.apple.TVAccessViewService",
  @"com.apple.VSViewService",
  @"com.apple.TVRemoteUIService",
  @"com.apple.SharingViewService",
  @"com.apple.ios.StoreKitUIService",
  @"com.apple.purplebuddy",
  @"com.apple.ScreenTimeUnlock",
  @"com.apple.webapp",
  @"com.apple.AskPermissionUI", nil];

  for (NSString *appId in [apps allKeys]) {
    if (![blacklist containsObject:appId]) {
      NSString *appName = [LSApplicationProxy applicationProxyForIdentifier:appId].localizedName;
      NSDictionary *dict = @{@"appName" : appName, @"appId" : appId};
      [appsDict setObject:dict forKey:appName];
    }
  }
}


@end
