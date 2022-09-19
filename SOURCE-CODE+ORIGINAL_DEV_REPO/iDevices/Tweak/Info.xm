#import <TitanD3vUniversal/TitanD3vUniversal.h>

static NSString *BID = @"com.TitanD3v.iDevicesPrefs";


@interface SBApplication: NSObject
- (NSString*)bundleIdentifier;
@end


@interface SpringBoard: UIApplication
- (id)_accessibilityFrontMostApplication;
- (void)frontDisplayDidChange: (id)arg1;
-(void)launchTestView;
@end


@interface SBLockScreenManager : NSObject
+ (id)sharedInstance;
- (BOOL)isLockScreenVisible;
- (BOOL)_isPasscodeVisible;
- (BOOL)isUILocked;
- (BOOL)unlockUIFromSource:(int)arg1 withOptions:(id)arg2;
- (void)attemptUnlockWithPasscode:(id)arg1 finishUIUnlock:(BOOL)arg2 completion:(id)arg3;
@end


@interface SBBacklightController : NSObject
@property (nonatomic,readonly) BOOL screenIsOn;
@property (nonatomic,readonly) BOOL screenIsDim;
@end




%hook SpringBoard

- (void)frontDisplayDidChange: (id)arg1 {

	%orig;

	NSString *currentApp = [(SBApplication*)[self _accessibilityFrontMostApplication] bundleIdentifier];

	if (currentApp != nil)  {

		NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"d MMM yy HH:mm"];
		[[TDTweakManager sharedInstance] setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:currentApp ID:BID];

		[[TDTweakManager sharedInstance] setObject:currentApp forKey:@"lastOpenedApp" ID:BID];

	}

}


- (void)applicationDidFinishLaunching: (id)application {
	%orig;

	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"d MMM yy HH:mm"];
	[[TDTweakManager sharedInstance] setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"lastTimeRespring" ID:BID];

}

%end


%hook SBBacklightController
-(void)_animateBacklightToFactor:(float)arg1 duration:(double)arg2 source:(long long)arg3 silently:(BOOL)arg4 completion:(id)arg5 {
	if((arg1==0 && [self screenIsOn])) {

		if (![[%c(SBLockScreenManager) sharedInstance] isLockScreenVisible]) {

			NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"d MMM yy HH:mm"];

			[[TDTweakManager sharedInstance] setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"lastTimeLocked" ID:BID];

		}

	}
	%orig(arg1, arg2, arg3, arg4, arg5);
}


- (void)turnOnScreenFullyWithBacklightSource:(long long)arg1 {

	%orig;

	if ([[%c(SBLockScreenManager) sharedInstance] isLockScreenVisible]) {

		NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"d MMM yy HH:mm"];

		[[TDTweakManager sharedInstance] setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"lastTimeUnlocked" ID:BID];

	}

}

%end
