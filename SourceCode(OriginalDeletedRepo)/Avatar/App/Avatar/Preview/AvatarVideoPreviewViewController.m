#import "AvatarVideoPreviewViewController.h"

@implementation AvatarVideoPreviewViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self _loadVideoIfNeeded];
    [self generateThumbnail];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.player pause];
    [self.player cancelPendingPrerolls];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    
    [self layoutHeaderView];
    [self layoutVideoView];
    [self layoutActionButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player];
}


-(void)layoutHeaderView {
    
    self.headerView = [[TDHeaderView alloc] initWithTitle:@"Preview" accent:UIColor.systemBlueColor leftIcon:@"xmark" leftAction:@selector(dismissVC)];
    self.headerView.leftButton.backgroundColor = [UIColor colorNamed:@"Secondary"];
    [self.view addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 75)];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];
}


- (void)layoutVideoView {
    
    self.videoView = [UIView new];
    self.videoView.layer.cornerRadius = 25;
    self.videoView.layer.cornerCurve = kCACornerCurveContinuous;
    self.videoView.clipsToBounds = YES;
    [self.view addSubview:self.videoView];
    
    [self.videoView size:CGSizeMake(self.view.frame.size.width-40, self.view.frame.size.width-40)];
    [self.videoView x:self.view.centerXAnchor];
    [self.videoView top:self.headerView.bottomAnchor padding:30];
}


-(void)layoutActionButton {
    
    self.saveButton = [[UIButton alloc] init];
    self.saveButton.backgroundColor = [UIColor.systemBlueColor colorWithAlphaComponent:0.4];
    self.saveButton.layer.cornerRadius = 15;
    self.saveButton.layer.cornerCurve = kCACornerCurveContinuous;
    [self.saveButton setTitle:@"Save Video" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(saveAvatarVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.view addSubview:self.saveButton];
    
    [self.saveButton size:CGSizeMake(self.view.frame.size.width-100, 50)];
    [self.saveButton x:self.view.centerXAnchor];
    [self.saveButton top:self.videoView.bottomAnchor padding:25];
    
    
    self.shareButton = [[UIButton alloc] init];
    self.shareButton.backgroundColor = [UIColor.systemBlueColor colorWithAlphaComponent:0.4];
    self.shareButton.layer.cornerRadius = 15;
    self.shareButton.layer.cornerCurve = kCACornerCurveContinuous;
    [self.shareButton setTitle:@"Share Video" forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareAvatarVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.view addSubview:self.shareButton];
    
    [self.shareButton size:CGSizeMake(self.view.frame.size.width-100, 50)];
    [self.shareButton x:self.view.centerXAnchor];
    [self.shareButton top:self.saveButton.bottomAnchor padding:15];
    
    
    self.replayButton = [[RecordingButton alloc] initWithIcon:@"play.fill" accent:[UIColor.systemBlueColor colorWithAlphaComponent:0.6] action:@selector(togglePlaying)];
    self.replayButton.layer.cornerRadius = 35;
    self.replayButton.alpha = 0;
    [self.view addSubview:self.replayButton];
    
    [self.replayButton size:CGSizeMake(70, 70)];
    [self.replayButton x:self.videoView.centerXAnchor y:self.videoView.centerYAnchor];
}


- (void)_loadVideoIfNeeded {
    
    if (!self.videoURL || !self.isViewLoaded) return;
    
    if ([self.previouslyLoadedVideo isEqual:self.videoURL]) return;
    
    self.previouslyLoadedVideo = self.videoURL;
    
    [self.videoLayer removeFromSuperlayer];
    [self.player pause];
    [self.player cancelPendingPrerolls];
    
    self.player = [AVPlayer playerWithURL:self.videoURL];
    self.videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.videoLayer.frame = self.videoView.bounds;
    [self.videoView.layer addSublayer:self.videoLayer];
    
    [self.player play];
}


-(void)togglePlaying {
    
    [self.player play];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.replayButton.alpha = 0;
    });
    
}


-(void)saveAvatarVideo {
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^ {
        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:self.videoURL];
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


-(void)shareAvatarVideo {
    
    if (!self.videoURL) return;
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[self.videoURL] applicationActivities:nil];
    
    [activityController setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (!completed || !activityType) return;
    }];
    [self presentViewController:activityController animated:YES completion:nil];
}


-(void)generateThumbnail {
    
    NSArray *existingPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,
                                                                YES);
    NSString *documentsPath = [existingPath objectAtIndex:0];
    NSString *myPath = [documentsPath stringByAppendingPathComponent:@"/Thumbnails"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:myPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:myPath withIntermediateDirectories:NO
                                                   attributes:nil error:NULL];
    }
    
    
    NSString *videoURLString = self.videoURL.absoluteString;
    
    self.videoName = videoURLString.lastPathComponent;
    
    NSURL *videoURL = [NSURL fileURLWithPath:videoURLString];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    
    NSError *err = NULL;
    CMTime thumbTime = CMTimeMakeWithSeconds(0,02);
    CGSize maxSize = CGSizeMake(425,425);
    generator.maximumSize = maxSize;
    
    CGImageRef imgRef = [generator copyCGImageAtTime:thumbTime actualTime:NULL error:&err];
    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:imgRef];
    
    NSData *data = UIImagePNGRepresentation(thumbnail);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *newFileName = [NSString stringWithFormat:@"/Thumbnails/%@.png", self.videoName];
    
    NSString *dirs = [documentsDirectory stringByAppendingPathComponent:newFileName];
    
    [data writeToFile:dirs atomically:YES];
    
}


-(void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)itemDidFinishPlaying:(NSNotification *) notification {
    [self.player seekToTime:kCMTimeZero];
    self.replayButton.alpha = 1;
}

@end
