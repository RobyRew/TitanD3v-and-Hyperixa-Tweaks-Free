#import <Foundation/NSObject.h>
#import <Foundation/NSNotification.h>

@class NSArray<ObjectType>, NSDictionary<KeyType, ObjectType>, NSString;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NSTaskTerminationReason) {
    NSTaskTerminationReasonExit = 1,
    NSTaskTerminationReasonUncaughtSignal = 2
} NS_ENUM_AVAILABLE(10_6, NA);

@interface NSTask : NSObject
- (instancetype)init NS_DESIGNATED_INITIALIZER;
@property (nullable, copy) NSURL *executableURL API_AVAILABLE(macos(10.13)) API_UNAVAILABLE(ios, watchos, tvos);
@property (nullable, copy) NSArray<NSString *> *arguments;
@property (nullable, copy) NSDictionary<NSString *, NSString *> *environment; 
@property (nullable, copy) NSURL *currentDirectoryURL API_AVAILABLE(macos(10.13)) API_UNAVAILABLE(ios, watchos, tvos);
@property (nullable, retain) id standardInput;
@property (nullable, retain) id standardOutput;
@property (nullable, retain) id standardError;
- (BOOL)launchAndReturnError:(out NSError **_Nullable)error API_AVAILABLE(macos(10.13)) API_UNAVAILABLE(ios, watchos, tvos);
- (void)interrupt; 
- (void)terminate; 
- (BOOL)suspend;
- (BOOL)resume;
@property (readonly) int processIdentifier;
@property (readonly, getter=isRunning) BOOL running;
@property (readonly) int terminationStatus;
@property (readonly) NSTaskTerminationReason terminationReason API_AVAILABLE(macos(10.6)) API_UNAVAILABLE(ios, watchos, tvos);
@property (nullable, copy) void (^terminationHandler)(NSTask *) API_AVAILABLE(macos(10.7)) API_UNAVAILABLE(ios, watchos, tvos);
@property NSQualityOfService qualityOfService API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0)); // read-only after the task is launched
@end

@interface NSTask (NSTaskConveniences)
+ (nullable NSTask *)launchedTaskWithExecutableURL:(NSURL *)url arguments:(NSArray<NSString *> *)arguments error:(out NSError ** _Nullable)error terminationHandler:(void (^_Nullable)(NSTask *))terminationHandler API_AVAILABLE(macos(10.13)) API_UNAVAILABLE(ios, watchos, tvos);
- (void)waitUntilExit;
@end

@interface NSTask (NSDeprecated)
@property (nullable, copy) NSString *launchPath;
@property (copy) NSString *currentDirectoryPath;
- (void)launch;
+ (NSTask *)launchedTaskWithLaunchPath:(NSString *)path arguments:(NSArray<NSString *> *)arguments;
@end

FOUNDATION_EXPORT NSNotificationName const NSTaskDidTerminateNotification;

NS_ASSUME_NONNULL_END
