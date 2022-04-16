#import <UIKit/UIKit.h>
#import "SettingManager.h"


static void invokeHaptic() {
  BOOL enableHaptic = [[SettingManager sharedInstance] boolForKey:@"enableHaptic" defaultValue:NO];

  if (enableHaptic) {
    UIImpactFeedbackGenerator *haptic = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [haptic impactOccurred];
  }
}
