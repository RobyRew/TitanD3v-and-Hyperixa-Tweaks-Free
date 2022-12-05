#import "TDAlertAction.h"
#import "TDAlertAction+Private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

@implementation TDAlertAction

- (instancetype)initWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(TDAlertAction * _Nonnull))handler {
  return [self initWithTitle:title style:style handler:handler configuration:nil];
}

- (instancetype)initWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^__nullable)(TDAlertAction *action))handler configuration:(nullable TDAlertActionConfiguration *)configuration {
  self = [super init];

  if (self) {
    _title = title;
    _style= style;
    _handler = handler;
    _configuration = configuration;
    _enabled = YES;
  }

  return self;
}

- (instancetype)init {
  self = [super init];

  if (self) {
    _enabled = YES;
  }

  return self;
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;

  self.actionButton.enabled = enabled;
}

@end
