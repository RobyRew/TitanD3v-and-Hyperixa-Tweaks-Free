#import "HomeViewController.h"

NSData *profileAvatar;

@implementation HomeViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    
    [self layoutHeaderView];
    [self layoutScrollView];
    [self layoutGridViews];
    [self initGestures];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectMemojiAvatarNotification:) name:@"DidSelectMemojiAvatar" object:nil];
    
    BOOL didShowDefaultMemojiOption = [[SettingManager sharedInstance] boolForKey:@"didShowDefaultMemojiOption" defaultValue:NO];
    if (!didShowDefaultMemojiOption) {
        [self presentDefaultMemojiVC];
    }
}


-(void)layoutHeaderView {
    
    self.headerView = [[UIView alloc] init];
    [self.view addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 60)];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];
    
    
    profileAvatar = [[SettingManager sharedInstance] objectForKey:@"profileAvatar" defaultValue:nil];
    self.avatarImage = [[UIImageView alloc] init];
    self.avatarImage.layer.cornerRadius = 25;
    self.avatarImage.clipsToBounds = YES;
    if (profileAvatar != nil) {
    self.avatarImage.image = [UIImage imageWithData:profileAvatar];
    } else {
    self.avatarImage.image = [UIImage imageNamed:@"default-avatar"];
    }
    self.avatarImage.userInteractionEnabled = YES;
    [self.headerView addSubview:self.avatarImage];
    
    [self.avatarImage size:CGSizeMake(50, 50)];
    [self.avatarImage y:self.headerView.centerYAnchor];
    [self.avatarImage trailing:self.headerView.trailingAnchor padding:-20];

    
    self.welcomeTitle = [[UILabel alloc] init];
    self.welcomeTitle.text = @"WELCOME TO";
    self.welcomeTitle.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.welcomeTitle.textColor = UIColor.secondaryLabelColor;
    self.welcomeTitle.textAlignment = NSTextAlignmentLeft;
    [self.headerView addSubview:self.welcomeTitle];
    
    [self.welcomeTitle top:self.avatarImage.topAnchor padding:0];
    [self.welcomeTitle leading:self.headerView.leadingAnchor padding:20];
    [self.welcomeTitle trailing:self.avatarImage.leadingAnchor padding:-20];

    
    self.welcomeSubtitle = [[UILabel alloc] init];
    self.welcomeSubtitle.text = @"Avatar Studio";
    self.welcomeSubtitle.font = [UIFont systemFontOfSize:26 weight:UIFontWeightBold];
    self.welcomeSubtitle.textColor = UIColor.labelColor;
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
    
    [self.containerView size:CGSizeMake(self.view.frame.size.width, 780)];
    [self.containerView x:self.scrollView.centerXAnchor];
    [self.containerView top:self.scrollView.topAnchor padding:0];
    
}


-(void)layoutGridViews {
    
    self.memojiView = [[GridView alloc] initWithFrame:CGRectZero bg:[self colorWithHexString:@"96CEB4"] icon:[UIImage imageNamed:@"memoji"] iconSize:120 iconPadding:20 titleTop:20 titleFont:[UIFont systemFontOfSize:22 weight:UIFontWeightBold]];
    self.memojiView.title.text = @"Memoji";
    [self.containerView addSubview:self.memojiView];
    
    [self.memojiView size:CGSizeMake(self.view.frame.size.width/2-30, 200)];
    [self.memojiView top:self.containerView.topAnchor padding:20];
    [self.memojiView leading:self.containerView.leadingAnchor padding:20];
    
    
    self.animojiView = [[GridView alloc] initWithFrame:CGRectZero bg:[self colorWithHexString:@"FFDBAC"] icon:[UIImage imageNamed:@"animoji"] iconSize:110 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
    self.animojiView.title.text = @"Animoji";
    [self.containerView addSubview:self.animojiView];
    
    [self.animojiView size:CGSizeMake(self.view.frame.size.width/2-30, 160)];
    [self.animojiView top:self.containerView.topAnchor padding:20];
    [self.animojiView trailing:self.containerView.trailingAnchor padding:-20];
    
    
    self.avimojiView = [[GridView alloc] initWithFrame:CGRectZero bg:[self colorWithHexString:@"E4DBF1"] icon:[UIImage imageNamed:@"avimoji"] iconSize:110 iconPadding:10 titleTop:5 titleFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
    self.avimojiView.title.text = @"Avimoji";
    [self.containerView addSubview:self.avimojiView];
    
    [self.avimojiView size:CGSizeMake(self.view.frame.size.width/2-30, 160)];
    [self.avimojiView top:self.memojiView.bottomAnchor padding:20];
    [self.avimojiView leading:self.containerView.leadingAnchor padding:20];
    
    
    self.libraryView = [[GridView alloc] initWithFrame:CGRectZero bg:[self colorWithHexString:@"DBEDC1"] icon:[UIImage imageNamed:@"library"] iconSize:120 iconPadding:20 titleTop:20 titleFont:[UIFont systemFontOfSize:22 weight:UIFontWeightBold]];
    self.libraryView.title.text = @"Library";
    [self.containerView addSubview:self.libraryView];
    
    [self.libraryView size:CGSizeMake(self.view.frame.size.width/2-30, 200)];
    [self.libraryView top:self.animojiView.bottomAnchor padding:20];
    [self.libraryView trailing:self.containerView.trailingAnchor padding:-20];
    
    
    self.utilitiesLabel = [[UILabel alloc] init];
    self.utilitiesLabel.text = @"Utilities";
    self.utilitiesLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightHeavy];
    self.utilitiesLabel.textColor = UIColor.labelColor;
    self.utilitiesLabel.textAlignment = NSTextAlignmentLeft;
    [self.containerView addSubview:self.utilitiesLabel];
    
    [self.utilitiesLabel top:self.libraryView.bottomAnchor padding:25];
    [self.utilitiesLabel leading:self.containerView.leadingAnchor padding:20];
    
    
    self.settingView = [[UtilitiesView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"gear"]];
    self.settingView.title.text = @"Settings";
    self.settingView.iconView.backgroundColor = UIColor.systemIndigoColor;
    [self.containerView addSubview:self.settingView];
    
    [self.settingView size:CGSizeMake(self.view.frame.size.width-40, 70)];
    [self.settingView x:self.containerView.centerXAnchor];
    [self.settingView top:self.utilitiesLabel.bottomAnchor padding:10];
    
    
    self.tutorialView = [[UtilitiesView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"questionmark"]];
    self.tutorialView.title.text = @"Tutorial";
    self.tutorialView.iconView.backgroundColor = UIColor.systemRedColor;
    [self.containerView addSubview:self.tutorialView];
    
    [self.tutorialView size:CGSizeMake(self.view.frame.size.width-40, 70)];
    [self.tutorialView x:self.containerView.centerXAnchor];
    [self.tutorialView top:self.settingView.bottomAnchor padding:10];
    

    self.footerView = [[UIView alloc] init];
    [self.scrollView addSubview:self.footerView];
    
    [self.footerView size:CGSizeMake(self.view.frame.size.width, 20)];
    [self.footerView x:self.scrollView.centerXAnchor];
    [self.footerView bottom:self.scrollView.bottomAnchor padding:0];
    [self.footerView top:self.containerView.bottomAnchor padding:0];
    
}


-(void)initGestures {
    
    [self.avatarImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentProfileAvatarPickerVC)]];
    [self.memojiView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentMemojiVC)]];
    [self.animojiView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentAnimojiVC)]];
    [self.avimojiView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentAvimojiVC)]];
    [self.libraryView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentLibraryVC)]];
    [self.settingView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentSettingsVC)]];
    [self.tutorialView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentTutorialVC)]];
}


