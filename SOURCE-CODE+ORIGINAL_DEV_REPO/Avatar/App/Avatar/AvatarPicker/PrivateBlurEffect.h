#import <UIKit/UIKit.h>

@interface _UIBackdropView : UIView
-(id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3 ;
-(id)initWithSettings:(id)arg1 ;
-(id)initWithStyle:(long long)arg1 ;
- (void)setBlurFilterWithRadius:(float)arg1 blurQuality:(id)arg2 blurHardEdges:(int)arg3;
- (void)setBlurFilterWithRadius:(float)arg1 blurQuality:(id)arg2;
- (void)setBlurHardEdges:(int)arg1;
- (void)setBlurQuality:(id)arg1;
- (void)setBlurRadius:(float)arg1;
- (void)setBlurRadiusSetOnce:(BOOL)arg1;
- (void)setBlursBackground:(BOOL)arg1;
- (void)setBlursWithHardEdges:(BOOL)arg1;
@end

@interface _UIBackdropViewSettings : NSObject
@property (assign,getter=isEnabled,nonatomic) BOOL enabled;
@property (assign,nonatomic) double blurRadius;
@property (nonatomic,copy) NSString * blurQuality;
@property (assign,nonatomic) BOOL usesBackdropEffectView;
-(id)initWithDefaultValues;
+(id)settingsForStyle:(long long)arg1 ;
@end
