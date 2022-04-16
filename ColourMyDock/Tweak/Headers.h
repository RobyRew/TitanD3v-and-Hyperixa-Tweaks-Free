@interface SBDockView : UIView <UIColorPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
-(void)presentColourPickerVC;
-(void)presentImagePickerVC;
@end

@interface SBFloatingDockPlatterView : UIView <UIColorPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
-(double)maximumContinuousCornerRadius;
-(void)presentColourPickerVC;
-(void)presentImagePickerVC;
@end

@interface SBWallpaperEffectView : UIView
@property (nonatomic,retain) UIView * blurView;
@end

@interface MTMaterialLayer : CALayer
@end

@interface MTMaterialView : UIView
@property (getter=_materialLayer,nonatomic,readonly) MTMaterialLayer *materialLayer;
@property (assign, nonatomic) double weighting;
@end

@interface _UIBackdropEffectView : UIView
@end

@interface _UIBackdropView ()
@property (nonatomic, retain) _UIBackdropEffectView * backdropEffectView;
-(double)_cornerRadius;
@end

@interface SBIconController : UIViewController
+(id)sharedInstance;
@end