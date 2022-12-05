#import "RecordingOnboardingViewController.h"

@implementation RecordingOnboardingViewController

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
    
    [self layoutScreenshotView];
}


-(void)layoutScreenshotView {
    
    self.screenshot = [[UIImageView alloc] init];
    self.screenshot.image = [UIImage imageNamed:@"recording-tutorial"];
    [self.view addSubview:self.screenshot];
    
    [self.screenshot size:CGSizeMake(self.view.frame.size.width-70, self.view.frame.size.width-70)];
    [self.screenshot x:self.view.centerXAnchor];
    [self.screenshot top:self.grabberView.bottomAnchor padding:20];
    
    
    self.dismissButton = [[UIButton alloc] init];
    self.dismissButton.backgroundColor = [UIColor.systemBlueColor colorWithAlphaComponent:0.4];
    self.dismissButton.layer.cornerRadius = 15;
    self.dismissButton.layer.cornerCurve = kCACornerCurveContinuous;
    [self.dismissButton setTitle:@"Continue" forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.view addSubview:self.dismissButton];
    
    [self.dismissButton size:CGSizeMake(self.view.frame.size.width-100, 50)];
    [self.dismissButton x:self.view.centerXAnchor];
    [self.dismissButton bottom:self.view.safeAreaLayoutGuide.bottomAnchor padding:-10];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor colorNamed:@"Secondary"];
    self.textView.textColor = UIColor.labelColor;
    self.textView.text = @"The red border line is your recording area. Don’t put stickers or objects out of bounds otherwise they will not be in the actual video.";
    self.textView.editable = NO;
    self.textView.layer.cornerRadius = 20;
    self.textView.layer.cornerCurve = kCACornerCurveContinuous;
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.textView.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:self.textView];
    
    [self.textView top:self.screenshot.bottomAnchor padding:25];
    [self.textView leading:self.view.leadingAnchor padding:25];
    [self.textView trailing:self.view.trailingAnchor padding:-25];
    [self.textView bottom:self.dismissButton.topAnchor padding:-25];
}


-(void)dismissVC {
    [[SettingManager sharedInstance] setBool:YES forKey:@"didShowRecordingOnboarding"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
