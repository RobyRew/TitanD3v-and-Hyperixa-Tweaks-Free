#import <Foundation/Foundation.h>
#import <Security/Security.h>

// NOTE: No CommonCrypto types may be used in this file. Swift can't handle them.

extern NSString *const kRNCryptorErrorDomain;
extern const uint8_t kRNCryptorFileVersion;

typedef struct _RNCryptorKeyDerivationSettings
{
  size_t keySize;
  size_t saltSize;
  /* CCPBKDFAlgorithm */ uint32_t PBKDFAlgorithm;
  /* CCPseudoRandomAlgorithm */ uint32_t PRF;
  uint rounds;
  BOOL hasV2Password; // See Issue #77. V2 incorrectly handled multi-byte characters.
} RNCryptorKeyDerivationSettings;

typedef struct _RNCryptorSettings
{
  /* CCAlgorithm */ uint32_t algorithm;
  size_t blockSize;
  size_t IVSize;
  /* CCOptions */ uint32_t options;
  /* CCHmacAlgorithm */ uint32_t HMACAlgorithm;
  size_t HMACLength;
  RNCryptorKeyDerivationSettings keySettings;
  RNCryptorKeyDerivationSettings HMACKeySettings;
} RNCryptorSettings;

extern const RNCryptorSettings kRNCryptorAES256Settings;

enum _RNCryptorOptions
{
  kRNCryptorOptionHasPassword = 1 << 0,
};
typedef uint8_t RNCryptorOptions;

enum
{
  kRNCryptorHMACMismatch = 1,
  kRNCryptorUnknownHeader = 2,
};

@class RNCryptor;

typedef void (^RNCryptorHandler)(RNCryptor *cryptor, NSData *data);

///** Encryptor/Decryptor for iOS
//
//  Provides an easy-to-use, Objective-C interface to the AES functionality of CommonCrypto. Simplifies correct handling of
//  password stretching (PBKDF2), salting, and IV. For more information on these terms, see "Properly encrypting with AES
//  with CommonCrypto," and iOS 5 Programming Pushing the Limits, Chapter 11. Also includes automatic HMAC handling to integrity-check messages.
//
//  RNCryptor is abstract. Use RNEncryptor to encrypt or RNDecryptor to decrypt
// */
//

@interface RNCryptor : NSObject
@property (nonatomic, readonly, strong) NSError *error;
@property (nonatomic, readonly, getter=isFinished) BOOL finished;
@property (nonatomic, readonly, copy) RNCryptorHandler handler;
@property (nonatomic, readwrite) dispatch_queue_t responseQueue;

- (void)addData:(NSData *)data;
- (void)finish;

/** Generate key given a password and salt using a PBKDF
 *
 * @param password Password to use for PBKDF
 * @param salt Salt for password
 * @param keySettings Settings for the derivation (RNCryptorKeyDerivationSettings)
 * @returns Key
 * @throws if settings are illegal
 */
+ (NSData *)keyForPassword:(NSString *)password salt:(NSData *)salt settings:(RNCryptorKeyDerivationSettings)keySettings;

/** Generate random data
 *
 * @param length Length of data to generate
 * @returns random data
 */
+ (NSData *)randomDataOfLength:(size_t)length;

@end
