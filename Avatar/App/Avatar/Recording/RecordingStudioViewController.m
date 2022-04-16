#import "RecordingStudioViewController.h"


@implementation RecordingStudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    
    [self layoutWallpaper];
    [self layoutAvatarMotionView];
    [self layoutHeaderView];
    [self layoutActionView];
    [self layoutStickerTools];
    [self layoutCollectionView];
    
    BOOL showOnboarding = [[SettingManager sharedInstance] boolForKey:@"didShowRecordingOnboarding" defaultValue:NO];
    
    if (!showOnboarding) {
        [self presentOnboarding];
    }
}


-(void)layoutWallpaper {
    
    self.wallpaper = [[UIImageView alloc] init];
    self.wallpaper.contentMode = UIViewContentModeScaleAspectFill;
    self.wallpaper.clipsToBounds = YES;
    self.wallpaper.alpha = 0;
    [self.view addSubview:self.wallpaper];
    
    [self.wallpaper fill];
}


- (void)layoutAvatarMotionView {
    
    if (self.avatarMotionView) return;
    
    self.avatarMotionView = [[AvatarMotionView alloc] init];
    self.avatarMotionView.alpha = 0;
    self.avatarMotionView.frame = self.view.bounds;
    self.avatarMotionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.avatarMotionView.backgroundColor = [UIColor colorNamed:@"Primary"];
    [self.view addSubview:self.avatarMotionView];
    
    
    if (self.avatarInstance) [self.avatarMotionView setAvatar:self.avatarInstance];
    
    [self.avatarMotionView resetTracking];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.avatarMotionView.alpha = 1;
    }];
    
}


- (void)setPuppetName:(NSString *)puppetName {
    _puppetName = [puppetName copy];
    self.avatarInstance = (AVTAvatarInstance *)[AVTAnimoji animojiNamed:_puppetName];
}


- (void)setAvatar:(id)avatar {
    self.avatarInstance = (AVTAvatarInstance *)avatar;
}


- (void)setAvatarInstance:(AVTAvatarInstance *)avatarInstance {
    _avatarInstance = avatarInstance;
    [self.avatarMotionView setAvatar:_avatarInstance];
}


-(void)layoutHeaderView {
    
    self.headerView = [[TDHeaderView alloc] initWithTitle:@"Studio" accent:UIColor.systemBlueColor leftIcon:@"chevron.left" leftAction:@selector(dismissVC)];
    self.headerView.grabberView.alpha = 0;
    self.headerView.leftButton.backgroundColor = [UIColor colorNamed:@"Secondary"];
    [self.view addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 55)];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];
}

-(void)layoutActionView {
    
    self.actionView = [[UIView alloc] init];
    self.actionView.backgroundColor = [UIColor colorNamed:@"Secondary"];
    self.actionView.layer.cornerRadius = 25;
    self.actionView.layer.cornerCurve = kCACornerCurveContinuous;
    self.actionView.layer.maskedCorners = 3;
    [self.view addSubview:self.actionView];
    
    [self.actionView size:CGSizeMake(self.view.frame.size.width, 130)];
    [self.actionView x:self.view.centerXAnchor];
    [self.actionView bottom:self.view.bottomAnchor padding:0];
    
    
    self.stopButton = [[RecordingButton alloc] initWithIcon:@"stop.fill" accent:UIColor.systemRedColor action:@selector(stopRecording)];
    self.stopButton.layer.cornerRadius = 35;
    self.stopButton.alpha = 0;
    [self.actionView addSubview:self.stopButton];
    
    [self.stopButton size:CGSizeMake(70, 70)];
    [self.stopButton x:self.actionView.centerXAnchor y:self.actionView.centerYAnchor];
    
}


