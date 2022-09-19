@interface _UIBatteryView : UIView
@property (nonatomic, assign) CGFloat chargePercent;
@property (nonatomic, assign) CGFloat bodyColorAlpha;
@property (nonatomic, assign) CGFloat pinColorAlpha;
@property (nonatomic, assign) BOOL showsPercentage;
@property (nonatomic, assign) BOOL saverModeActive;
@property (nonatomic, assign) BOOL showsInlineChargingIndicator;
@property (nonatomic, assign) NSInteger chargingState;
@property (nonatomic,copy) UIColor * fillColor;                                                               //@synthesize fillColor=_fillColor - In the implementation block
@property (nonatomic,copy) UIColor * bodyColor;                                                               //@synthesize bodyColor=_bodyColor - In the implementation block
@property (nonatomic,copy) UIColor * pinColor;                                                                //@synthesize pinColor=_pinColor - In the implementation block
@property (nonatomic,copy) UIColor * boltColor; 
@end

@interface BCBatteryDevice : NSObject
@property (nonatomic, strong) id kaiCell;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) long long percentCharge;
@property (nonatomic, assign, getter=isCharging) BOOL charging;
@property (nonatomic, assign, getter=isFake) BOOL fake;
@property (nonatomic, assign, getter=isInternal) BOOL internal;
@property (nonatomic, assign, getter=isBatterySaverModeActive) BOOL batterySaverModeActive;
@property (nonatomic, strong) NSString *identifier;
@end

@interface PSLowPowerModeSettingsDetail
+(void)setEnabled:(BOOL)arg1;
@end