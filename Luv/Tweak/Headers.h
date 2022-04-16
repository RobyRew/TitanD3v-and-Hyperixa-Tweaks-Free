#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import <MediaRemote/MediaRemote.h>
#import "TopWindow.h"
#import "FloatingView.h"
#include <dlfcn.h> 

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString * bundleIdentifier;                                                                                
@end

@interface SBMediaController 
@property (nonatomic, weak,readonly) SBApplication * nowPlayingApplication;
+(id)sharedInstance;
- (BOOL)isPlaying;
- (id)nowPlayingApplication;
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

@interface SPTNowPlayingFreeTierFeedbackButton : UIButton
@end

@interface SPTNowPlayingAnimatedLikeButton : UIButton
@end

@interface UIStatusBarWindow : UIWindow
@end

@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
-(void)postNotificationName:(id)arg1 object:(id)arg2 userInfo:(id)arg3 deliverImmediately:(BOOL)arg4 ;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end

@interface SPTNowPlayingBarHeartViewController
-(id)heartButton;
@end

@interface SPTNowPlayingHeartButtonViewController
-(id)animatedLikeButton;
@end

@interface SpringBoard : UIView
-(void)layoutWindow;
@end