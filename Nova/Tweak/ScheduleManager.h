#import <TitanD3vUniversal/TitanD3vUniversal.h>
//[Black NewCodeStarts] replace your file with this file's code
#import <dlfcn.h>

@interface ScheduleManager : NSObject
@property (nonatomic, retain) NSMutableDictionary *scheduleMsgs;
+(instancetype)sharedInstance;
-(id)init;

-(NSDate*)getTodaysDate;
-(NSString*)dateToStr:(NSDate*)date;


-(NSString*)getUDID;

-(void)saveAvatarWithId:(NSString*)withID;

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


















@interface BBAction : NSObject
+ (id)actionWithLaunchBundleID:(id)arg1 callblock:(id)arg2;
@end

@interface BBBulletin : NSObject
@property(nonatomic, copy)NSString* sectionID;
@property(nonatomic, copy)NSString* recordID;
@property(nonatomic, copy)NSString* publisherBulletinID;
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* message;
@property(nonatomic, retain)NSDate* date;
@property(assign, nonatomic)BOOL clearable;
@property(nonatomic)BOOL showsMessagePreview;
@property(nonatomic, copy)BBAction* defaultAction;
@property(nonatomic, copy)NSString* bulletinID;
@property(nonatomic, retain)NSDate* lastInterruptDate;
@property(nonatomic, retain)NSDate* publicationDate;
@end

@interface BBServer : NSObject
- (void)publishBulletin:(BBBulletin *)arg1 destinations:(NSUInteger)arg2 alwaysToLockScreen:(BOOL)arg3;
- (void)publishBulletin:(id)arg1 destinations:(unsigned long long)arg2;
-(void)_removeBulletins:(id)arg1 forSectionID:(id)arg2 shouldSync:(BOOL)arg3 ;
-(id)_bulletinsForIDs:(id)arg1 ;
-(id)allBulletinIDsForSectionID:(id)arg1 ;
-(void)_removeActiveSectionID:(id)arg1 ;
@end