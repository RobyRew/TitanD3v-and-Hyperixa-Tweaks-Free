#import "BannerView.h"

static float FontSize;

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

    loadPrefs();

    self.layer.cornerRadius = 20;
    self.clipsToBounds = true;


    if([surgeInterfaceAppearance isEqualToString:@"surgeLight"]) {

      self.layer.shadowColor = UIColor.lightGrayColor.CGColor;
      self.layer.shadowOpacity = 0.5;
      self.layer.shadowOffset = CGSizeMake(0.0,0.0);
      self.layer.shadowRadius = 3.0;
      self.layer.masksToBounds = false;
    }

    [self updatingInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatingInfoNotification:) name:@"SurgePresented" object:nil];
    [self layoutViews];

  }
  return self;
}


-(void)updatingInfoNotification:(NSNotification *)notification {

  if ([[notification name] isEqualToString:@"SurgePresented"]) {
    [self updatingInfo];
  }

}


-(void)layoutViews {

  self.baseView = [[SURBlurBaseView alloc] initWithFrame:self.bounds];
  self.baseView.layer.cornerRadius = 20;
  self.baseView.clipsToBounds = true;
  [self addSubview:self.baseView];


  self.enableButton = [[UIButton alloc] init];
  self.enableButton.layer.cornerRadius = 25;
  self.enableButton.clipsToBounds = true;
  UIImage *enableImage = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/Surge.bundle/Assets/enable.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.enableButton setImage:enableImage forState:UIControlStateNormal];
  self.enableButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
  [self.enableButton addTarget:self action:@selector(enableLPM) forControlEvents:UIControlEventTouchUpInside];
  [self.baseView addSubview:self.enableButton];

  self.enableButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.enableButton.widthAnchor constraintEqualToConstant:50.0].active = YES;
  [self.enableButton.heightAnchor constraintEqualToConstant:50.0].active = YES;
  [[self.enableButton centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
  [self.enableButton.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-10].active = YES;


  self.disableButton = [[UIButton alloc] init];
  self.disableButton.layer.cornerRadius = 25;
  self.disableButton.clipsToBounds = true;
  UIImage *disableImage = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/Surge.bundle/Assets/disable.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.disableButton setImage:disableImage forState:UIControlStateNormal];
  self.disableButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
  [self.disableButton addTarget:self action:@selector(disableLPM) forControlEvents:UIControlEventTouchUpInside];
  [self.baseView addSubview:self.disableButton];

  self.disableButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.disableButton.widthAnchor constraintEqualToConstant:50.0].active = YES;
  [self.disableButton.heightAnchor constraintEqualToConstant:50.0].active = YES;
  [[self.disableButton centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
  [self.disableButton.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-70].active = YES;


  self.batteryBaseView = [[UIView alloc] init];
  self.batteryBaseView.layer.cornerRadius = 30;
  [self.baseView addSubview:self.batteryBaseView];

  self.batteryBaseView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.batteryBaseView.widthAnchor constraintEqualToConstant:60.0].active = YES;
  [self.batteryBaseView.heightAnchor constraintEqualToConstant:60.0].active = YES;
  [[self.batteryBaseView centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
  [self.batteryBaseView.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10].active = YES;


  self.battery = [[_UIBatteryView alloc] init];
  self.battery.showsInlineChargingIndicator = YES;
  [self.batteryBaseView addSubview:self.battery];

  self.battery.translatesAutoresizingMaskIntoConstraints = false;
  [self.battery.widthAnchor constraintEqualToConstant:20].active = YES;
  [self.battery.heightAnchor constraintEqualToConstant:10].active = YES;
  [self.battery.centerYAnchor constraintEqualToAnchor:self.batteryBaseView.centerYAnchor constant:-3].active = YES;
  [self.battery.centerXAnchor constraintEqualToAnchor:self.batteryBaseView.centerXAnchor constant:-3].active = true;


  self.percentageLabel = [[UILabel alloc] init];
  self.percentageLabel.textColor = [UIColor surgeFontColor];
  self.percentageLabel.font = [UIFont systemFontOfSize:7];
  self.percentageLabel.textAlignment = NSTextAlignmentCenter;
  [self.battery addSubview:self.percentageLabel];

  self.percentageLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[self.percentageLabel centerXAnchor] constraintEqualToAnchor:self.batteryBaseView.centerXAnchor].active = true;
  [self.percentageLabel.topAnchor constraintEqualToAnchor:self.battery.bottomAnchor constant:3].active = YES;


    if (iPhone_6_8) {
        FontSize = 11;
    } else if (iPhone_6_8_Plus) {
        FontSize = 14;
    } else if (iPhone_X_XS_11Pro) {
        FontSize = 11;
    } else if (iPhone_XR_XS_11Pro) {
        FontSize = 14;
    } else if (iPhone_12_Pro) {
FontSize = 11;
    } else if (iPhone_12_mini) {
FontSize = 11;
    } else if (iPhone_12_Pro_Max) {
FontSize = 14;
    }

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textColor = [UIColor surgeFontColor];
  self.titleLabel.font = [UIFont boldSystemFontOfSize:FontSize];
  self.titleLabel.text = @"Enable Low Power Mode";
  self.titleLabel.textAlignment = NSTextAlignmentLeft;
  [self.baseView addSubview:self.titleLabel];

  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[self.titleLabel centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
  [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.batteryBaseView.trailingAnchor constant:10].active = YES;


  if (toggleColourScheme) {
    self.disableButton.tintColor = [UIColor surgeIconColor];
    self.enableButton.tintColor = [UIColor surgeIconColor];
    self.disableButton.backgroundColor = [UIColor surgeDisableColor];
    self.enableButton.backgroundColor = [UIColor surgeEnableColor];
    self.batteryBaseView.backgroundColor = [UIColor surgeContainerColor];

  } else {
    self.disableButton.tintColor = UIColor.whiteColor;
    self.enableButton.tintColor = UIColor.whiteColor;
    self.disableButton.backgroundColor = UIColor.systemRedColor;
    self.enableButton.backgroundColor = UIColor.systemGreenColor;

    if([surgeInterfaceAppearance isEqualToString:@"surgeLight"]) {
      self.batteryBaseView.backgroundColor = [UIColor colorWithRed: 0.90 green: 0.90 blue: 0.92 alpha: 0.5];
    } else if([surgeInterfaceAppearance isEqualToString:@"surgeDark"]) {
      self.batteryBaseView.backgroundColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.2];
    }

  }

}


-(void)updatingInfo {

  UIDevice *myDevice = [UIDevice currentDevice];
  [myDevice setBatteryMonitoringEnabled:YES];

  double batteryUsage = [myDevice batteryLevel] * 100;

  NSString * batteryLevelLabel1 = [NSString stringWithFormat:@"%.f%%", batteryUsage];

  self.battery.chargePercent = (batteryUsage * 0.01);
  self.percentageLabel.text = batteryLevelLabel1;


  if (toggleColourScheme) {

    self.battery.bodyColor = [UIColor surgeBodyColor];
    self.battery.pinColor = [UIColor surgePinColor];

  } else {


    if([surgeInterfaceAppearance isEqualToString:@"surgeLight"]) {
      self.battery.bodyColor = UIColor.blackColor;
      self.battery.pinColor = UIColor.blackColor;
    } else if([surgeInterfaceAppearance isEqualToString:@"surgeDark"]) {
      self.battery.bodyColor = UIColor.whiteColor;
      self.battery.pinColor = UIColor.whiteColor;
    }

  }

}


-(void)disableLPM {

  [[NSNotificationCenter defaultCenter] postNotificationName:@"DismissLPMAlert" object:self];
  [self invokeHapticFeedback];
}


-(void)enableLPM {

  BOOL isEnabled = [[NSProcessInfo processInfo] isLowPowerModeEnabled];
  [%c(PSLowPowerModeSettingsDetail) setEnabled:!isEnabled];

  [[NSNotificationCenter defaultCenter] postNotificationName:@"DismissLPMAlert" object:self];
  [self invokeHapticFeedback];
}


-(void)invokeHapticFeedback {

  if (toggleHaptic) {

    if (surgeHapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (surgeHapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (surgeHapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }

  }
}

@end
