#import "BatteryViewController.h"

NSArray *connectedBluetoothDevices;
BCBatteryDevice *currentDevice;

@implementation BatteryViewController

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


    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"BCBatteryDeviceControllerConnectedDevicesDidChange" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"UIDeviceBatteryLevelDidChangeNotification" object:device];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"UIDeviceBatteryStateDidChangeNotification" object:device];


    [self getBatteryData];
    [self layoutHeaderView];
    [self layoutCollectionView];
}


-(void)getBatteryData {
    // self.connectedBluetoothDevices = [[NSMutableArray alloc] init];
    // [self.connectedBluetoothDevices addObject:@"Hi1"];
    // [self.connectedBluetoothDevices addObject:@"Hi1"];
    // [self.connectedBluetoothDevices addObject:@"Hi1"];
    // [self.connectedBluetoothDevices addObject:@"Hi1"];
    // [self.connectedBluetoothDevices addObject:@"Hi1"];

    connectedBluetoothDevices = [[%c(BCBatteryDeviceController) sharedInstance] connectedDevices];
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
    self.headerIcon.image = [UIImage systemImageNamed:@"battery.100"];
    self.headerIcon.tintColor = UIColor.coverIconColour;
    [self.containerView addSubview:self.headerIcon];
    
    [self.headerIcon size:CGSizeMake(75, 75)];
    [self.headerIcon x:self.containerView.centerXAnchor];
    [self.headerIcon top:self.headerView.bottomAnchor padding:-10];
    
    
    self.headerTitle = [[UILabel alloc] init];
    self.headerTitle.textAlignment = NSTextAlignmentCenter;
    self.headerTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    self.headerTitle.textColor = UIColor.coverTitleColour;
    self.headerTitle.text = @"Battery";
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
    [self.collectionView registerClass:[BatteryCell class] forCellWithReuseIdentifier:@"Cell"];
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
        if ([connectedBluetoothDevices count] > 0) {
            headerView.headerLabel.text = [NSString stringWithFormat:@"%lu Devices", [connectedBluetoothDevices count]];
        } else {
            headerView.headerLabel.text = @"No Devices";
        }
        reusableview = headerView;
    }
    
    return reusableview;
    
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return connectedBluetoothDevices.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    BatteryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;
    
    //cell.secondLabel.text = @"Hello";
    
    // cell.deviceLabel.text = @"iPhone";
    // cell.batteryLabel.text = @"80%";
    // cell.nameLabel.text = @"SGWC's iPhone";


    currentDevice = connectedBluetoothDevices[indexPath.row];

    cell.deviceImage.image = [[UIImageView alloc] initWithImage:[currentDevice batteryWidgetGlyph]].image;
    cell.deviceLabel.text = [NSString stringWithFormat: @"%@", [self getDeviceName:[[[currentDevice batteryWidgetGlyph] imageAsset] assetName]]];
    NSString *percentageString = @"%";
    cell.batteryLabel.text = [NSString stringWithFormat: @"%lld%@", [currentDevice percentCharge], percentageString];
    cell.nameLabel.text = [currentDevice name];

    
    
    [UIView animateWithDuration:0.1 animations:^{
        
        // NSArray *testArray = [[NSArray alloc] initWithObjects:@"37", @"10", @"80", @"75", @"95", nil];
        
        // NSString *batteryValue = [testArray objectAtIndex:indexPath.row];
        
        double batteryPercentage = [currentDevice percentCharge];
        
        cell.usageView.value = batteryPercentage;
        cell.usageView.maxValue = 100;
        
        
        if (batteryPercentage <20) {
            cell.usageView.progressColor = [UIColor batteryLowColour];
            cell.usageView.progressStrokeColor = [UIColor batteryLowColour];
            cell.batteryLabel.textColor = [UIColor batteryLowColour];
        } else {
            cell.usageView.progressColor = [UIColor batteryNormalColour];
            cell.usageView.progressStrokeColor = [UIColor batteryNormalColour];
            cell.batteryLabel.textColor = [UIColor batteryNormalColour];
        }
        

        
    }];
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width  = self.view.frame.size.width /2 -30;
    return CGSizeMake(width, 100);
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


-(void)pushBackVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSString*)getDeviceName: (NSString*)assetName {

		if([assetName containsString: @"case"] || [assetName containsString: @"r7x"]) return @"Case";
		else if([assetName containsString: @"iphone"]) return @"iPhone";
		else if(([assetName containsString: @"airpods"] || [assetName containsString: @"b298"]) && [assetName containsString: @"left"] && [assetName containsString: @"right"]) return @"Airpods";
		else if(([assetName containsString: @"airpods"] || [assetName containsString: @"b298"]) && [assetName containsString: @"left"]) return @"L Airpod";
		else if(([assetName containsString: @"airpods"] || [assetName containsString: @"b298"]) && [assetName containsString: @"right"]) return @"R Airpod";
		else if([assetName containsString: @"ipad"]) return @"iPad";
		else if([assetName containsString: @"watch"]) return @"Watch";
		else if([assetName containsString: @"beats"] && [assetName containsString: @"left"] && [assetName containsString: @"right"]) return @"Beats";
		else if([assetName containsString: @"beatspro"] && [assetName containsString: @"left"]) return @"L Beats";
		else if([assetName containsString: @"beatspro"] && [assetName containsString: @"right"]) return @"R Beats";
		else if([assetName containsString: @"beats"] || [assetName containsString: @"b419"] || [assetName containsString: @"b364"]) return @"Beats";
		else if([assetName containsString: @"gamecontroller"]) return @"Controller";
		else if([assetName containsString: @"pencil"]) return @"Pencil";
		else if([assetName containsString: @"ipod"]) return @"iPod";
		else if([assetName containsString: @"mouse"] || [assetName containsString: @"a125"]) return @"Mouse";
		else if([assetName containsString: @"trackpad"]) return @"Trackpad";
		else if([assetName containsString: @"keyboard"]) return @"Keyboard";
		else return @"Device";
	}

@end
