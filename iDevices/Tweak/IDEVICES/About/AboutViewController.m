#import "AboutViewController.h"

@implementation AboutViewController

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
    
    [self getInfoData];
    [self layoutHeaderView];
    [self layoutCollectionView];
}


-(void)getInfoData {
    
    self.generalArray = [[AboutDeviceInfo sharedInstance] generalArray];
    self.networkArray = [[AboutDeviceInfo sharedInstance] networkArray];
    self.batteryArray = [[AboutDeviceInfo sharedInstance] batteryArray];
    self.accessoriesArray = [[AboutDeviceInfo sharedInstance] accessoriesArray];
    self.screenArray = [[AboutDeviceInfo sharedInstance] screenArray];
    self.processorArray = [[AboutDeviceInfo sharedInstance] processorArray];
    self.motionArray = [[AboutDeviceInfo sharedInstance] motionArray];
    self.localisationArray = [[AboutDeviceInfo sharedInstance] localisationArray];
    self.debugArray = [[AboutDeviceInfo sharedInstance] debugArray];
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
    self.headerIcon.image = [UIImage systemImageNamed:@"info.circle.fill"];
    self.headerIcon.tintColor = UIColor.coverIconColour;
    [self.containerView addSubview:self.headerIcon];
    
    [self.headerIcon size:CGSizeMake(75, 75)];
    [self.headerIcon x:self.containerView.centerXAnchor];
    [self.headerIcon top:self.headerView.bottomAnchor padding:-10];
    
    
    self.headerTitle = [[UILabel alloc] init];
    self.headerTitle.textAlignment = NSTextAlignmentCenter;
    self.headerTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    self.headerTitle.textColor = UIColor.coverTitleColour;
    self.headerTitle.text = @"About";
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
    [self.collectionView registerClass:[AboutCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[SectionCellHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView top:self.containerView.bottomAnchor padding:0];
    [self.collectionView leading:self.view.leadingAnchor padding:0];
    [self.collectionView trailing:self.view.trailingAnchor padding:0];
    [self.collectionView bottom:self.view.bottomAnchor padding:-5];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 9;
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
            headerView.headerLabel.text = @"Network";
        } else if (indexPath.section == 2) {
            headerView.headerLabel.text = @"Battery";
        } else if (indexPath.section == 3) {
            headerView.headerLabel.text = @"Accessories";
        } else if (indexPath.section == 4) {
            headerView.headerLabel.text = @"Screen";
        } else if (indexPath.section == 5) {
            headerView.headerLabel.text = @"Processors";
        } else if (indexPath.section == 6) {
            headerView.headerLabel.text = @"Motion";
        } else if (indexPath.section == 7) {
            headerView.headerLabel.text = @"Localisation";
        } else if (indexPath.section == 8) {
            headerView.headerLabel.text = @"Debug";
        }
        reusableview = headerView;
    }
    
    return reusableview;
    
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.generalArray.count;
    } else if (section == 1) {
        return self.networkArray.count;
    } else if (section == 2) {
        return self.batteryArray.count;
    } else if (section == 3) {
        return self.accessoriesArray.count;
    } else if (section == 4) {
        return self.screenArray.count;
    } else if (section == 5) {
        return self.processorArray.count;
    } else if (section == 6) {
        return self.motionArray.count;
    } else if (section == 7) {
        return self.localisationArray.count;
    } else {
        return self.debugArray.count;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    AboutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;
    
    if (indexPath.section == 0) {
        
        InfoModel *info = self.generalArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
    } else if (indexPath.section == 1) {
        
        InfoModel *info = self.networkArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
    } else if (indexPath.section == 2) {
        
        InfoModel *info = self.batteryArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
    } else if (indexPath.section == 3) {
        
        InfoModel *info = self.accessoriesArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
    } else if (indexPath.section == 4) {
        
        InfoModel *info = self.screenArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
    } else if (indexPath.section == 5) {
        
        InfoModel *info = self.processorArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
    } else if (indexPath.section == 6) {
        
        InfoModel *info = self.motionArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
    } else if (indexPath.section == 7) {
        
        InfoModel *info = self.localisationArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
    } else if (indexPath.section == 8) {
        
        InfoModel *info = self.debugArray[indexPath.row];
        cell.iconView.backgroundColor = [info.colour colorWithAlphaComponent:0.4];
        cell.iconImage.tintColor = info.colour;
        cell.iconImage.image = [UIImage systemImageNamed:info.icon];
        cell.titleLabel.text = info.title;
        cell.subtitleLabel.text = info.subtitle;
        
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
    
    if (indexPath.section == 0) {
        
        InfoModel *info = self.generalArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    } else if (indexPath.section == 1) {
        
        InfoModel *info = self.networkArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    } else if (indexPath.section == 2) {
        
        InfoModel *info = self.batteryArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    } else if (indexPath.section == 3) {
        
        InfoModel *info = self.accessoriesArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    } else if (indexPath.section == 4) {
        
        InfoModel *info = self.screenArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    } else if (indexPath.section == 5) {
        
        InfoModel *info = self.processorArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    } else if (indexPath.section == 6) {
        
        InfoModel *info = self.motionArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    } else if (indexPath.section == 7) {
        
        InfoModel *info = self.localisationArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    } else if (indexPath.section == 8) {
        
        InfoModel *info = self.debugArray[indexPath.row];
        NSString *title = info.title;
        NSString *subtitle = info.subtitle;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@\n%@", title, subtitle];
        [self showAlertWithTitle:@"" subtitle:[NSString stringWithFormat:@"The details for %@ was copied to your clipboard.", title]];
        
    }
    
}


-(void)pushBackVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
