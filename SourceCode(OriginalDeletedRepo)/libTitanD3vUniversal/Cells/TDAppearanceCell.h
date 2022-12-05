#import <Preferences/Preferences.h>
#import "TDAppearanceOptionView.h"

@interface TDAppearanceCell : PSTableCell <TDAppearanceOptionViewDelegate> {
  float inset;
}
@end

@interface PSSpecifier (PrivateMethods)
-(void)performSetterWithValue:(id)value;
-(id)performGetter;
@end
