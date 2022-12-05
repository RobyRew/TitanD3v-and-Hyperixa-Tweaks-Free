#import "TDPrefsManager.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

static UIImpactFeedbackGenerator *hapticFeedback;

static void invokeHapticFeedback () {

    hapticFeedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [hapticFeedback impactOccurred];
}
