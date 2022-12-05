#import "LibraryViewController.h"

@implementation LibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    
    self.videoArray = [[LibraryDataSource sharedInstance] thumbnailData];
    
    [self layoutHeaderView];
    [self layoutCollectionView];
    [self checkVideoCount];
}


-(void)layoutHeaderView {
    
    self.headerView = [[TDHeaderView alloc] initWithTitle:@"Library" accent:UIColor.systemBlueColor leftIcon:@"chevron.left" leftAction:@selector(dismissVC)];
    self.headerView.grabberView.alpha = 0;
    self.headerView.leftButton.backgroundColor = [UIColor colorNamed:@"Secondary"];
    [self.view addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 55)];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];
    
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightBold];
    self.messageLabel.textColor = UIColor.tertiaryLabelColor;
    self.messageLabel.numberOfLines = 2;
    self.messageLabel.text = @"You don't have any \nvideo available";
    self.messageLabel.alpha = 0;
    [self.view addSubview:self.messageLabel];
    
    [self.messageLabel x:self.view.centerXAnchor y:self.view.centerYAnchor];
    [self.messageLabel leading:self.view.leadingAnchor padding:20];
    [self.messageLabel trailing:self.view.trailingAnchor padding:-20];
}


-(void)layoutCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[LibraryCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView leading:self.view.leadingAnchor padding:0];
    [self.collectionView trailing:self.view.trailingAnchor padding:0];
    [self.collectionView top:self.headerView.bottomAnchor padding:15];
    [self.collectionView bottom:self.view.bottomAnchor padding:0];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videoArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    LibraryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;
    
    NSString *thumbnailFile = [self.videoArray objectAtIndex:indexPath.row];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *finalPath = [NSString stringWithFormat:@"/Thumbnails/%@", thumbnailFile];
    NSString *thumbnailPath = [documentsDirectory stringByAppendingPathComponent:finalPath];
    
    cell.thumbnailImage.image = [UIImage imageWithContentsOfFile:thumbnailPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"Video %li", indexPath.row +1];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width-40, 90);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *videoFile = [self.videoArray objectAtIndex:indexPath.row];
    NSString *videoName = [videoFile stringByReplacingOccurrencesOfString:@".png" withString:@""];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *finalPath = [NSString stringWithFormat:@"/Recordings/%@", videoName];
    NSString *thumbnailPath = [documentsDirectory stringByAppendingPathComponent:finalPath];
    
    NSURL *videoURL = [NSURL fileURLWithPath:thumbnailPath];
    
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    playerViewController.player = player;
    [self presentViewController:playerViewController animated:YES completion:nil];
    [playerViewController.player play];
    
}


- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
        cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
        cell.alpha = 0.5;
    } completion:nil];
    
}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
        cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
        cell.alpha = 1;
    } completion:nil];
    
}


- (UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {
    
    UIContextMenuConfiguration* config = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu* _Nullable(NSArray<UIMenuElement*>* _Nonnull suggestedActions) {
        
        UIAction *saveAction = [UIAction actionWithTitle:@"Save Video" image:[UIImage systemImageNamed:@"icloud.and.arrow.down.fill"] identifier:nil handler:^(UIAction *action) {
            
            NSString *videoFile = [self.videoArray objectAtIndex:indexPath.row];
            NSString *videoName = [videoFile stringByReplacingOccurrencesOfString:@".png" withString:@""];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *finalVideoPath = [NSString stringWithFormat:@"/Recordings/%@", videoName];
            NSString *videoPath = [documentsDirectory stringByAppendingPathComponent:finalVideoPath];
            
            [self saveVideoWithString:videoPath];
            
        }];
        
        
        UIAction *shareAction = [UIAction actionWithTitle:@"Share Video" image:[UIImage systemImageNamed:@"square.and.arrow.up.fill"] identifier:nil handler:^(UIAction *action) {
            
            NSString *videoFile = [self.videoArray objectAtIndex:indexPath.row];
            NSString *videoName = [videoFile stringByReplacingOccurrencesOfString:@".png" withString:@""];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *finalPath = [NSString stringWithFormat:@"/Recordings/%@", videoName];
            NSString *videoPath = [documentsDirectory stringByAppendingPathComponent:finalPath];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self shareVideoWithString:videoPath];
            });
            
        }];
        
        
        UIAction *deleteAction = [UIAction actionWithTitle:@"Delete Video" image:[UIImage systemImageNamed:@"trash.fill"] identifier:nil handler:^(UIAction *action) {
            
            NSString *videoFile = [self.videoArray objectAtIndex:indexPath.row];
            NSString *videoName = [videoFile stringByReplacingOccurrencesOfString:@".png" withString:@""];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *finalVideoPath = [NSString stringWithFormat:@"/Recordings/%@", videoName];
            NSString *videoPath = [documentsDirectory stringByAppendingPathComponent:finalVideoPath];
            
            
            NSString *thumbnailFile = [self.videoArray objectAtIndex:indexPath.row];
            NSString *documentsDirectory2 = [paths objectAtIndex:0];
            NSString *finalThumbnailPath = [NSString stringWithFormat:@"/Thumbnails/%@", thumbnailFile];
            NSString *thumbnailPath = [documentsDirectory2 stringByAppendingPathComponent:finalThumbnailPath];
            
            [self deleteVideoWithString:videoPath];
            [self deleteThumbnailWithString:thumbnailPath];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self refreshData];
            });
            
        }];
        deleteAction.attributes = UIMenuElementAttributesDestructive;
        
        return [UIMenu menuWithTitle:@"" children:@[saveAction, shareAction, deleteAction]];
        
    }];
    
    return config;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,10,0,10);
}


-(void)shareVideoWithString:(NSString *)video {
    
    NSURL *videoURL = [NSURL fileURLWithPath:video];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[videoURL] applicationActivities:nil];
    
    [activityController setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (!completed || !activityType) return;
    }];
    [self presentViewController:activityController animated:YES completion:nil];
    
}


-(void)saveVideoWithString:(NSString *)video {
    
    NSURL *url = [NSURL URLWithString:video];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^ {
        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
    } completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"Movie saved to camera roll.");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self showAlertWithTitle:@"Successful!" subtitle:@"The video was saved to your photo library."];
            });
        } else {
            NSLog(@"Could not save movie to camera roll. Error: %@", error);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self showAlertWithTitle:@"Failed!" subtitle:@"The video failed to save to your photo library."];
            });
        }
    }];
    
}


-(void)deleteVideoWithString:(NSString *)video {
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:video error:&error];
}


-(void)deleteThumbnailWithString:(NSString *)thumbnail {
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:thumbnail error:&error];
}


-(void)refreshData {
    
    self.videoArray = [[LibraryDataSource sharedInstance] thumbnailData];
    [self.collectionView reloadData];
    [self checkVideoCount];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)checkVideoCount {
    if (self.videoArray.count == 0) {
        self.messageLabel.alpha = 1;
    } else {
        self.messageLabel.alpha = 0;
    }
}


-(void)dismissVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
