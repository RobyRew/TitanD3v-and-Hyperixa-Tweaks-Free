@interface _UIBatteryView (Surge)
-(void)invokeHapticFeedback;
@end 

@interface SBIconController : UIViewController
+(id)sharedInstance;
@end

@interface SpringBoard : NSObject 
-(void)layoutDeviceSize;
-(void)invokeLPMBanner;
-(void)dismissAlert;
-(void)setupLPM;
-(void)dismissWindow;
@end 