-(void)presentProfileAvatarPickerVC {
    
    TDAvatarIdentityPickerViewController *vc = [[TDAvatarIdentityPickerViewController alloc] initWithTitle:@"Avatar" showDefaultAvatar:NO avatarImage:self.avatarImage.image accent:UIColor.systemBlueColor];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)didCreatedAvatar:(UIImage *)avatar {
    self.avatarImage.image = avatar;
    NSData *imageData = UIImageJPEGRepresentation(self.avatarImage.image, 1.0);
    [[SettingManager sharedInstance] setObject:imageData forKey:@"profileAvatar"];
}


-(void)didDismissedAvatarPicker {
    NSLog(@"Avatar picker dismissed");
}


-(void)presentMemojiVC {
    AVTAvatarStore *store = [[ASAvatarStore alloc] initWithDomainIdentifier:[NSBundle mainBundle].bundleIdentifier];
    self.memojiViewController = [[ASAvatarLibraryViewController alloc] initWithAvatarStore:store];
    [self presentViewController:self.memojiViewController animated:YES completion:nil];
}


-(void)presentAnimojiVC {
    AnimojiPickerViewController *vc = [[AnimojiPickerViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)presentAvimojiVC {
    AvimojiViewController *vc = [[AvimojiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentLibraryVC {
    LibraryViewController *vc = [[LibraryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentSettingsVC {
    SettingsViewController *vc = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)presentTutorialVC {
    TutorialViewController *vc = [[TutorialViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didSelectAnimojiWithName:(NSString *)animojiName {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    RecordingStudioViewController *vc = [[RecordingStudioViewController alloc] init];
    vc.puppetName = animojiName;
    [self.navigationController pushViewController:vc animated:YES];
    });
}


- (void)didSelectMemojiAvatarNotification:(NSNotification *)notification {
    
    NSData *memojiData = (NSData *)notification.object;
    if (![memojiData isKindOfClass:[NSData class]]) return;

    NSError *error;
    id avatar = [AVTAvatar avatarWithDataRepresentation:memojiData error:&error];

    if (error) {
        return;
    }

    [self.memojiViewController dismissViewControllerAnimated:YES completion:nil];
    
    BOOL isMemoji = [avatar isKindOfClass:[ASAnimoji class]];
    [self pushRecordingControllerWithAvatarInstance:avatar isMemoji:isMemoji];
}


- (void)pushRecordingControllerWithAvatarInstance:(AVTAvatarInstance *)instance isMemoji:(BOOL)isMemoji {
    
    RecordingStudioViewController *recording = [RecordingStudioViewController new];
    [self.navigationController pushViewController:recording animated:YES];
    recording.avatar = instance;
}


-(void)presentDefaultMemojiVC {
    DefaultMemojiViewController *vc = [[DefaultMemojiViewController alloc] init];
    vc.modalInPresentation = YES;
    [self presentViewController:vc animated:YES completion:nil];
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
