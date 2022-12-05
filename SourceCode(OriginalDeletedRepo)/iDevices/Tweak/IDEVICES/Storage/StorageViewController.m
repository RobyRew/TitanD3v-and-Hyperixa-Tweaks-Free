#import "StorageViewController.h"

static NSString *plistStorage = @"/tmp/EMPStorageUsageInfo.plist";
static double const DECIMAL_GIGABYTE = 1024 * 1024 * 1024;

static NSString *storageFormater(double storage){
    storage = storage/DECIMAL_GIGABYTE;
    
    if(storage < 1){
        return [NSString stringWithFormat:@"%.2f MB", storage * 1024];
    }
    else if(storage > 1 && storage < 1024){
        return [NSString stringWithFormat:@"%.2f GB", storage];
    }
    else if(storage >= 1024){
        return [NSString stringWithFormat:@"%.2f TB", storage / 1024];
    }
    
    return [NSString stringWithFormat:@"Could not get the iCloud Storage details"];
}


static NSDictionary *readiCloudPlist(){
    return [NSDictionary dictionaryWithContentsOfFile:plistStorage];
}


@implementation StorageViewController

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
    
    NSString *plistPath = @"/tmp/EMPStorageUsageInfo.plist"; //[IMPORTANT] Need to change plist path to wherever it was saved to
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    
    self.mediaArray = [NSMutableArray new];
    self.mediaArray = [mutableDict objectForKey:@"storage_usage_by_media"];
    
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
    self.headerIcon.image = [UIImage systemImageNamed:@"chart.pie.fill"];
    self.headerIcon.tintColor = UIColor.coverIconColour;
    [self.containerView addSubview:self.headerIcon];
    
    [self.headerIcon size:CGSizeMake(75, 75)];
    [self.headerIcon x:self.containerView.centerXAnchor];
    [self.headerIcon top:self.headerView.bottomAnchor padding:-10];
    
    
    self.headerTitle = [[UILabel alloc] init];
    self.headerTitle.textAlignment = NSTextAlignmentCenter;
    self.headerTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    self.headerTitle.textColor = UIColor.coverTitleColour;
    self.headerTitle.text = @"Storage";
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
    [self.collectionView registerClass:[StorageCell class] forCellWithReuseIdentifier:@"Cell"];
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
    return 3;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 45);
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        SectionCellHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.headerLabel.text = @"iPhone";
        } else if (indexPath.section == 1) {
            headerView.headerLabel.text = @"iCloud Capacity";
        } else if (indexPath.section == 2) {
            headerView.headerLabel.text = @"iCloud Media";
        }
        reusableview = headerView;
    }
    
    return reusableview;
    
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 3;
    } else {
        return self.mediaArray.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    StorageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;
    
    if (indexPath.section == 0) {
        
        NSDictionary *storageData = [self deviceStorageData];
        cell.iconImage.image = [UIImage systemImageNamed:@"iphone"];
        
        if (indexPath.row == 0) {
            
            cell.titleLabel.text = @"Total";
            cell.subtitleLabel.text = [NSString stringWithFormat:@"%ld GB", [[storageData objectForKey:@"TotalSpace"] integerValue]];
            cell.iconView.backgroundColor = [UIColor.indigoColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.indigoColour;
            
        } else if (indexPath.row == 1) {
            
            cell.titleLabel.text = @"Used";
            cell.subtitleLabel.text = [NSString stringWithFormat:@"%ld GB", [[storageData objectForKey:@"UsedSpace"] integerValue]];
            cell.iconView.backgroundColor = [UIColor.redColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.redColour;
            
        } else if (indexPath.row == 2) {
            
            cell.titleLabel.text = @"Available";
            cell.subtitleLabel.text = [NSString stringWithFormat:@"%ld GB", [[storageData objectForKey:@"FreeSpace"] integerValue]];
            cell.iconView.backgroundColor = [UIColor.greenColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.greenColour;
        }
        
        
    } else if (indexPath.section == 1) {
        
        NSDictionary *storage_data = readiCloudPlist()[@"storage_data"][@"quota_info_in_bytes"];
        
        double total_quota = [storage_data[@"total_quota"] doubleValue];
        double total_used = [storage_data[@"total_used"] doubleValue];
        double total_available = [storage_data[@"total_available"] doubleValue];
        
        NSString *total_quota_Str = storageFormater(total_quota);
        NSString *total_used_Str = storageFormater(total_used);
        NSString *total_available_Str = storageFormater(total_available);
        
        cell.iconImage.image = [UIImage systemImageNamed:@"chart.pie.fill"];
        
        if (indexPath.row == 0) {
            
            cell.titleLabel.text = @"Total";
            cell.subtitleLabel.text = total_quota_Str;
            cell.iconView.backgroundColor = [UIColor.yellowColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.yellowColour;
            
        } else if (indexPath.row == 1) {
            
            cell.titleLabel.text = @"Used";
            cell.subtitleLabel.text = total_used_Str;
            cell.iconView.backgroundColor = [UIColor.orangeColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.orangeColour;
            
        } else if (indexPath.row == 2) {
            
            cell.titleLabel.text = @"Available";
            cell.subtitleLabel.text = total_available_Str;
            cell.iconView.backgroundColor = [UIColor.pinkColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.pinkColour;
            
        }
        
        
    } else if (indexPath.section == 2) {
        
        cell.titleLabel.text = [[self.mediaArray objectAtIndex:indexPath.row] objectForKey:@"display_label"];
        
        double mediaSize = [[[self.mediaArray objectAtIndex:indexPath.row] objectForKey:@"usage_in_bytes"] doubleValue];
        NSString *mediaSizeString = storageFormater(mediaSize);
        cell.subtitleLabel.text = mediaSizeString;
        
        
        NSString *icons = [[self.mediaArray objectAtIndex:indexPath.row] objectForKey:@"display_label"];
        
        if ([icons isEqualToString:@"Photos"]) {
            cell.iconImage.image = [UIImage systemImageNamed:@"photo.fill.on.rectangle.fill"];
            cell.iconView.backgroundColor = [UIColor.yellowColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.yellowColour;
        } else if ([icons isEqualToString:@"Backups"]) {
            cell.iconImage.image = [UIImage systemImageNamed:@"cloud.fill"];
            cell.iconView.backgroundColor = [UIColor.indigoColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.indigoColour;
        } else if ([icons isEqualToString:@"Docs"]) {
            cell.iconImage.image = [UIImage systemImageNamed:@"folder.fill"];
            cell.iconView.backgroundColor = [UIColor.orangeColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.orangeColour;
        } else if ([icons isEqualToString:@"Messages"]) {
            cell.iconImage.image = [UIImage systemImageNamed:@"message.fill"];
            cell.iconView.backgroundColor = [UIColor.greenColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.greenColour;
        } else if ([icons isEqualToString:@"Mail"]) {
            cell.iconImage.image = [UIImage systemImageNamed:@"envelope.fill"];
            cell.iconView.backgroundColor = [UIColor.tealColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.tealColour;
        } else if ([icons isEqualToString:@"Others"]) {
            cell.iconImage.image = [UIImage systemImageNamed:@"cloud.fill"];
            cell.iconView.backgroundColor = [UIColor.pinkColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.pinkColour;
        } else if ([icons isEqualToString:@"Family"]) {
            cell.iconImage.image = [UIImage systemImageNamed:@"person.2.fill"];
            cell.iconView.backgroundColor = [UIColor.redColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.redColour;
        } else {
            cell.iconImage.image = [UIImage systemImageNamed:@"cloud.fill"];
            cell.iconView.backgroundColor = [UIColor.accentColour colorWithAlphaComponent:0.4];
            cell.iconImage.tintColor = UIColor.accentColour;
        }
        
    }
    
    
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


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


-(void)pushBackVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
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


-(NSDictionary*)deviceStorageData {
    unsigned long long totalSpace = 0;
    unsigned long long totalFreeSpace = 0;
    unsigned long long usedSpace = 0;
    
    NSError *error = nil;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
    
    totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:@"/private/var/"];
    NSDictionary *results = [fileURL resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey] error:&error];
    
    totalFreeSpace = [results[NSURLVolumeAvailableCapacityForImportantUsageKey] longLongValue];
    
    usedSpace = totalSpace - totalFreeSpace;
    
    NSDictionary *spaceDict = @{@"FreeSpace":[NSNumber numberWithDouble:totalFreeSpace*(pow(10,-9))],@"TotalSpace":[NSNumber numberWithDouble:totalSpace*(pow(10,-9))],@"UsedSpace":[NSNumber numberWithDouble:usedSpace*(pow(10,-9))]};
    
    return spaceDict;
}


@end
