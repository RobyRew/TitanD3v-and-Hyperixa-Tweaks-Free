#import "MemoryViewController.h"

@implementation MemoryViewController

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
    [self layoutRamUsage];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateRamUsage) userInfo: nil repeats:YES];
}


-(void)layoutHeaderView {
    
    self.containerView = [[UIView alloc] init];
    self.containerView.layer.cornerRadius = 25;
    self.containerView.layer.cornerCurve = kCACornerCurveContinuous;
    self.containerView.layer.maskedCorners = 12;
    self.containerView.clipsToBounds = YES;
    [self.view addSubview:self.containerView];
    
    [self.containerView size:CGSizeMake(self.view.frame.size.width, 370)];
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
    
    
    self.headerView = [[CDHeaderView alloc] initWithTitle:@"RAM Usage" accent:[UIColor accentColour] leftIcon:@"chevron.left" leftAction:@selector(pushBackVC)];
    self.headerView.leftButton.backgroundColor = [UIColor.navBarButtonColour colorWithAlphaComponent:0.5];
    self.headerView.titleLabel.textColor = UIColor.coverTitleColour;
    [self.containerView addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 75)];
    [self.headerView x:self.containerView.centerXAnchor];
    [self.headerView top:self.containerView.topAnchor padding:0];

}


