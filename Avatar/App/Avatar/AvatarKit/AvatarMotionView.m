@import ARKit;
#import "AvatarMotionView.h"
#import "AVTAnimoji.h"
@import SceneKit;
#import <objc/runtime.h>

@implementation AvatarMotionView

- (void)resetTracking {
    ARConfiguration *config = [self.arSession.configuration copy];
    config.providesAudioData = NO;
    [self.arSession runWithConfiguration:config options:ARSessionRunOptionResetTracking|ARSessionRunOptionRemoveExistingAnchors];
}

@end
