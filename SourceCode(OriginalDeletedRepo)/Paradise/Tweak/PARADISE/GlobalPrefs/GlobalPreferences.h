#import <TitanD3vUniversal/TitanD3vUniversal.h>

static NSString *BID = @"com.TitanD3v.ParadisePrefs";

static BOOL toggleParadise;
static NSString *appdataAppearance;
static BOOL toggleAppdataColour;
static BOOL toggleAppdataBackgroundImage;
static NSData *appdataBackgroundImage = nil;
static BOOL toggleAppdataHaptic;
static NSInteger appdataHapticStrength;
static BOOL toggleAppdataCustomFont;
static NSData *appdataCustomFont;
static BOOL toggleBlurEffect;
static float bottomSheetCornerRadius;
static BOOL toggle3DMenu;
static BOOL showSBTutorial;

static void loadPrefs() {

  toggleParadise = [[TDTweakManager sharedInstance] boolForKey:@"toggleParadise" defaultValue:NO ID:BID];
  appdataAppearance = [[TDTweakManager sharedInstance] objectForKey:@"appdataAppearance" defaultValue:@"appdataLight" ID:BID];
  toggleAppdataColour = [[TDTweakManager sharedInstance] boolForKey:@"toggleAppdataColour" defaultValue:NO ID:BID];
  toggleAppdataBackgroundImage = [[TDTweakManager sharedInstance] boolForKey:@"toggleAppdataBackgroundImage" defaultValue:NO ID:BID];
  appdataBackgroundImage = [[TDTweakManager sharedInstance] objectForKey:@"appdataBackgroundImage" ID:BID];
  toggleAppdataHaptic = [[TDTweakManager sharedInstance] boolForKey:@"toggleAppdataHaptic" defaultValue:YES ID:BID];
  appdataHapticStrength = [[TDTweakManager sharedInstance] intForKey:@"appdataHapticStrength" defaultValue:0 ID:BID];
  toggleAppdataCustomFont = [[TDTweakManager sharedInstance] boolForKey:@"toggleAppdataCustomFont" defaultValue:NO ID:BID];
  appdataCustomFont = [[TDTweakManager sharedInstance] objectForKey:@"appdataCustomFont" ID:BID];
  toggleBlurEffect = [[TDTweakManager sharedInstance] boolForKey:@"toggleBlurEffect" defaultValue:YES ID:BID];
  bottomSheetCornerRadius = [[TDTweakManager sharedInstance] floatForKey:@"bottomSheetCornerRadius" defaultValue:30 ID:BID];
  toggle3DMenu = [[TDTweakManager sharedInstance] boolForKey:@"toggle3DMenu" defaultValue:NO ID:BID];
  showSBTutorial = [[TDTweakManager sharedInstance] boolForKey:@"showSBTutorial" defaultValue:YES ID:BID];
}
