#import "ScheduleManager.h"


//[Black NewCodeStarts] replace your file with this file's code

static NSString *savedSchedulesPlist = @"/Library/Application Support/Nova.bundle/savedSchedulesPlist.plist";
NSDateFormatter *dateFormatter;

@interface CNPhoneNumber (private)
-(NSString *)countryCode;
-(id)initWithStringValue:(id)arg1 ;
-(NSString *)digits;
-(id)formattedStringValueRemovingDialingCode;
@end

static NSString* filterPhoneNumber(NSString *phone){
    CNPhoneNumber *phonee = [[NSClassFromString(@"CNPhoneNumber") alloc] initWithStringValue:phone];
    phone = [phonee formattedStringValueRemovingDialingCode];    
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"+" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];

    NSString *unfilteredString = phone;
    NSCharacterSet *notAllowedChars = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *escapedString = [[unfilteredString componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    return escapedString;
}

@implementation ScheduleManager

+(instancetype)sharedInstance {
    static ScheduleManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ScheduleManager alloc] init];
        sharedInstance.scheduleMsgs = [NSMutableDictionary new];
    });
    return sharedInstance;
}

-(id)init {
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:savedSchedulesPlist];
	self.scheduleMsgs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
	return self;
}

-(NSString*)getUDID{
	return (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
}

-(NSString*)getTimeLeft:(NSDate*)date{
	if(!date)
    return @"";
    NSInteger MinInterval;
    NSInteger HourInterval;
    NSInteger DayInterval;
    NSInteger DayModules;

    NSInteger interval = labs((NSInteger)[date timeIntervalSinceDate:[NSDate date]]);
    if(interval >= 86400)    
    {
        DayInterval  = interval/86400;
        DayModules = interval%86400;
        if(DayModules!=0)
        {
            if(DayModules>=3600){
                return [NSString stringWithFormat:@"%li Days", (long)DayInterval];
            }
            else {
                if(DayModules>=60){
                    return [NSString stringWithFormat:@"%li Days", (long)DayInterval];
                }
                else {
                    return [NSString stringWithFormat:@"%li Days", (long)DayInterval];
                }
            }
        }
        else 
        {
        return [NSString stringWithFormat:@"%li Days", (long)DayInterval];
        }
    }
    else{

        if(interval>=3600)
        {
            HourInterval= interval/3600;
            return [NSString stringWithFormat:@"%li Hours", (long)HourInterval];
        }
        else if(interval>=60){
            MinInterval = interval/60;
            return [NSString stringWithFormat:@"%li Minutes", (long)MinInterval];
        }
        else{
            return [NSString stringWithFormat:@"%li Sec", (long)interval];
        }
    }
}

-(NSDate*)getTodaysDate{
	return [self strToDate:[dateFormatter stringFromDate:[NSDate date]]];
}

-(NSDate*)strToDate:(NSString*)dateStr{
	[dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
	return (NSDate*)[dateFormatter dateFromString:dateStr];
}

-(NSString*)dateToStr:(NSDate*)date{
	[dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
	return [dateFormatter stringFromDate:date];
}

-(NSMutableArray*)sortedSchedules:(NSMutableArray*)arrayToSort{
	NSArray *sortedArray;
	sortedArray = [arrayToSort sortedArrayUsingComparator:^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
	    NSDate *first = a[@"scheduleLabel"];
	    NSDate *second = b[@"scheduleLabel"];
	    return [first compare:second];
	}];
	return (NSMutableArray*)sortedArray;
}

-(NSMutableArray*)getTodaysSchedules{
	NSMutableArray *schedulesToday = [NSMutableArray new];

	for(NSString *key in self.scheduleMsgs){
		NSDate *schdDate = self.scheduleMsgs[key][@"scheduleLabel"];
		bool isToday = [[NSCalendar currentCalendar] isDateInToday:schdDate];
		bool isTodayDatePassed = [[self getTodaysDate] compare:schdDate] == NSOrderedDescending;
		bool isSent = [self.scheduleMsgs[key][@"isSent"] boolValue];
		
		if(isToday && !isTodayDatePassed && !isSent)
			[schedulesToday addObject:self.scheduleMsgs[key]];
	}

	return [self sortedSchedules:schedulesToday];
}

-(NSMutableArray*)getFutureSchedules{
	NSMutableArray *schedulesFuture = [NSMutableArray new];

	for(NSString *key in self.scheduleMsgs){
		NSDate *schdDate = self.scheduleMsgs[key][@"scheduleLabel"];
		bool isToday = [[NSCalendar currentCalendar] isDateInToday:schdDate];
		bool isTodayDatePassed = [[self getTodaysDate] compare:schdDate] == NSOrderedDescending;
		bool isSent = [self.scheduleMsgs[key][@"isSent"] boolValue];

		if(!isToday && !isTodayDatePassed && !isSent)
			[schedulesFuture addObject:self.scheduleMsgs[key]];
	}

	return [self sortedSchedules:schedulesFuture];
}

-(NSMutableArray*)getSentSchedules{
	NSMutableArray *schedulesFuture = [NSMutableArray new];

	for(NSString *key in self.scheduleMsgs){
		NSDate *schdDate = self.scheduleMsgs[key][@"scheduleLabel"];
		bool isTodayDatePassed = [[self getTodaysDate] compare:schdDate] == NSOrderedDescending;
		bool isSent = [self.scheduleMsgs[key][@"isSent"] boolValue];
		if(isTodayDatePassed || isSent)
			[schedulesFuture addObject:self.scheduleMsgs[key]];
	}

	return [self sortedSchedules:schedulesFuture];
}

-(NSMutableDictionary*)getAllSchedules{
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:savedSchedulesPlist];
	self.scheduleMsgs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	return self.scheduleMsgs;
}

-(void)deleteScheduleWithId:(NSString*)withID{
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:savedSchedulesPlist];
	self.scheduleMsgs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	[self.scheduleMsgs removeObjectForKey:withID];
	[self.scheduleMsgs writeToFile:savedSchedulesPlist atomically:YES];
}

