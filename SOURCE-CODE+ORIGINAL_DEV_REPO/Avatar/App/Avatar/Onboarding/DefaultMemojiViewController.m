#import "DefaultMemojiViewController.h"


@implementation DefaultMemojiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    
    self.grabberView = [[UIView alloc] init];
    self.grabberView.backgroundColor = UIColor.tertiarySystemFillColor;
    self.grabberView.layer.cornerRadius = 3;
    [self.view addSubview:self.grabberView];
    
    [self.grabberView size:CGSizeMake(40, 6)];
    [self.grabberView x:self.view.centerXAnchor];
    [self.grabberView top:self.view.topAnchor padding:10];
    
    [self layoutViews];
}


-(void)layoutViews {
    
    self.coverImage = [[UIImageView alloc] init];
    self.coverImage.image = [UIImage imageNamed:@"cover"];
    [self.view addSubview:self.coverImage];
    
    [self.coverImage size:CGSizeMake(300, 147)];
    [self.coverImage x:self.view.centerXAnchor];
    [self.coverImage top:self.grabberView.bottomAnchor padding:20];
    
    
    self.noButton = [[UIButton alloc] init];
    self.noButton.backgroundColor = [UIColor.systemRedColor colorWithAlphaComponent:0.4];
    self.noButton.layer.cornerRadius = 15;
    self.noButton.layer.cornerCurve = kCACornerCurveContinuous;
    [self.noButton setTitle:@"NO" forState:UIControlStateNormal];
    [self.noButton addTarget:self action:@selector(dontUseDefaultMemoji) forControlEvents:UIControlEventTouchUpInside];
    [self.noButton setTitleColor:UIColor.systemRedColor forState:UIControlStateNormal];
    [self.view addSubview:self.noButton];
    
    [self.noButton size:CGSizeMake(self.view.frame.size.width-100, 50)];
    [self.noButton x:self.view.centerXAnchor];
    [self.noButton bottom:self.view.safeAreaLayoutGuide.bottomAnchor padding:-10];
    
    
    self.yesButton = [[UIButton alloc] init];
    self.yesButton.backgroundColor = [UIColor.systemBlueColor colorWithAlphaComponent:0.4];
    self.yesButton.layer.cornerRadius = 15;
    self.yesButton.layer.cornerCurve = kCACornerCurveContinuous;
    [self.yesButton setTitle:@"YES" forState:UIControlStateNormal];
    [self.yesButton addTarget:self action:@selector(useDefaultMemoji) forControlEvents:UIControlEventTouchUpInside];
    [self.yesButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.view addSubview:self.yesButton];
    
    [self.yesButton size:CGSizeMake(self.view.frame.size.width-100, 50)];
    [self.yesButton x:self.view.centerXAnchor];
    [self.yesButton bottom:self.noButton.topAnchor padding:-15];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor colorNamed:@"Secondary"];
    self.textView.textColor = UIColor.labelColor;
    self.textView.text = @"Do you want to import existing Memoji that you’ve already created in iMessage? If yes then you won’t be able to create new Memoji in the Avatar app but you still can create new Memoji in iMessage then the Avatar app will load the newly created Memoji. If you choose no then you will need to create new Memoji within the app. Don’t worry you can switch between existing or new Memoji in the settings option.";
    self.textView.editable = NO;
    self.textView.layer.cornerRadius = 20;
    self.textView.layer.cornerCurve = kCACornerCurveContinuous;
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.textView.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:self.textView];
    
    [self.textView top:self.coverImage.bottomAnchor padding:25];
    [self.textView leading:self.view.leadingAnchor padding:25];
    [self.textView trailing:self.view.trailingAnchor padding:-25];
    [self.textView bottom:self.yesButton.topAnchor padding:-25];
}


-(void)dontUseDefaultMemoji {
    
    [[SettingManager sharedInstance] setBool:YES forKey:@"didShowDefaultMemojiOption"];
    [[SettingManager sharedInstance] setBool:NO forKey:@"useDefaultMemoji"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)useDefaultMemoji {
    
    [[SettingManager sharedInstance] setBool:YES forKey:@"didShowDefaultMemojiOption"];
    [[SettingManager sharedInstance] setBool:YES forKey:@"useDefaultMemoji"];
    [self showAlertWithTitle:@"Existing Memoji" subtitle:@"Restarting is required, the app will now terminate and you will need to relaunch the Avatar app in order for it to load existing Memoji."];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        //exit(0);
        UIApplication *app = [UIApplication sharedApplication];
        [app performSelector:@selector(suspend)];
        [NSThread sleepForTimeInterval:1.0];
        exit(0);
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
