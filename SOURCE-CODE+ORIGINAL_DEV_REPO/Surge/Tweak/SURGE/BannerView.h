#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "SURBlurBaseView.h"
#import "Battery.h"
#import "Global-Preferences.h"
#import "Colour-Scheme.h"

@interface BannerView : UIView
@property (nonatomic, retain) SURBlurBaseView *baseView;
@property (nonatomic, retain) UIButton *disableButton;
@property (nonatomic, retain) UIButton *enableButton;
@property (nonatomic, retain) UIView *batteryBaseView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, strong) _UIBatteryView *battery;
@property (nonatomic, retain) UILabel *percentageLabel;
@end
