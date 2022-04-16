#import <UIKit/UIKit.h>
#import "HEXColour.h"

@interface TDTweakManager : NSObject

+(instancetype)sharedInstance;
-(id)init;

- (void)setBool:(BOOL)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setObject:(id)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setFloat:(long long)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (void)setInt:(int)anObject forKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue ID:(NSString*)bundleIdentifier;
- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue ID:(NSString*)bundleIdentifier;
- (long long)floatForKey:(id)aKey defaultValue:(long long)defaultValue ID:(NSString*)bundleIdentifier;
- (int)intForKey:(id)aKey defaultValue:(int)defaultValue ID:(NSString*)bundleIdentifier;
- (bool)boolForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (id)objectForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (long long)floatForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (int)intForKey:(id)aKey ID:(NSString*)bundleIdentifier;
- (UIColor *)colourForKey:(id)aKey defaultValue:(id)defaultValue ID:(NSString*)bundleIdentifier;
- (UIColor *)systemColourForKey:(id)aKey defaultColour:(UIColor *)defaultColour ID:(NSString*)bundleIdentifier;
- (void)removeObjectForKey:(id)aKey ID:(NSString*)bundleIdentifier;

@end
