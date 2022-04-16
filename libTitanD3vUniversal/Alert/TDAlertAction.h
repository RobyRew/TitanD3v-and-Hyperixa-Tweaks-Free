#import <UIKit/UIKit.h>
#import "TDAlertActionConfiguration.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

@interface TDAlertAction : NSObject

- (instancetype)initWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^__nullable)(TDAlertAction *action))handler;
- (instancetype)initWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^__nullable)(TDAlertAction *action))handler configuration:(nullable TDAlertActionConfiguration *)configuration;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, readonly) UIAlertActionStyle style;
@property (nonatomic, strong, readonly, nullable) void (^handler)(TDAlertAction *action);
@property (nonatomic, strong, readonly, nullable) TDAlertActionConfiguration *configuration;
@property (nonatomic) BOOL enabled;

@end

