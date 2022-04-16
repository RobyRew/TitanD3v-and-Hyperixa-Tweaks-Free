#import "ARConfiguration+Overrides.h"

@implementation ARConfiguration (Overrides)

- (void)setProvidesAudioData:(BOOL)providesAudioData {
    // prevent this from working, we never want audio data from ARKit
    return;
}

@end
