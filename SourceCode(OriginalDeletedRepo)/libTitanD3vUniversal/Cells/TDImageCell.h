#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@interface TDImageCell : PSTableCell {
  float inset;
}

@property (nonatomic, retain) UIImageView *bannerImage;
@end
