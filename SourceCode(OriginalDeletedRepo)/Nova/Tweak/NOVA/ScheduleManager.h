#import <TitanD3vUniversal/TitanD3vUniversal.h>
//[Black NewCodeStarts] replace your file with this file's code

@interface ScheduleManager : NSObject
@property (nonatomic, retain) NSMutableDictionary *scheduleMsgs;
+(instancetype)sharedInstance;
-(id)init;

-(NSString*)getUDID;

-(NSDate*)getTodaysDate;
-(NSString*)dateToStr:(NSDate*)date;

-(void)saveAvatarWithPhn:(NSString*)phoneNumber;

-(NSMutableDictionary*)getAllSchedules;
-(NSMutableArray*)getSentSchedules;
-(NSMutableArray*)getTodaysSchedules;
-(NSMutableArray*)getFutureSchedules;

-(void)deleteScheduleWithId:(NSString*)withID;
-(void)addScheduleWithId:(NSString*)withID data:(NSDictionary*)data;

-(NSString*)getTimeLeft:(NSDate*)date1;
-(NSDate*)strToDate:(NSString*)dateStr;
-(NSMutableArray*)sortedSchedules:(NSMutableArray*)arrayToSort;

-(void)markMsgAsSentWithId:(NSString*)withID data:(NSDictionary*)data;

-(void)saveAttachtedImagesWithId:(NSString*)withID attachedImages:(NSArray*)images;
-(NSMutableArray*)arrangeAttachedWithId:(NSString*)withID attachedImages:(NSArray*)images;
@end