-(void)layoutRamUsage {
    
    self.totalProgressView = [[DeviceUsageView alloc] initWithFrame:CGRectZero];
    self.totalProgressView.backgroundColor = UIColor.clearColor;
    self.totalProgressView.progressColor = UIColor.totalRamColour;
    self.totalProgressView.progressStrokeColor = UIColor.totalRamColour;
    self.totalProgressView.emptyLineStrokeColor = UIColor.clearColor;
    self.totalProgressView.emptyLineColor = [UIColor.totalRamColour colorWithAlphaComponent:0.4];
    self.totalProgressView.fontColor = UIColor.clearColor;
    self.totalProgressView.progressLineWidth = 14;
    self.totalProgressView.valueFontSize = 10;
    self.totalProgressView.unitFontSize = 8;
    self.totalProgressView.emptyLineWidth = 14;
    self.totalProgressView.emptyCapType = kCGLineCapRound;
    self.totalProgressView.progressAngle = 100;
    self.totalProgressView.progressRotationAngle = 50;
    [self.view addSubview:self.totalProgressView];
    
    [self.totalProgressView size:CGSizeMake(250, 250)];
    [self.totalProgressView x:self.view.centerXAnchor];
    [self.totalProgressView top:self.headerView.bottomAnchor padding:20];
    
    
    self.usedProgressView = [[DeviceUsageView alloc] initWithFrame:CGRectZero];
    self.usedProgressView.backgroundColor = UIColor.clearColor;
    self.usedProgressView.progressColor = UIColor.usedRamColour;
    self.usedProgressView.progressStrokeColor = UIColor.usedRamColour;
    self.usedProgressView.emptyLineStrokeColor = UIColor.clearColor;
    self.usedProgressView.emptyLineColor = [UIColor.usedRamColour colorWithAlphaComponent:0.4];
    self.usedProgressView.fontColor = UIColor.clearColor;
    self.usedProgressView.progressLineWidth = 14;
    self.usedProgressView.valueFontSize = 10;
    self.usedProgressView.unitFontSize = 8;
    self.usedProgressView.emptyLineWidth = 14;
    self.usedProgressView.emptyCapType = kCGLineCapRound;
    self.usedProgressView.progressAngle = 100;
    self.usedProgressView.progressRotationAngle = 50;
    [self.view addSubview:self.usedProgressView];
    
    [self.usedProgressView size:CGSizeMake(210, 210)];
    [self.usedProgressView x:self.totalProgressView.centerXAnchor y:self.totalProgressView.centerYAnchor];;
    
    
    self.freeProgressView = [[DeviceUsageView alloc] initWithFrame:CGRectZero];
    self.freeProgressView.backgroundColor = UIColor.clearColor;
    self.freeProgressView.progressColor = UIColor.freeRamColour;
    self.freeProgressView.progressStrokeColor = UIColor.freeRamColour;
    self.freeProgressView.emptyLineStrokeColor = UIColor.clearColor;
    self.freeProgressView.emptyLineColor = [UIColor.freeRamColour colorWithAlphaComponent:0.4];
    self.freeProgressView.fontColor = UIColor.clearColor;
    self.freeProgressView.unitString = @" MB";
    self.freeProgressView.valueFontSize = 18;
    self.freeProgressView.unitFontSize = 18;
    self.freeProgressView.progressLineWidth = 14;
    self.freeProgressView.valueFontSize = 10;
    self.freeProgressView.unitFontSize = 8;
    self.freeProgressView.emptyLineWidth = 14;
    self.freeProgressView.emptyCapType = kCGLineCapRound;
    self.freeProgressView.progressAngle = 100;
    self.freeProgressView.progressRotationAngle = 50;
    [self.view addSubview:self.freeProgressView];
    
    [self.freeProgressView size:CGSizeMake(170, 170)];
    [self.freeProgressView x:self.totalProgressView.centerXAnchor y:self.totalProgressView.centerYAnchor];;
    
    
    self.totalView = [[MemoryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"chart.bar.xaxis"]];
    self.totalView.title.text = @"Total";
    self.totalView.subtitle.text = @"";
    self.totalView.iconView.backgroundColor = [UIColor.totalRamColour colorWithAlphaComponent:0.4];
    self.totalView.icon.tintColor = UIColor.totalRamColour;
    [self.view addSubview:self.totalView];
    
    [self.totalView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.totalView x:self.view.centerXAnchor];
    [self.totalView top:self.containerView.bottomAnchor padding:20];
    
    
    self.usedView = [[MemoryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"chart.bar.xaxis"]];
    self.usedView.title.text = @"Used";
    self.usedView.subtitle.text = @"";
    self.usedView.iconView.backgroundColor = [UIColor.usedRamColour colorWithAlphaComponent:0.4];
    self.usedView.icon.tintColor = UIColor.usedRamColour;
    [self.view addSubview:self.usedView];
    
    [self.usedView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.usedView x:self.view.centerXAnchor];
    [self.usedView top:self.totalView.bottomAnchor padding:10];
    
    
    self.freeView = [[MemoryView alloc] initWithFrame:CGRectZero icon:[UIImage systemImageNamed:@"chart.bar.xaxis"]];
    self.freeView.title.text = @"Free";
    self.freeView.subtitle.text = @"";
    self.freeView.iconView.backgroundColor = [UIColor.freeRamColour colorWithAlphaComponent:0.4];
    self.freeView.icon.tintColor = UIColor.freeRamColour;
    [self.view addSubview:self.freeView];
    
    [self.freeView size:CGSizeMake(self.view.frame.size.width-40, 60)];
    [self.freeView x:self.view.centerXAnchor];
    [self.freeView top:self.usedView.bottomAnchor padding:10];
    
}


-(void)updateRamUsage {
    
    NSString *freeRamString = [NSString stringWithFormat:@"%@",[[RamManager sharedManager] getFreeRam]];
    NSString *usedRamString = [NSString stringWithFormat:@"%@",[[RamManager sharedManager] getUsedRam]];
    NSString *totalRamString = [NSString stringWithFormat:@"%@",[[RamManager sharedManager] getTotalRam]];
    
    float freeRamFloat = [freeRamString floatValue];
    float usedRamFloat = [usedRamString floatValue];
    float totalRamFloat = [totalRamString floatValue];
    
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.freeProgressView.value = freeRamFloat;
        self.freeProgressView.maxValue = usedRamFloat;
        
        self.usedProgressView.value = usedRamFloat;
        self.usedProgressView.maxValue = totalRamFloat;
        
        self.totalProgressView.value = totalRamFloat;
        self.totalProgressView.maxValue = totalRamFloat;
        
    }];
    
    self.totalView.subtitle.text = totalRamString;
    self.usedView.subtitle.text = usedRamString;
    self.freeView.subtitle.text = freeRamString;
    
}


-(void)pushBackVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
