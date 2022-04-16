#import <UIKit/UIKit.h>

@interface UninstallAppList : NSObject
+ (NSMutableArray *)allApps;
+ (NSMutableArray *)userApps;
+ (NSMutableArray *)systemApps;
+ (NSMutableArray *)audioApps;
+(NSMutableArray*)sortArray:(NSMutableArray*)arrayToSort;
@end