#import "HomeViewController.h"

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


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
    
    [self layoutHeaderView];
    [self layoutScrollView];
    [self layoutGridViews];
    [self initGestures];
}


-(void)layoutHeaderView {
    
    self.grabberView = [[UIView alloc] init];
    self.grabberView.backgroundColor = [UIColor grabberColour];
    self.grabberView.layer.cornerRadius = 3;
    [self.view addSubview:self.grabberView];
    
    [self.grabberView size:CGSizeMake(40, 6)];
    [self.grabberView x:self.view.centerXAnchor];
    [self.grabberView top:self.view.topAnchor padding:10];
    
    
    self.headerView = [[UIView alloc] init];
    [self.view addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 60)];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:15];
    
    
    self.avatarImage = [[UIImageView alloc] init];
    self.avatarImage.layer.cornerRadius = 25;
    self.avatarImage.clipsToBounds = YES;
    self.avatarImage.image = [[DataManager sharedInstance] icloudAvatar];
    self.avatarImage.userInteractionEnabled = YES;
    self.avatarImage.tintColor = [UIColor accentColour];
    [self.headerView addSubview:self.avatarImage];
    
    [self.avatarImage size:CGSizeMake(50, 50)];
    [self.avatarImage y:self.headerView.centerYAnchor];
    [self.avatarImage trailing:self.headerView.trailingAnchor padding:-20];

    
    self.welcomeTitle = [[UILabel alloc] init];
    self.welcomeTitle.text = @"WELCOME";
    self.welcomeTitle.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.welcomeTitle.textColor = [UIColor secondaryFontColour];
    self.welcomeTitle.textAlignment = NSTextAlignmentLeft;
    [self.headerView addSubview:self.welcomeTitle];
    
    [self.welcomeTitle top:self.avatarImage.topAnchor padding:0];
    [self.welcomeTitle leading:self.headerView.leadingAnchor padding:20];
    [self.welcomeTitle trailing:self.avatarImage.leadingAnchor padding:-20];

    
    self.welcomeSubtitle = [[UILabel alloc] init];
    self.welcomeSubtitle.text = [[DataManager sharedInstance] icloudFullName];
    self.welcomeSubtitle.font = [UIFont systemFontOfSize:26 weight:UIFontWeightBold];
    self.welcomeSubtitle.textColor = [UIColor fontColour];
    self.welcomeSubtitle.textAlignment = NSTextAlignmentLeft;
    [self.headerView addSubview:self.welcomeSubtitle];
    
    [self.welcomeSubtitle bottom:self.avatarImage.bottomAnchor padding:0];
    [self.welcomeSubtitle leading:self.headerView.leadingAnchor padding:20];
    [self.welcomeSubtitle trailing:self.avatarImage.leadingAnchor padding:-20];
    
}


-(void)layoutScrollView {
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView top:self.headerView.bottomAnchor padding:0];
    [self.scrollView leading:self.view.leadingAnchor padding:0];
    [self.scrollView trailing:self.view.trailingAnchor padding:0];
    [self.scrollView bottom:self.view.bottomAnchor padding:0];
    
    
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = UIColor.clearColor;
    [self.scrollView addSubview:self.containerView];
    
    [self.containerView size:CGSizeMake(self.view.frame.size.width, 860)];
    [self.containerView x:self.scrollView.centerXAnchor];
    [self.containerView top:self.scrollView.topAnchor padding:0];
    
}


