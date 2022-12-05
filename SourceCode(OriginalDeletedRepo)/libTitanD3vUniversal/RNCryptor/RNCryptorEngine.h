#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "RNCryptor.h"

@interface RNCryptorEngine : NSObject
- (RNCryptorEngine *)initWithOperation:(CCOperation)operation settings:(RNCryptorSettings)settings key:(NSData *)key IV:(NSData *)IV error:(NSError **)error;
- (NSData *)addData:(NSData *)data error:(NSError **)error;
- (NSData *)finishWithError:(NSError **)error;
@end
