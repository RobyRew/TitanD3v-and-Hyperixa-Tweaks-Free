#import <TitanD3vUniversal/TitanD3vUniversal.h>

@interface UICalloutBar : UIView
@property (nonatomic,readonly) bool isDisplayingVertically; 
@property (nonatomic, retain) NSArray *extraItems;
@property (nonatomic, retain) UIMenuItem *substiaItem;
@end

@interface UICalloutBarButton : UIButton
@property (nonatomic, assign) SEL action;
@end

@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(id)arg1 object:(id)arg2 userInfo:(id)arg3 deliverImmediately:(BOOL)arg4;
- (void)addObserver:(id)arg1 selector:(SEL)arg2 name:(id)arg3 object:(id)arg4;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end

@interface _KSTextReplacementEntry : NSObject
@property (nonatomic,retain) NSData * cloudData;
@property (assign) BOOL needsSaveToCloud;
@property (assign) BOOL wasDeleted;
@property (nonatomic,copy) NSString * cloudID;
@property (nonatomic,copy) NSString * phrase;
@property (nonatomic,copy) NSString * shortcut;
@property (nonatomic,copy) NSDate * timestamp;
@property (nonatomic,retain) _KSTextReplacementEntry * priorValue;
+(BOOL)supportsSecureCoding;
+(id)localEntryFromCloudEntry:(id)arg1 ;
-(void)setPhrase:(NSString *)arg1 ;
-(void)setWasDeleted:(BOOL)arg1 ;
-(id)copyWithZone:(NSZone*)arg1 ;
-(id)encryptedFields;
-(BOOL)isEquivalentTo:(id)arg1 ;
-(id)uniqueRecordName;
-(BOOL)wasDeleted;
-(id)uniqueRecordNameVer0;
-(id)unEncryptedFields;
-(NSDate *)timestamp;
-(void)setTimestamp:(NSDate *)arg1 ;
-(void)setCloudID:(NSString *)arg1 ;
-(_KSTextReplacementEntry *)priorValue;
-(void)setShortcut:(NSString *)arg1 ;
-(id)uniqueID;
-(id)init;
-(void)setCloudData:(NSData *)arg1 ;
-(NSString *)phrase;
-(void)setNeedsSaveToCloud:(BOOL)arg1 ;
-(BOOL)needsSaveToCloud;
-(id)initWithCoder:(id)arg1 ;
-(void)encodeWithCoder:(id)arg1 ;
-(NSString *)shortcut;
-(void)setPriorValue:(_KSTextReplacementEntry *)arg1 ;
-(NSData *)cloudData;
-(id)description;
-(NSString *)cloudID;
@end

@interface _KSTextReplacementHelper : NSObject
+(id)errorWithCode:(long long)arg1 failedAdds:(id)arg2 failedDeletes:(id)arg3 ;
+(id)errorWithCode:(long long)arg1 forEntry:(id)arg2 ;
+(void)logAggdValueForSyncIsPull:(BOOL)arg1 success:(BOOL)arg2 ;
+(long long)validateTextReplacement:(id)arg1 ;
+(id)sampleShortcut;
+(id)fetchConfigurationPlist;
+(id)errorStringForCode:(long long)arg1 ;
+(id)aggdPrefix;
+(id)errorWithCode:(long long)arg1 description:(id)arg2 ;
+(void)fetchConfigurationPlistIfNeeded;
+(id)transactionFromTextReplacementEntry:(id)arg1 forDelete:(BOOL)arg2 ;
+(void)logPhraseWordCount:(long long)arg1 ;
+(void)extractAggdMetricsForTextReplacement:(id)arg1 ;
+(id)multipleAddErrors:(id)arg1 removeErrors:(id)arg2 ;
+(id)textReplaceEntryFromTIDictionaryValue:(id)arg1 ;
+(id)appleLanguagesPreference;
@end

@interface _KSTextReplacementClientStore : NSObject
-(id)textReplacementEntries;
-(void)cancelPendingUpdates;
-(void)queryTextReplacementsWithCallback:(/*^block*/id)arg1 ;
-(void)requestSyncWithCompletionBlock:(/*^block*/id)arg1 ;
-(void)removeAllEntries;
-(void)queryTextReplacementsWithPredicate:(id)arg1 callback:(/*^block*/id)arg2 ;
-(id)init;
-(void)performTransaction:(id)arg1 completionHandler:(/*^block*/id)arg2 ;
-(void)addEntries:(id)arg1 removeEntries:(id)arg2 withCompletionHandler:(/*^block*/id)arg3 ;
-(void)modifyEntry:(id)arg1 toEntry:(id)arg2 withCompletionHandler:(/*^block*/id)arg3 ;
-(id)phraseShortcuts;
@end