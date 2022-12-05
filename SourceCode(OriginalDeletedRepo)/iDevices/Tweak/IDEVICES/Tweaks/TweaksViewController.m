#import "TweaksViewController.h"

@implementation TweakModel
-(id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    self = [super init];
    if(self) {
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}
@end


@implementation TweaksViewController

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
    
    [self getTweakData];
    [self layoutHeaderView];
    [self layoutCollectionView];
}


-(void)getTweakData {
    
    if(!self.packageInfo) {
        self.packageInfo = [[NSMutableDictionary alloc] init];
        
        NSString *dpkgStatus = [NSString stringWithContentsOfFile:@"Library/dpkg/status" encoding:NSUTF8StringEncoding error:nil];
        NSArray *packages = [dpkgStatus componentsSeparatedByString:@"\n\n"];
        for(NSString *p in packages) {
            [p enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
                if([line hasPrefix:@"Section: "]) {
                    *stop = YES;
                    
                    NSString *section = [line stringByReplacingOccurrencesOfString:@"Section: " withString:@""];
                    section = [section stringByReplacingOccurrencesOfString:@"_" withString:@" "];
                    if(self.packageInfo[section]) {
                        self.packageInfo[section] = @([self.packageInfo[section] intValue] + 1);
                    } else {
                        [self.packageInfo setObject:@1 forKey:section];
                    }
                }
            }];
        }
    }
    
    
    
    self.tweakArray = [[NSArray alloc] init];
    
    NSMutableArray *packageBreakdownBySection = [[NSMutableArray alloc] init];
    
    for(NSString *type in self.packageInfo) {
        
        NSString *packageCount = [NSString stringWithFormat:@"%i", [self.packageInfo[type] intValue]];
        [packageBreakdownBySection addObject:[[TweakModel alloc] initWithTitle:type subtitle:packageCount]];
        
        NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
        NSArray *sortedArray = [packageBreakdownBySection sortedArrayUsingDescriptors:sortDescriptors];
        
        self.tweakArray = sortedArray;
    }
    
    
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
    self.headerIcon.image = [UIImage systemImageNamed:@"hammer.fill"];
    self.headerIcon.tintColor = UIColor.coverIconColour;
    [self.containerView addSubview:self.headerIcon];
    
    [self.headerIcon size:CGSizeMake(75, 75)];
    [self.headerIcon x:self.containerView.centerXAnchor];
    [self.headerIcon top:self.headerView.bottomAnchor padding:-10];
    
    
    self.headerTitle = [[UILabel alloc] init];
    self.headerTitle.textAlignment = NSTextAlignmentCenter;
    self.headerTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    self.headerTitle.textColor = UIColor.coverTitleColour;
    self.headerTitle.text = @"Tweaks";
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
    [self.collectionView registerClass:[TweakCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView top:self.containerView.bottomAnchor padding:5];
    [self.collectionView leading:self.view.leadingAnchor padding:0];
    [self.collectionView trailing:self.view.trailingAnchor padding:0];
    [self.collectionView bottom:self.view.bottomAnchor padding:-5];
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tweakArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweakCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;
    
    TweakModel *data = self.tweakArray[indexPath.row];
    
    cell.titleLabel.text = data.title;
    cell.subtitleLabel.text = data.subtitle;
    cell.iconImage.image = [UIImage systemImageNamed:@"hammer.fill"];
    cell.iconView.backgroundColor = [UIColor.accentColour colorWithAlphaComponent:0.4];
    cell.iconImage.tintColor = UIColor.accentColour;
    
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


@end