-(void)layoutCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[RecordingActionMenuCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.actionView addSubview:self.collectionView];
    
    [self.collectionView height:80];
    [self.collectionView width:300];
    [self.collectionView x:self.actionView.centerXAnchor];
    [self.collectionView top:self.actionView.topAnchor padding:15];
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    RecordingActionMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;
    
    if (indexPath.row == 0) {
        
        cell.iconView.backgroundColor = [UIColor.systemRedColor colorWithAlphaComponent:0.3];
        cell.iconImage.image = [UIImage systemImageNamed:@"record.circle"];
        cell.iconImage.tintColor = UIColor.systemRedColor;
        cell.titleLabel.text = @"Record";
        
    } else if (indexPath.row == 1) {
        
        cell.iconView.backgroundColor = [UIColor.systemYellowColor colorWithAlphaComponent:0.3];
        cell.iconImage.image = [UIImage systemImageNamed:@"photo.fill"];
        cell.iconImage.tintColor = UIColor.systemYellowColor;
        cell.titleLabel.text = @"Wallpaper";
        
    } else if (indexPath.row == 2) {
        
        cell.iconView.backgroundColor = [UIColor.systemOrangeColor colorWithAlphaComponent:0.3];
        cell.iconImage.image = [UIImage systemImageNamed:@"paintpalette.fill"];
        cell.iconImage.tintColor = UIColor.systemOrangeColor;
        cell.titleLabel.text = @"Colour";
        
    } else if (indexPath.row == 3) {
        
        cell.iconView.backgroundColor = [UIColor.systemIndigoColor colorWithAlphaComponent:0.3];
        cell.iconImage.image = [UIImage systemImageNamed:@"face.smiling.fill"];
        cell.iconImage.tintColor = UIColor.systemIndigoColor;
        cell.titleLabel.text = @"Stickers";
        
    } else if (indexPath.row == 4) {
        
        cell.iconView.backgroundColor = [UIColor.systemRedColor colorWithAlphaComponent:0.3];
        cell.iconImage.image = [UIImage systemImageNamed:@"trash.fill"];
        cell.iconImage.tintColor = UIColor.systemRedColor;
        cell.titleLabel.text = @"Reset";
        
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 80);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self prepareRecording];
    } else if (indexPath.row == 1) {
        [self presentImagePickerVC];
    } else if (indexPath.row == 2) {
        [self presentColourPickerVC];
    } else if (indexPath.row == 3) {
        [self presentStickersPickerVC];
    } else if (indexPath.row == 4) {
        [self reset];
    }
}


-(void)layoutStickerTools {
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.avatarMotionView addGestureRecognizer:tapRecognizer];
}


-(void)prepareRecording {
    
    [self.avatarMotionView resetTracking];
    
    if (self.recordingManager.isRecording) {
        [self stopRecording];
    } else {
        [self startRecording];
    }
    
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkRecordingStatus) userInfo:nil repeats:YES];
    }
    
}


-(void)checkRecordingStatus {
    
    if (self.recordingManager.isRecording) {
        self.collectionView.alpha = 0;
        self.stopButton.alpha = 1;
    } else {
        self.collectionView.alpha = 1;
        self.stopButton.alpha = 0;
    }
    
}


- (void)startRecording {
    
    self.recordingManager = [RecordingManager new];
    self.recordingManager.delegate = self;
    
    [RPScreenRecorder sharedRecorder].microphoneEnabled = YES;
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"ASDemoMode"]) {
        [self.recordingManager startRecordingWithAudio:YES frontCameraPreview:NO];
    }
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}


- (void)stopRecording {
    
    [self.recordingManager stopRecording];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [self.timer invalidate];
    self.timer = nil;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2f animations:^{
            self.collectionView.alpha = 1;
            self.stopButton.alpha = 0;
        }];
    });
}


- (void)recordingManager:(RecordingManager *)coordinator recordingDidFailWithError:(NSError *)error {
    NSString *errorMessage = (error.localizedDescription) ? error.localizedDescription : @"Unknown error";
    NSString *message = [NSString stringWithFormat:@"Sorry, the recording failed.\n%@", errorMessage];
    NSLog(@"%@%@", errorMessage, message);
}


- (void)recordingManager:(RecordingManager *)coordinator wantsToPresentRecordingPreviewWithController:(__kindof UIViewController *)previewController {
}


- (void)recordingManagerDidFinishRecording:(RecordingManager *)coordinator {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        AvatarVideoPreviewViewController *vc = [[AvatarVideoPreviewViewController alloc] init];
        vc.videoURL = self.recordingManager.videoURL;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    });
    
}


-(void)presentImagePickerVC {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = false;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    self.avatarMotionView.backgroundColor = UIColor.clearColor;
    self.wallpaper.alpha = 1;
    self.wallpaper.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)presentColourPickerVC {
    UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
    colourPickerVC.delegate = self;
    colourPickerVC.selectedColor = self.avatarMotionView.backgroundColor;
    colourPickerVC.supportsAlpha = NO;
    [self presentViewController:colourPickerVC animated:YES completion:nil];
}


- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{
    self.wallpaper.alpha = 0;
    UIColor *cpSelectedColour = viewController.selectedColor;
    self.avatarMotionView.backgroundColor = cpSelectedColour;
}


- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{
    self.wallpaper.alpha = 0;
    UIColor *cpSelectedColour = viewController.selectedColor;
    self.avatarMotionView.backgroundColor = cpSelectedColour;
}


