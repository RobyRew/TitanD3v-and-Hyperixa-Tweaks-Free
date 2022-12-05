#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@interface TDDescriptionCell : PSTableCell <UITextViewDelegate> {
  float inset;
}

@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UITextView *descriptionTextView;
@property (nonatomic, retain) UIColor *labelColour;

@end
