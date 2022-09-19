#import <UIKit/UIKit.h>
#import "TDColorPickerDelegate.h"
#import "TDColorSpaceType.h"
#import "TDColorCollection.h"   
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDUtilities.h"

#pragma clang diagnostic push  
#pragma clang diagnostic ignored "-Wnullability-completeness"

CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

@interface TDColorPickerViewController : UIViewController <TDColorPickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, retain) UIVisualEffectView *blurEffectView;  
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong, nullable) TDColorCollection *colorCollection;
@property (nonatomic, weak) id <TDColorPickerDelegate> delegate;
@property (nonatomic, retain) NSDictionary *properties;
@property (nonatomic, retain) UIColor *containerColour;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *borderColour;
-(instancetype)initWithColor:(UIColor *)color stackType:(TDColorSpaceType)stackType delegate:(id<TDColorPickerDelegate>)delegate;

@end

