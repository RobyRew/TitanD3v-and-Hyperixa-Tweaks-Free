#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SystemServices.h"
#import "Colour-Scheme.h"
#import <objc/runtime.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBWiFiManager : NSObject
+ (id)sharedInstance;
- (id)currentNetworkName;
@end


@interface InfoModel : NSObject
-(id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle icon:(NSString *)icon colour:(UIColor *)colour;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *icon;
@property (nonatomic, retain) UIColor *colour;
@end


@interface AboutDeviceInfo : NSObject
+(instancetype)sharedInstance;
-(id)init;
-(NSMutableArray *)generalArray;
-(NSMutableArray *)networkArray;
-(NSMutableArray *)batteryArray;
-(NSMutableArray *)accessoriesArray;
-(NSMutableArray *)screenArray;
-(NSMutableArray *)processorArray;
-(NSMutableArray *)motionArray;
-(NSMutableArray *)localisationArray;
-(NSMutableArray *)debugArray;
@end

NS_ASSUME_NONNULL_END
