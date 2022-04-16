#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "HomeViewController.h"
#import "HomeNavigationViewController.h"

static BOOL toggleiDevices;
static BOOL toggleStatusbarLongPressGesture;
static BOOL toggleStatusbarDoubleTapGesture;
static BOOL toggleStatusbarTripleTapGesture;
static BOOL toggleDockGesture;
static BOOL toggleVolumeUpGesture;
static BOOL toggleVolumeDownGesture;
static BOOL toggleShakeGesture;


@interface _UIStatusBar : UIView
@end

@interface SpringBoard : NSObject
@property (nonatomic, assign) BOOL didPressed;
@end

@interface SBDockView : UIView
@end


%group IdeviceVC
%hook SpringBoard

- (void)applicationDidFinishLaunching: (id)application {
	%orig;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePresentNotification:) name:@"iDevicesPresentVCNotification" object:nil];
}


%new
- (void)receivePresentNotification:(NSNotification *) notification {

	if ([[notification name] isEqualToString:@"iDevicesPresentVCNotification"]) {
		UIViewController *controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
		HomeViewController *vc = [[HomeViewController alloc] init];
		HomeNavigationViewController *nvc = [[HomeNavigationViewController alloc] initWithRootViewController:vc];
		[controller presentViewController:nvc animated:YES completion:nil];
	}
}

%end
%end


%group IdeviceStatusbar
%hook _UIStatusBar

-(void)willMoveToSuperview:(UIView *)newSuperview {
	%orig(newSuperview);

	if (toggleStatusbarLongPressGesture) {
		[self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(presentVC)]];
	}

	if (toggleStatusbarDoubleTapGesture) {
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentVC)];
		tapGesture.numberOfTapsRequired = 2;
		[self addGestureRecognizer:tapGesture];
	}

	if (toggleStatusbarTripleTapGesture) {
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentVC)];
		tapGesture.numberOfTapsRequired = 2;
		[self addGestureRecognizer:tapGesture];
	}

}


%new
-(void)presentVC {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"iDevicesPresentVCNotification" object:self];
}

%end
%end


%group IdeviceShake
%hook UIWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	%orig;
	if(event.type == UIEventSubtypeMotionShake && self == [[UIApplication sharedApplication] keyWindow]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"iDevicesPresentVCNotification" object:self];
	}
}

%end
%end


%group IdeviceDock
%hook SBDockView
-(void)layoutSubviews {
	%orig;

	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentVC)];
	tapGesture.numberOfTapsRequired = 2;
	[self addGestureRecognizer:tapGesture];

}

%new
-(void)presentVC {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"iDevicesPresentVCNotification" object:self];
}

%end
%end


%group IdeviceVolumeUp
%hook SpringBoard
%property (nonatomic, assign) BOOL didPressed;

-(BOOL)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1 {

	UIPress *touch = [arg1.allPresses anyObject];

	if (touch.type == 102) { // 102 up, 103 down

		if (touch.force == 1) {

			self.didPressed = YES;
			[self performSelector:@selector(monitorGesturePressed) withObject:nil afterDelay:0.25f];

		} else {

			self.didPressed = NO;
		}
	}

	return %orig;
}

%new
-(void)monitorGesturePressed {

	if (self.didPressed)
	[self performSelector:@selector(presentVC)];
}

%new
-(void)presentVC {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"iDevicesPresentVCNotification" object:self];
}

%end
%end


%group IdeviceVolumeDown
%hook SpringBoard
%property (nonatomic, assign) BOOL didPressed;

-(BOOL)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1 {

	UIPress *touch = [arg1.allPresses anyObject];

	if (touch.type == 103) { // 102 up, 103 down

		if (touch.force == 1) {

			self.didPressed = YES;
			[self performSelector:@selector(monitorGesturePressed) withObject:nil afterDelay:0.25f];

		} else {

			self.didPressed = NO;
		}
	}

	return %orig;
}

%new
-(void)monitorGesturePressed {

	if (self.didPressed)
	[self performSelector:@selector(presentVC)];
}

%new
-(void)presentVC {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"iDevicesPresentVCNotification" object:self];
}

%end
%end


void SettingsChanged() {

	toggleiDevices = [[TDTweakManager sharedInstance] boolForKey:@"toggleiDevices" defaultValue:NO ID:@"com.TitanD3v.iDevicesPrefs"];
	toggleStatusbarLongPressGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleStatusbarLongPressGesture" defaultValue:YES ID:@"com.TitanD3v.iDevicesPrefs"];
	toggleStatusbarDoubleTapGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleStatusbarDoubleTapGesture" defaultValue:NO ID:@"com.TitanD3v.iDevicesPrefs"];
	toggleStatusbarTripleTapGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleStatusbarTripleTapGesture" defaultValue:NO ID:@"com.TitanD3v.iDevicesPrefs"];
	toggleDockGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleDockGesture" defaultValue:NO ID:@"com.TitanD3v.iDevicesPrefs"];
	toggleVolumeUpGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleVolumeUpGesture" defaultValue:NO ID:@"com.TitanD3v.iDevicesPrefs"];
	toggleVolumeDownGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleVolumeDownGesture" defaultValue:NO ID:@"com.TitanD3v.iDevicesPrefs"];
	toggleShakeGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleShakeGesture" defaultValue:NO ID:@"com.TitanD3v.iDevicesPrefs"];

}

%ctor {

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.iDevicesPrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	SettingsChanged();

	if (toggleiDevices) {
		%init(IdeviceVC);

		if (toggleStatusbarLongPressGesture || toggleStatusbarDoubleTapGesture || toggleStatusbarTripleTapGesture) {
			%init(IdeviceStatusbar);
		}

		if (toggleDockGesture) {
			%init(IdeviceDock);
		}

		if (toggleShakeGesture) {
			%init(IdeviceShake);
		}

		if (toggleVolumeDownGesture) {
			%init(IdeviceVolumeDown);
		}

		if (toggleVolumeUpGesture) {
			%init(IdeviceVolumeUp);
		}

	}
}
