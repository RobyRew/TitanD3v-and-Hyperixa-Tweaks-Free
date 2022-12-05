#import <AppSupport/CPDistributedMessagingCenter.h>
#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "./NOVA/ColourScheme/Colour-Scheme.h"
#import <rocketbootstrap/rocketbootstrap.h>
#import "./NOVA/Blur/FloatingBlurView.h"
#import "./NOVA/ActiveScheduleVC.h"
#import "ScheduleManager.h"


@interface SpringBoard : NSObject
-(void)loadSchedules;
-(void)launchTestView;
@end

@interface PCSimpleTimer : NSObject {
  NSRunLoop* _timerRunLoop;
}
-(id)userInfo;
-(void)scheduleInRunLoop:(id)arg1 ;
-(id)initWithFireDate:(id)arg1 serviceIdentifier:(id)arg2 target:(id)arg3 selector:(SEL)arg4 userInfo:(id)arg5 ;
- (void)invalidate;
@end

@interface SMSScheuler : NSObject
- (NSNumber *)sendText:(NSDictionary *)vals;
@end

@interface SSender : NSObject
@property (strong) CPDistributedMessagingCenter * messagingCenter;
- (id)init;
- (BOOL)sendText:(NSString *)body toPhn:(NSString *)address withAttachments:(NSArray*)files;
@end

@interface UIApplication (NOVA)
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
@end

@interface SBAirplaneModeController : NSObject
+(id)sharedInstance;
-(BOOL)isInAirplaneMode;
-(void)setInAirplaneMode:(BOOL)arg1 ;
@end