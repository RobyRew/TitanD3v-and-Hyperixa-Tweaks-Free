#import <Foundation/Foundation.h>
#import "RNCryptor.h"

@interface RNEncryptor : RNCryptor
- (RNEncryptor *)initWithSettings:(RNCryptorSettings)settings
                    encryptionKey:(NSData *)encryptionKey
                          HMACKey:(NSData *)HMACKey
                          handler:(RNCryptorHandler)handler;


- (RNEncryptor *)initWithSettings:(RNCryptorSettings)settings
                         password:(NSString *)password
                          handler:(RNCryptorHandler)handler;

// This form with manual IV is generally only used for testing
- (RNEncryptor *)initWithSettings:(RNCryptorSettings)theSettings
                    encryptionKey:(NSData *)anEncryptionKey
                          HMACKey:(NSData *)anHMACKey
                               IV:(NSData *)anIV
                          handler:(RNCryptorHandler)aHandler;

// This form with manual IV and salts is generally only used for testing
- (RNEncryptor *)initWithSettings:(RNCryptorSettings)settings
                         password:(NSString *)password
                               IV:(NSData *)anIV
                   encryptionSalt:(NSData *)anEncryptionSalt
                         HMACSalt:(NSData *)anHMACSalt
                          handler:(RNCryptorHandler)handler;


+ (NSData *)encryptData:(NSData *)data withSettings:(RNCryptorSettings)settings password:(NSString *)password error:(NSError **)error;
+ (NSData *)encryptData:(NSData *)data withSettings:(RNCryptorSettings)settings encryptionKey:(NSData *)encryptionKey HMACKey:(NSData *)HMACKey error:(NSError **)error;

// This form with manual IV is generally only used for testing
+ (NSData *)encryptData:(NSData *)thePlaintext
           withSettings:(RNCryptorSettings)theSettings
          encryptionKey:(NSData *)anEncryptionKey
                HMACKey:(NSData *)anHMACKey
                     IV:(NSData *)anIV
                  error:(NSError **)anError;

// This form with manual IV and salts is generally only used for testing
+ (NSData *)encryptData:(NSData *)data
           withSettings:(RNCryptorSettings)settings
               password:(NSString *)password
                     IV:(NSData *)anIV
         encryptionSalt:(NSData *)anEncryptionSalt
               HMACSalt:(NSData *)anHMACSalt
                  error:(NSError **)error;

@end
