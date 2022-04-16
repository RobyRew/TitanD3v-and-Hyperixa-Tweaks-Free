#import <Foundation/Foundation.h>
#import "RNCryptor.h"

@class RNCryptorEngine;

@interface RNCryptor ()
@property (nonatomic, readwrite, strong) RNCryptorEngine *engine;
#if OS_OBJECT_USE_OBJC
@property (nonatomic, readwrite, strong) dispatch_queue_t queue;
#else
@property (nonatomic, readwrite, assign) dispatch_queue_t queue;
#endif
@property (nonatomic, readonly) NSMutableData *outData;
@property (nonatomic, readwrite, copy) RNCryptorHandler handler;
@property (nonatomic, readwrite, assign) NSUInteger HMACLength;
@property (nonatomic, readwrite, strong) NSError *error;
@property (nonatomic, readwrite, assign, getter=isFinished) BOOL finished;
@property (nonatomic, readwrite, assign) RNCryptorOptions options;

- (id)initWithHandler:(RNCryptorHandler)handler;
+ (NSData *)synchronousResultForCryptor:(RNCryptor *)cryptor data:(NSData *)inData error:(NSError **)anError;
- (void)cleanupAndNotifyWithError:(NSError *)error;
- (BOOL)hasHMAC;
@end

@interface NSMutableData (RNCryptor)
- (NSData *)_RNConsumeToIndex:(NSUInteger)index;
@end
