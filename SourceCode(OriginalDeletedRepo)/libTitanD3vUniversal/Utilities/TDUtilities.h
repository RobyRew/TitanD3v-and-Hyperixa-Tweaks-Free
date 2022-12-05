#import <UIKit/UIKit.h>
#import <spawn.h>

@interface TDUtilities : NSObject 
+(instancetype)sharedInstance;
-(id)init;

-(void)respring;
-(void)safemode;
-(void)reboot;
-(void)uicache;
-(NSString *)systemVersion;
-(NSString *)deviceName;
-(NSString *)deviceModel;
-(NSString *)timeWithFormat:(NSString *)string;
-(NSString *)dateWithFormat:(NSString *)string;
-(NSString *)greeting;
-(NSString *)battery;
-(void)launchURL:(NSString *)string;
-(void)launchApp:(NSString *)string;
-(void)haptic:(NSInteger)style;
@end 

@interface UIApplication (TD)
-(BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2;
@end