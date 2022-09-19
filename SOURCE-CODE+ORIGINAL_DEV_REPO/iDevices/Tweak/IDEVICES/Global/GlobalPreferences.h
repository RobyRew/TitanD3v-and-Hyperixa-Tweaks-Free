#import <TitanD3vUniversal/TitanD3vUniversal.h>

static NSString *BID = @"com.TitanD3v.iDevicesPrefs";


static BOOL toggleCustomColour;
static BOOL toggleHapticFeedback;
static NSInteger hapticFeedbackStrength;
static BOOL toggleCustomCoverImage;
static NSData *customCoverImage = nil;

static void loadPrefs() {

  toggleCustomColour = [[TDTweakManager sharedInstance] boolForKey:@"toggleCustomColour" defaultValue:NO ID:BID];
  toggleHapticFeedback = [[TDTweakManager sharedInstance] boolForKey:@"toggleHapticFeedback" defaultValue:YES ID:BID];
  hapticFeedbackStrength = [[TDTweakManager sharedInstance] intForKey:@"hapticFeedbackStrength" defaultValue:0 ID:BID];
  toggleCustomCoverImage = [[TDTweakManager sharedInstance] boolForKey:@"toggleCustomCoverImage" defaultValue:NO ID:BID];
  customCoverImage = [[TDTweakManager sharedInstance] objectForKey:@"customCoverImage" ID:BID];
}


static void invokeHaptic() {
    
    toggleHapticFeedback = [[TDTweakManager sharedInstance] boolForKey:@"toggleHapticFeedback" defaultValue:YES ID:BID];
    hapticFeedbackStrength = [[TDTweakManager sharedInstance] intForKey:@"hapticFeedbackStrength" defaultValue:0 ID:BID];
    
    if (toggleHapticFeedback) {
        UIImpactFeedbackGenerator *haptic;
        if (hapticFeedbackStrength == 0) {
            haptic = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        } else if (hapticFeedbackStrength == 1) {
            haptic = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        } else if (hapticFeedbackStrength == 2) {
            haptic = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
        }
        [haptic impactOccurred];
    }
}































//static BOOL toggleParadise;
//static NSString *appdataAppearance;
//static BOOL toggleAppdataColour;
//static BOOL toggleAppdataBackgroundImage;
//static NSData *appdataBackgroundImage = nil;
//static BOOL toggleAppdataHaptic;
//static NSInteger appdataHapticStrength;
//static BOOL toggleAppdataCustomFont;
//static NSData *appdataCustomFont;
//static BOOL toggleBlurEffect;
//static float bottomSheetCornerRadius;
//static BOOL toggle3DMenu;
//static BOOL showSBTutorial;
//
//static void loadPrefs() {
//
//  toggleParadise = [[TDTweakManager sharedInstance] boolForKey:@"toggleParadise" defaultValue:NO ID:BID];
//  appdataAppearance = [[TDTweakManager sharedInstance] objectForKey:@"appdataAppearance" defaultValue:@"appdataLight" ID:BID];
//  toggleAppdataColour = [[TDTweakManager sharedInstance] boolForKey:@"toggleAppdataColour" defaultValue:NO ID:BID];
//  toggleAppdataBackgroundImage = [[TDTweakManager sharedInstance] boolForKey:@"toggleAppdataBackgroundImage" defaultValue:NO ID:BID];
//  appdataBackgroundImage = [[TDTweakManager sharedInstance] objectForKey:@"appdataBackgroundImage" ID:BID];
//  toggleAppdataHaptic = [[TDTweakManager sharedInstance] boolForKey:@"toggleAppdataHaptic" defaultValue:YES ID:BID];
//  appdataHapticStrength = [[TDTweakManager sharedInstance] intForKey:@"appdataHapticStrength" defaultValue:0 ID:BID];
//  toggleAppdataCustomFont = [[TDTweakManager sharedInstance] boolForKey:@"toggleAppdataCustomFont" defaultValue:NO ID:BID];
//  appdataCustomFont = [[TDTweakManager sharedInstance] objectForKey:@"appdataCustomFont" ID:BID];
//  toggleBlurEffect = [[TDTweakManager sharedInstance] boolForKey:@"toggleBlurEffect" defaultValue:YES ID:BID];
//  bottomSheetCornerRadius = [[TDTweakManager sharedInstance] floatForKey:@"bottomSheetCornerRadius" defaultValue:30 ID:BID];
//  toggle3DMenu = [[TDTweakManager sharedInstance] boolForKey:@"toggle3DMenu" defaultValue:NO ID:BID];
//  showSBTutorial = [[TDTweakManager sharedInstance] boolForKey:@"showSBTutorial" defaultValue:YES ID:BID];
//}