-(void)presentStickersPickerVC {
    
    if (self.numberOfStickers == 5) {
        [self showAlertWithTitle:@"Sorry!" subtitle:@"You can only use up to 5 stickers 🙁"];
    } else {
        
        TDStickerPickerViewController *vc = [[TDStickerPickerViewController alloc] init];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
}


- (void)didDismissedStickersPicker {
}


- (void)didSelectSticker:(NSString *)sticker {
    
    NSInteger add = self.numberOfStickers+1;
    self.numberOfStickers = add;
    
    StickerView *stickerView = [[StickerView alloc] initWithContentFrame:CGRectMake(0, 0, 150, 150) contentImage:[UIImage imageNamed:sticker]];
    stickerView.center = self.view.center;
    stickerView.enabledControl = NO;
    stickerView.enabledBorder = NO;
    stickerView.delegate = self;
    stickerView.tag = self.numberOfStickers;
    [self.view addSubview:stickerView];
}


- (void)stickerViewDidTapDeleteControl:(StickerView *)stickerView {
    NSInteger sub = self.numberOfStickers-1;
    self.numberOfStickers = sub;
}


- (void)stickerViewDidTapContentView:(StickerView *)stickerView {
    
    if (self.selectedSticker) {
        self.selectedSticker.enabledBorder = NO;
        self.selectedSticker.enabledControl = NO;
    }
    self.selectedSticker = stickerView;
    self.selectedSticker.enabledBorder = YES;
    self.selectedSticker.enabledControl = YES;
}


- (void)tapBackground:(UITapGestureRecognizer *)recognizer {
    if (self.selectedSticker) {
        self.selectedSticker.enabledControl = NO;
        self.selectedSticker.enabledBorder = NO;
        self.selectedSticker = nil;
    }
}


- (UIImage *)stickerView:(StickerView *)stickerView imageForRightTopControl:(CGSize)recommendedSize {
    return [UIImage imageNamed:@"btn_smile"];
}


- (UIImage *)stickerView:(StickerView *)stickerView imageForLeftBottomControl:(CGSize)recommendedSize {
    return [UIImage imageNamed:@"btn_flip"];
}


- (void)stickerViewDidTapLeftBottomControl:(StickerView *)stickerView {
    UIImageOrientation targetOrientation = (stickerView.contentImage.imageOrientation == UIImageOrientationUp ? UIImageOrientationUpMirrored : UIImageOrientationUp);
    UIImage *invertImage = [UIImage imageWithCGImage:stickerView.contentImage.CGImage scale:1.0 orientation:targetOrientation];
    stickerView.contentImage = invertImage;
}


- (void)stickerViewDidTapRightTopControl:(StickerView *)stickerView {
    [_animator removeAllBehaviors];
    UISnapBehavior * snapbehavior = [[UISnapBehavior alloc] initWithItem:stickerView snapToPoint:self.view.center];
    snapbehavior.damping = 0.65;
    [self.animator addBehavior:snapbehavior];
}


-(void)reset {
    
    self.wallpaper.alpha = 0;
    [self.avatarMotionView resetTracking];
    self.avatarMotionView.backgroundColor = [UIColor colorNamed:@"Primary"];
    
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[StickerView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    self.numberOfStickers = 0;
    
}


-(void)dismissVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)presentOnboarding {
    RecordingOnboardingViewController *vc = [[RecordingOnboardingViewController alloc] init];
    vc.modalInPresentation = YES;
    [self presentViewController:vc animated:YES completion:nil];
}


//-(void)testMethod {
//
////    CGRect frames = CGRectMake(0, 0, 200, 200);
//
//    CGRect frames = CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height-90);
//
//    UIViewController *vc = [[UIViewController alloc] init];
//
//    vc.view.backgroundColor = UIColor.whiteColor;
//
//    UIImageView *img = [[UIImageView alloc] initWithFrame:frames];
//    //img.image = [self getScreenShot:frames];
//
//    UIImage *image2 = [self.avatarMotionView snapshot];
//    img.image = image2;
//
//    [vc.view addSubview:img];
//
//    [self presentViewController:vc animated:YES completion:nil];
//
//}


//- (UIImage *)getScreenShot:(CGRect)captureFrame  {
//    //UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGRect rect = captureFrame;
//    //UIGraphicsBeginImageContextWithOptions(rect.size, self.view.opaque, 0.0);
//    //UIGraphicsBeginImageContext(rect.size);
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self.view.layer renderInContext:context];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
//}

@end