-(void)layoutGridViews {
    
    self.icloudView = [[GridView alloc] initWithFrame:CGRectZero bg:[UIColor.tealColour colorWithAlphaComponent:0.4] icon:[UIImage systemImageNamed:@"cloud.fill"] iconSize:70 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.icloudView.title.text = @"iCloud";
    self.icloudView.icon.tintColor = UIColor.tealColour;
    [self.containerView addSubview:self.icloudView];
    
    [self.icloudView size:CGSizeMake(self.view.frame.size.width/2-30, 110)];
    [self.icloudView top:self.containerView.topAnchor padding:20];
    [self.icloudView leading:self.containerView.leadingAnchor padding:20];
    
    
    self.deviceView = [[GridView alloc] initWithFrame:CGRectZero bg:[UIColor.indigoColour colorWithAlphaComponent:0.4] icon:[UIImage systemImageNamed:@"laptopcomputer.and.iphone"] iconSize:70 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.deviceView.title.text = @"Devices";
    self.deviceView.icon.tintColor = UIColor.indigoColour;
    [self.containerView addSubview:self.deviceView];
    
    [self.deviceView size:CGSizeMake(self.view.frame.size.width/2-30, 110)];
    [self.deviceView top:self.containerView.topAnchor padding:20];
    [self.deviceView trailing:self.containerView.trailingAnchor padding:-20];
    
    
    self.batteryView = [[GridView alloc] initWithFrame:CGRectZero bg:[UIColor.greenColour colorWithAlphaComponent:0.4] icon:[UIImage systemImageNamed:@"battery.100"] iconSize:70 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.batteryView.title.text = @"Battery";
    self.batteryView.icon.tintColor = UIColor.greenColour;
    [self.containerView addSubview:self.batteryView];
    
    [self.batteryView size:CGSizeMake(self.view.frame.size.width/2-30, 110)];
    [self.batteryView top:self.icloudView.bottomAnchor padding:20];
    [self.batteryView leading:self.containerView.leadingAnchor padding:20];
    
    
    self.storageView = [[GridView alloc] initWithFrame:CGRectZero bg:[UIColor.yellowColour colorWithAlphaComponent:0.4] icon:[UIImage systemImageNamed:@"chart.pie.fill"] iconSize:70 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.storageView.title.text = @"Storage";
    self.storageView.icon.tintColor = UIColor.yellowColour;
    [self.containerView addSubview:self.storageView];
    
    [self.storageView size:CGSizeMake(self.view.frame.size.width/2-30, 110)];
    [self.storageView top:self.deviceView.bottomAnchor padding:20];
    [self.storageView trailing:self.containerView.trailingAnchor padding:-20];
    
    
    self.memoryView = [[GridView alloc] initWithFrame:CGRectZero bg:[UIColor.redColour colorWithAlphaComponent:0.4] icon:[UIImage systemImageNamed:@"chart.bar.xaxis"] iconSize:70 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.memoryView.title.text = @"RAM Usage";
    self.memoryView.icon.tintColor = UIColor.redColour;
    [self.containerView addSubview:self.memoryView];
    
    [self.memoryView size:CGSizeMake(self.view.frame.size.width/2-30, 110)];
    [self.memoryView top:self.batteryView.bottomAnchor padding:20];
    [self.memoryView leading:self.containerView.leadingAnchor padding:20];
    
    
    self.aboutView = [[GridView alloc] initWithFrame:CGRectZero bg:[UIColor.orangeColour colorWithAlphaComponent:0.4] icon:[UIImage systemImageNamed:@"info.circle.fill"] iconSize:70 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.aboutView.title.text = @"About";
    self.aboutView.icon.tintColor = UIColor.orangeColour;
    [self.containerView addSubview:self.aboutView];
    
    [self.aboutView size:CGSizeMake(self.view.frame.size.width/2-30, 110)];
    [self.aboutView top:self.storageView.bottomAnchor padding:20];
    [self.aboutView trailing:self.containerView.trailingAnchor padding:-20];
    
    
    self.appsView = [[GridView alloc] initWithFrame:CGRectZero bg:[UIColor.accentColour colorWithAlphaComponent:0.4] icon:[UIImage systemImageNamed:@"apps.iphone"] iconSize:70 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.appsView.title.text = @"Apps";
    self.appsView.icon.tintColor = UIColor.accentColour;
    [self.containerView addSubview:self.appsView];
    
    [self.appsView size:CGSizeMake(self.view.frame.size.width/2-30, 110)];
    [self.appsView top:self.memoryView.bottomAnchor padding:20];
    [self.appsView leading:self.containerView.leadingAnchor padding:20];
    
    
    self.tweaksView = [[GridView alloc] initWithFrame:CGRectZero bg:[UIColor.pinkColour colorWithAlphaComponent:0.4] icon:[UIImage systemImageNamed:@"hammer.fill"] iconSize:70 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:16 weight:UIFontWeightBold]];
    self.tweaksView.title.text = @"Tweaks";
    self.tweaksView.icon.tintColor = UIColor.pinkColour;
    [self.containerView addSubview:self.tweaksView];
    
    [self.tweaksView size:CGSizeMake(self.view.frame.size.width/2-30, 110)];
    [self.tweaksView top:self.aboutView.bottomAnchor padding:20];
    [self.tweaksView trailing:self.containerView.trailingAnchor padding:-20];
    
    
    self.summaryLabel = [[UILabel alloc] init];
    self.summaryLabel.text = @"Summary";
    self.summaryLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightHeavy];
    self.summaryLabel.textColor = [UIColor subtitleColour];
    self.summaryLabel.textAlignment = NSTextAlignmentLeft;
    [self.containerView addSubview:self.summaryLabel];
    
    [self.summaryLabel top:self.appsView.bottomAnchor padding:25];
    [self.summaryLabel leading:self.containerView.leadingAnchor padding:20];
    
    
    self.lockedView = [[SummaryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"lock.fill"]];
    self.lockedView.title.text = @"Last time locked";
    self.lockedView.subtitle.text = [[DataManager sharedInstance] lastLockedDevice];
    self.lockedView.iconView.backgroundColor = [UIColor.redColour colorWithAlphaComponent:0.4];
    self.lockedView.icon.tintColor = UIColor.redColour;
    [self.containerView addSubview:self.lockedView];
    
    [self.lockedView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.lockedView x:self.containerView.centerXAnchor];
    [self.lockedView top:self.summaryLabel.bottomAnchor padding:10];
    
    
    self.unlockedView = [[SummaryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"lock.open.fill"]];
    self.unlockedView.title.text = @"Last time unlocked";
    self.unlockedView.subtitle.text = [[DataManager sharedInstance] lastUnlockedDevice];
    self.unlockedView.iconView.backgroundColor = [UIColor.greenColour colorWithAlphaComponent:0.4];
    self.unlockedView.icon.tintColor = UIColor.greenColour;
    [self.containerView addSubview:self.unlockedView];
    
    [self.unlockedView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.unlockedView x:self.containerView.centerXAnchor];
    [self.unlockedView top:self.lockedView.bottomAnchor padding:10];
    
    
    self.respringView = [[SummaryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"rays"]];
    self.respringView.title.text = @"Last time respring";
    self.respringView.subtitle.text = [[DataManager sharedInstance] lastRespringDevice];
    self.respringView.iconView.backgroundColor = [UIColor.tealColour colorWithAlphaComponent:0.4];
    self.respringView.icon.tintColor = UIColor.tealColour;
    [self.containerView addSubview:self.respringView];
    
    [self.respringView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.respringView x:self.containerView.centerXAnchor];
    [self.respringView top:self.unlockedView.bottomAnchor padding:10];
    
    
    self.appView = [[SummaryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"apps.iphone"]];
    self.appView.title.text = @"Last opened app";
    self.appView.subtitle.text = [[DataManager sharedInstance] lastOpenedApp];
    self.appView.iconView.backgroundColor = [UIColor.indigoColour colorWithAlphaComponent:0.4];
    self.appView.icon.tintColor = UIColor.indigoColour;
    [self.containerView addSubview:self.appView];
    
    [self.appView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.appView x:self.containerView.centerXAnchor];
    [self.appView top:self.respringView.bottomAnchor padding:10];
    

    self.footerView = [[UIView alloc] init];
    [self.scrollView addSubview:self.footerView];
    
    [self.footerView size:CGSizeMake(self.view.frame.size.width, 20)];
    [self.footerView x:self.scrollView.centerXAnchor];
    [self.footerView bottom:self.scrollView.bottomAnchor padding:0];
    [self.footerView top:self.containerView.bottomAnchor padding:0];
    
}


-(void)initGestures {
    
    [self.icloudView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentIcloudVC)]];
    [self.deviceView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentDeviceVC)]];
    [self.batteryView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentBatteryVC)]];
    [self.storageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentStorageVC)]];
    [self.memoryView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentMemoryVC)]];
    [self.aboutView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentAboutVC)]];
    [self.appsView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentAppsVC)]];
    [self.tweaksView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentTweaksVC)]];
}


-(void)presentIcloudVC {
    invokeHaptic();
    CloudViewController *vc = [[CloudViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentDeviceVC {
    invokeHaptic();
    DeviceViewController *vc = [[DeviceViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentBatteryVC {
    invokeHaptic();
    BatteryViewController *vc = [[BatteryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentStorageVC {
    invokeHaptic();
    StorageViewController *vc = [[StorageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentMemoryVC {
    invokeHaptic();
    MemoryViewController *vc = [[MemoryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentAboutVC {
    invokeHaptic();
    AboutViewController *vc = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentAppsVC {
    invokeHaptic();
    AppsViewController *vc = [[AppsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentTweaksVC {
    invokeHaptic();
    TweaksViewController *vc = [[TweaksViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
