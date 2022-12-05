#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

FOUNDATION_EXPORT double ReachabilityVersionNumber;
FOUNDATION_EXPORT const unsigned char ReachabilityVersionString[];

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

extern NSString *const kReachabilityChangedNotification;

typedef NS_ENUM(NSInteger, NetworkStatus) {
    NotReachable = 0,
    ReachableViaWiFi = 2,
    ReachableViaWWAN = 1
};

@class Reachability;

typedef void (^NetworkReachable)(Reachability * reachability);
typedef void (^NetworkUnreachable)(Reachability * reachability);
typedef void (^NetworkReachability)(Reachability * reachability, SCNetworkConnectionFlags flags);


@interface Reachability : NSObject
@property (nonatomic, copy) NetworkReachable    reachableBlock;
@property (nonatomic, copy) NetworkUnreachable  unreachableBlock;
@property (nonatomic, copy) NetworkReachability reachabilityBlock;
@property (nonatomic, assign) BOOL reachableOnWWAN;
+(instancetype)reachabilityWithHostname:(NSString*)hostname;
+(instancetype)reachabilityWithHostName:(NSString*)hostname;
+(instancetype)reachabilityForInternetConnection;
+(instancetype)reachabilityWithAddress:(void *)hostAddress;
+(instancetype)reachabilityForLocalWiFi;
+(instancetype)reachabilityWithURL:(NSURL*)url;
-(instancetype)initWithReachabilityRef:(SCNetworkReachabilityRef)ref;
-(BOOL)startNotifier;
-(void)stopNotifier;
-(BOOL)isReachable;
-(BOOL)isReachableViaWWAN;
-(BOOL)isReachableViaWiFi;
-(BOOL)isConnectionRequired;
-(BOOL)connectionRequired;
-(BOOL)isConnectionOnDemand;
-(BOOL)isInterventionRequired;
-(NetworkStatus)currentReachabilityStatus;
-(SCNetworkReachabilityFlags)reachabilityFlags;
-(NSString*)currentReachabilityString;
-(NSString*)currentReachabilityFlags;

@end
