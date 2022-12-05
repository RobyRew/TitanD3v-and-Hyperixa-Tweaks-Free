#import "DeviceViewController.h"

@implementation DeviceViewController

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
    
    [self getDevicesData];
    [self layoutHeaderView];
    [self layoutCollectionView];
}


-(void)getDevicesData {
    
    NSString *plistPath = @"/tmp/EMPGetDevices.plist"; //[IMPORTANT] Need to change plist path to wherever it was saved to
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    
    self.devicesArray = [NSMutableArray new];
    self.devicesArray = [mutableDict objectForKey:@"devices"];

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
    self.headerIcon.image = [UIImage systemImageNamed:@"laptopcomputer.and.iphone"];
    self.headerIcon.tintColor = UIColor.coverIconColour;
    [self.containerView addSubview:self.headerIcon];
    
    [self.headerIcon size:CGSizeMake(75, 75)];
    [self.headerIcon x:self.containerView.centerXAnchor];
    [self.headerIcon top:self.headerView.bottomAnchor padding:-10];
    
    
    self.headerTitle = [[UILabel alloc] init];
    self.headerTitle.textAlignment = NSTextAlignmentCenter;
    self.headerTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    self.headerTitle.textColor = UIColor.coverTitleColour;
    self.headerTitle.text = @"Devices";
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
    [self.collectionView registerClass:[DevicesCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[SectionCellHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView top:self.containerView.bottomAnchor padding:0];
    [self.collectionView leading:self.view.leadingAnchor padding:0];
    [self.collectionView trailing:self.view.trailingAnchor padding:0];
    [self.collectionView bottom:self.view.bottomAnchor padding:-5];
}


- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 45);
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        SectionCellHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if ([self.devicesArray count] > 1) {
            headerView.headerLabel.text = [NSString stringWithFormat:@"%lu Devices", [self.devicesArray count]];
        } else {
            headerView.headerLabel.text = @"No Devices";
        }
        reusableview = headerView;
    }
    
    return reusableview;
    
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.devicesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DevicesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:self.devicesArray[indexPath.row][@"modelLargePhotoURL1x"]]];
    cell.deviceImage.image = [UIImage imageWithData: imageData];
    
    cell.nameLabel.text = self.devicesArray[indexPath.row][@"name"];
    cell.deviceLabel.text = self.devicesArray[indexPath.row][@"modelDisplayName"];
    cell.modelLabel.text = self.devicesArray[indexPath.row][@"model"];
    NSString *versionString = [self.devicesArray[indexPath.row][@"swVersion"] stringByReplacingOccurrencesOfString:@";" withString:@" "];
    cell.versionLabel.text = versionString;
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width  = self.view.frame.size.width /2 -30;
    return CGSizeMake(width, 150);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 20.0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20.0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,20,0,20);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {
    
    UIContextMenuConfiguration* config = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu* _Nullable(NSArray<UIMenuElement*>* _Nonnull suggestedActions) {
        
        NSString *menuTitle = self.devicesArray[indexPath.row][@"name"];
        
        UIAction *copyAction = [UIAction actionWithTitle:@"Copy Details" image:[UIImage systemImageNamed:@"paperclip"] identifier:nil handler:^(UIAction *action) {
            
            NSString *versionString = [self.devicesArray[indexPath.row][@"swVersion"] stringByReplacingOccurrencesOfString:@";" withString:@" "];
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", self.devicesArray[indexPath.row][@"name"], self.devicesArray[indexPath.row][@"modelDisplayName"], self.devicesArray[indexPath.row][@"model"], versionString];
            [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", menuTitle]];
        }];
        
        return [UIMenu menuWithTitle:menuTitle children:@[copyAction]];
        
    }];
    
    return config;
}


-(void)pushBackVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle { // iloveya
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
