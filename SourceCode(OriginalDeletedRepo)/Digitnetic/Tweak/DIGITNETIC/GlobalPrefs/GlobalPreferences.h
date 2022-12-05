#import <TitanD3vUniversal/TitanD3vUniversal.h>

static NSString *BID = @"com.TitanD3v.DigitneticPrefs";

static BOOL toggleDigitnetic;
static NSString *digitneticAppearance;
static BOOL toggleCalculatorColour;
static BOOL toggleKeypadColour;
static BOOL toggleHaptic;
static NSInteger hapticStrength;
static BOOL toggleKeypadBackgroundImage;
static BOOL toggleCalculatorBackgroundImage;
static NSData *keypadBackgroundImage = nil;
static NSData *calculatorBackgroundImage = nil;
static BOOL showSBTutorial;

static void loadPrefs() {

  toggleDigitnetic = [[TDTweakManager sharedInstance] boolForKey:@"toggleDigitnetic" defaultValue:NO ID:BID];
  digitneticAppearance = [[TDTweakManager sharedInstance] objectForKey:@"digitneticAppearance" defaultValue:@"digitneticLight" ID:BID];
  toggleCalculatorColour = [[TDTweakManager sharedInstance] boolForKey:@"toggleCalculatorColour" defaultValue:NO ID:BID];
  toggleKeypadColour = [[TDTweakManager sharedInstance] boolForKey:@"toggleKeypadColour" defaultValue:NO ID:BID];
  toggleKeypadBackgroundImage = [[TDTweakManager sharedInstance] boolForKey:@"toggleKeypadBackgroundImage" defaultValue:NO ID:BID];
  toggleCalculatorBackgroundImage = [[TDTweakManager sharedInstance] boolForKey:@"toggleCalculatorBackgroundImage" defaultValue:NO ID:BID];
  keypadBackgroundImage = [[TDTweakManager sharedInstance] objectForKey:@"keypadBackgroundImage" ID:BID];
  calculatorBackgroundImage = [[TDTweakManager sharedInstance] objectForKey:@"calculatorBackgroundImage" ID:BID];
  toggleHaptic = [[TDTweakManager sharedInstance] boolForKey:@"toggleHaptic" defaultValue:YES ID:BID];
  hapticStrength = [[TDTweakManager sharedInstance] intForKey:@"hapticStrength" defaultValue:0 ID:BID];
  showSBTutorial = [[TDTweakManager sharedInstance] boolForKey:@"showSBTutorial" defaultValue:YES ID:BID];
}
