#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <PhotosUI/PhotosUI.h>
#import "ConstraintExtension.h"
#import "TDHeaderView.h"
#import "RecordingButton.h"

@interface AvatarVideoPreviewViewController : UIViewController
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) NSURL *previouslyLoadedVideo;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *videoLayer;
@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, retain) NSURL *videoURL;
@property (nonatomic, retain) NSString *videoName;
@property (nonatomic, retain) UIButton *saveButton;
@property (nonatomic, retain) UIButton *shareButton;
@property (nonatomic, retain) RecordingButton *replayButton;
@end

