#import <Preferences/PSListController.h>
#import <TitanD3vUniversal/TitanD3vUniversal.h>

@interface OBButtonTray : UIView
@property (nonatomic,retain) UIVisualEffectView * effectView;
- (void)addButton:(id)arg1;
- (void)addCaptionText:(id)arg1;;
@end

@interface OBBoldTrayButton : UIButton
-(void)setTitle:(id)arg1 forState:(unsigned long long)arg2;
+(id)buttonWithType:(long long)arg1;
@end

@interface OBWelcomeController : UIViewController
@property (nonatomic,retain) UIView * viewIfLoaded;
@property (nonatomic,strong) UIColor * backgroundColor;
- (OBButtonTray *)buttonTray;
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end


@interface PHXPrimraryListController : TDPrimraryController {
  OBWelcomeController *onboardingController;
  OBWelcomeController *updateController;
}

@end
