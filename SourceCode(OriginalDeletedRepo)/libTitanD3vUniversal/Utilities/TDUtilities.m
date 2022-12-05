#import "TDUtilities.h"

UIImpactFeedbackGenerator *haptic;

@implementation TDUtilities

+(instancetype)sharedInstance {
  static TDUtilities *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[TDUtilities alloc] init];
  });
  return sharedInstance;
}

-(id)init {
  return self;
}

-(void)respring {
  pid_t pid;
  int status;
  const char* args[] = {"sbreload", NULL};
  posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
  waitpid(pid, &status, WEXITED);
}

-(void)safemode {
  pid_t pid;
  int status;
  const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
  posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
  waitpid(pid, &status, WEXITED);
}

-(void)reboot {
  pid_t pid;
  int status;
  const char* args[] = {"mobileldrestart", NULL};
  posix_spawn(&pid, "/usr/bin/mobileldrestart", NULL, NULL, (char* const*)args, NULL);
  waitpid(pid, &status, WEXITED);
}

-(void)uicache{
  pid_t pid;
  int status;
  const char* args[] = {"uicache", NULL};
  posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)args, NULL);
  waitpid(pid, &status, WEXITED);
}

-(NSString *)systemVersion {
  NSString *string = [[UIDevice currentDevice] systemVersion];
  return string;
}

-(NSString *)deviceName {
  NSString *string = [[UIDevice currentDevice] name];
  return string;
}

-(NSString *)deviceModel {
  NSString *string = [[UIDevice currentDevice] model];
  return string;
}

-(NSString*)timeWithFormat:(NSString*)string {

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSString *dateFormat = string;

  NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  [dateFormatter setLocale:enUSPOSIXLocale];
  [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];

  [dateFormatter setDateFormat:dateFormat];
  NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];

  return timeString;
}

-(NSString*)dateWithFormat:(NSString*)string {

  NSDate *today = [NSDate date];
  NSDateFormatter *dformat = [[NSDateFormatter alloc] init];
  [dformat setDateFormat:string];

  NSString *dateString = [dformat stringFromDate:today];

  return dateString;
}

-(NSString *)greeting {

  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:[NSDate date]];
  NSInteger currentHour = [components hour];

  NSString *greetingMessage;

  if (currentHour >= 0 && currentHour < 12) {
    greetingMessage = @"Good Morning";
  } else if (currentHour >= 12 && currentHour < 17) {
    greetingMessage = @"Good Afternoon";
  } else if (currentHour >= 17 && currentHour < 21) {
    greetingMessage = @"Good Evening";
  } else {
    greetingMessage = @"Good Night";
  }

  return greetingMessage;
}

-(NSString *)battery {

  UIDevice *myDevice = [UIDevice currentDevice];
  [myDevice setBatteryMonitoringEnabled:YES];

  double remainingBattery = [myDevice batteryLevel] * 100;

  NSString * batteryLevel = [NSString stringWithFormat:@"%.f%%", remainingBattery];

  return batteryLevel;
}

-(void)launchURL:(NSString *)string {

  UIApplication *application = [UIApplication sharedApplication];
  NSURL *URL = [NSURL URLWithString:string];
  [application openURL:URL options:@{} completionHandler:nil];
}

-(void)launchApp:(NSString *)string {
  [[UIApplication sharedApplication] launchApplicationWithIdentifier:string suspended:0];
}

-(void)haptic:(NSInteger)style {

  if (style == 0) {
    haptic = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
  } else if (style == 1) {
    haptic = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
  } else if (style == 2) {
    haptic = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
  }

  [haptic impactOccurred];
}

@end
