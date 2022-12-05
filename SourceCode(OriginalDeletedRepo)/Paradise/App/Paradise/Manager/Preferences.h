#import <UIKit/UIKit.h>

static NSMutableDictionary *settings;
static NSString *prefPath = @"/var/mobile/Library/Preferences/com.TitanD3v.ParadiseEditor.plist";

static NSString *themeFolderName;
static NSString *bundleID;
static NSString *appName;
static BOOL showTutorial;

static void loadPrefs() {
  settings = [NSMutableDictionary dictionary];
  [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];

  themeFolderName = [settings objectForKey:@"selectedThemesName"];
  bundleID = [settings objectForKey:@"paradiseBundleID"];
  appName = [settings objectForKey:@"paradiseAppName"];
}
