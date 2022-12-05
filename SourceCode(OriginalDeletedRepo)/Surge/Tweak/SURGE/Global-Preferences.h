#import <TitanD3vUniversal/TitanD3vUniversal.h>

static NSString *BID = @"com.TitanD3v.SurgePrefs";

static BOOL toggleSurge;
static NSString *surgeInterfaceAppearance;
static BOOL toggleColourScheme;
static BOOL toggleHaptic;
static NSInteger surgeHapticStrength;
static BOOL showSBTutorial;

static void loadPrefs() {

  toggleSurge = [[TDTweakManager sharedInstance] boolForKey:@"toggleSurge" defaultValue:NO ID:BID];
  showSBTutorial = [[TDTweakManager sharedInstance] boolForKey:@"showSBTutorial" defaultValue:YES ID:BID];
  surgeInterfaceAppearance = [[TDTweakManager sharedInstance] objectForKey:@"surgeInterfaceAppearance" defaultValue:@"surgeLight" ID:BID];
  toggleColourScheme = [[TDTweakManager sharedInstance] boolForKey:@"toggleColourScheme" defaultValue:NO ID:BID];
  toggleHaptic = [[TDTweakManager sharedInstance] boolForKey:@"toggleHaptic" defaultValue:YES ID:BID];
  surgeHapticStrength = [[TDTweakManager sharedInstance] intForKey:@"surgeHapticStrength" defaultValue:0 ID:BID];

}