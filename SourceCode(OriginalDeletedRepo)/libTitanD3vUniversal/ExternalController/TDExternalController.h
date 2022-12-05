
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Preferences/Preferences.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "TDUtilities.h"
#import "GlobalPrefs.h"
#import "TDGridCell.h"

@interface TDExternalController : PSListController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, retain) UIVisualEffectView *blurEffectView;  
@property (nonatomic, retain) UIColor *navigationBarColour;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *backgroundColour;
@property (nonatomic, retain) UIColor *cellsColour;
@property (nonatomic, retain) UIColor *labelColour;

@end
