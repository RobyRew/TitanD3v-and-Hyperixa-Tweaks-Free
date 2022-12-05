#import <UIKit/UIKit.h>

@interface SettingManager : NSObject
+(instancetype)sharedInstance;
-(id)init;

- (void)setBool:(BOOL)anObject forKey:(id)aKey;
- (void)setObject:(id)anObject forKey:(id)aKey;
- (void)setFloat:(long long)anObject forKey:(id)aKey;
- (void)setInt:(int)anObject forKey:(id)aKey;
- (bool)boolForKey:(id)aKey defaultValue:(BOOL)defaultValue;
- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue;
- (long long)floatForKey:(id)aKey defaultValue:(long long)defaultValue;
- (int)intForKey:(id)aKey defaultValue:(int)defaultValue;
- (bool)boolForKey:(id)aKey;
- (id)objectForKey:(id)aKey;
- (long long)floatForKey:(id)aKey;
- (int)intForKey:(id)aKey;
-(UIColor *)systemColourForKey:(id)aKey defaultColour:(UIColor *)defaultColour;
-(UIColor *)accentColour;
-(UIColor *)callButtonColour;
-(UIColor *)messageButtonColour;
-(UIColor *)emailButtonColour;
-(UIColor *)deleteButtonColour;
-(UIImage *)icloudAvatar;
-(NSString *)icloudFullName;
@end
