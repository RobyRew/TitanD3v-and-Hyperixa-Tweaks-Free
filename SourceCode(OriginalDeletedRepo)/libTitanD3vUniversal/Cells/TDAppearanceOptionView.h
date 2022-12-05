#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@class TDAppearanceOptionView;
@protocol TDAppearanceOptionViewDelegate <NSObject>
-(void)selectedOption:(TDAppearanceOptionView *)option;
@end

@interface TDAppearanceOptionView : UIView
@property (nonatomic, weak) id<TDAppearanceOptionViewDelegate> delegate;
@property (nonatomic, retain) id appearanceOption;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, retain) UIImageView *previewImageView;
@property (nonatomic, retain) UIImage *previewImage;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIColor *tintColour;
-(id)initWithFrame:(CGRect)frame appearanceOption:(id)option;
-(void)updateViewForAppearance:(NSString *)style;
@end
