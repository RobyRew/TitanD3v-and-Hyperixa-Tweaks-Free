#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Preferences/Preferences.h>
#import "TDAppearance.h"

@interface TDListController : PSListItemsController
@property (nonatomic, retain) UIColor *navigationBarColour;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *backgroundColour;
@property (nonatomic, retain) UIColor *cellsColour;
@property (nonatomic, retain) UIColor *labelColour;
@end  
