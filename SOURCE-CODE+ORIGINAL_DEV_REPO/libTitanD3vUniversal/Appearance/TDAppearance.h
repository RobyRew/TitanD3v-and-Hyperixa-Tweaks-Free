#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "HEXColour.h"

@interface TDAppearance : NSObject {

  // NSString *navigationBarDefault;
  // NSString *tintDefault;
  // NSString *backgroundDefault;
  // NSString *cellDefault;
  // NSString *labelDefault;
  // NSString *bannerDefault;
  // NSString *containerDefault;
  // NSString *borderDefault;
}

+(instancetype)sharedInstance;
-(id)init;

// -(void)defaultNavigationBarColour:(NSString *)defaultColour;
// -(void)defaultTintColour:(NSString *)defaultColour;
// -(void)defaultBackgroundColour:(NSString *)defaultColour;
// -(void)defaultCellColour:(NSString *)defaultColour;
// -(void)defaultLabelColour:(NSString *)defaultColour;
// -(void)defaultBannerColour:(NSString *)defaultColour;
// -(void)defaultContainerColour:(NSString *)defaultColour;
// -(void)defaultBorderColour:(NSString *)defaultColour;

-(UIColor *)navigationBarColour;
-(UIColor *)tintColour;
-(UIColor *)backgroundColour;
-(UIColor *)cellColour;
-(UIColor *)labelColour;
-(UIColor *)bannerColour;
-(UIColor *)containerColour;
-(UIColor *)borderColour;

@end