-(void)addScheduleWithId:(NSString*)withID data:(NSDictionary*)data{
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:savedSchedulesPlist];
	self.scheduleMsgs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	[self.scheduleMsgs setObject:data forKey:withID];
	[self.scheduleMsgs writeToFile:savedSchedulesPlist atomically:YES];

	[self saveAttachtedImagesWithId:withID attachedImages:data[@"attachedImages"]];
	[self saveAvatarWithId:withID];
}

-(void)markMsgAsSentWithId:(NSString*)withID data:(NSDictionary*)data{
	NSMutableDictionary *newData = [data mutableCopy];
	[newData setObject:@YES forKey:@"isSent"];

	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:savedSchedulesPlist];
	self.scheduleMsgs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	[self.scheduleMsgs setObject:newData forKey:withID];
	[self.scheduleMsgs writeToFile:savedSchedulesPlist atomically:YES];

	//[Black NewCodeStarts] here we have to add send notification code which i could not add for any reasone i tried everythig tho smh :/

}


-(void)saveAttachtedImagesWithId:(NSString*)withID attachedImages:(NSArray*)images{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	long imgCount = 0;
	NSString *imgName;
	while(imgCount < images.count){
		imgName = [NSString stringWithFormat:@"/Library/Application Support/Nova.bundle/Attachments/%@-%ld.png", withID, imgCount];
		[fileManager copyItemAtPath:images[imgCount] toPath:imgName error:nil];
		imgCount++;
	}
}

-(void)saveAvatarWithId:(NSString*)withID{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSString *imgName = [NSString stringWithFormat:@"/Library/Application Support/Nova.bundle/Avatars/%@-Avatar.png", withID];
		NSString *oldImgName = [NSString stringWithFormat:@"/tmp/%@-Avatar.png", withID];
		[fileManager copyItemAtPath:oldImgName toPath:imgName error:nil];
		UIImage *image = [UIImage imageWithContentsOfFile:oldImgName];
		[UIImagePNGRepresentation(image) writeToFile:imgName atomically:YES];
	});
}

-(NSMutableArray*)arrangeAttachedWithId:(NSString*)withID attachedImages:(NSArray*)images{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSMutableArray *arrayOfAttach = [NSMutableArray new];
	long imgCount = 0;
	NSString *imgName;
	while(imgCount < images.count){
		imgName = [NSString stringWithFormat:@"/Library/Application Support/Nova.bundle/Attachments/%@-%ld.png", withID, imgCount];
		[fileManager copyItemAtPath:imgName toPath:images[imgCount] error:nil];
		[arrayOfAttach addObject:images[imgCount]];
		imgCount++;
	}
	return arrayOfAttach;
}
@end