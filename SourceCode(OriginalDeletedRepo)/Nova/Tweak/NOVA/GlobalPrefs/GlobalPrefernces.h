#import <TitanD3vUniversal/TitanD3vUniversal.h>

static NSString *BID = @"com.TitanD3v.NovaPrefs";
static BOOL toggleCustomColour;
static BOOL toggleHaptic;
static NSInteger hapticStrength;
static NSString *senderName;
static NSData *senderAvatarImage = nil;
static BOOL showComposeTips;
static BOOL toggleWallpaper;
static NSData *wallpaperImage = nil;

static void loadPrefs() {

  toggleCustomColour = [[TDTweakManager sharedInstance] boolForKey:@"toggleCustomColour" defaultValue:NO ID:BID];
  toggleHaptic = [[TDTweakManager sharedInstance] boolForKey:@"toggleHaptic" defaultValue:YES ID:BID];
  hapticStrength = [[TDTweakManager sharedInstance] intForKey:@"hapticStrength" defaultValue:0 ID:BID];
  senderName = [[TDTweakManager sharedInstance] objectForKey:@"senderName" defaultValue:@"You" ID:BID];
  senderAvatarImage = [[TDTweakManager sharedInstance] objectForKey:@"senderAvatarImage" defaultValue:nil ID:BID];
  showComposeTips = [[TDTweakManager sharedInstance] boolForKey:@"showComposeTips" defaultValue:YES ID:BID];
  toggleWallpaper = [[TDTweakManager sharedInstance] boolForKey:@"toggleWallpaper" defaultValue:NO ID:BID];
  wallpaperImage = [[TDTweakManager sharedInstance] objectForKey:@"wallpaperImage" defaultValue:nil ID:BID];
}
