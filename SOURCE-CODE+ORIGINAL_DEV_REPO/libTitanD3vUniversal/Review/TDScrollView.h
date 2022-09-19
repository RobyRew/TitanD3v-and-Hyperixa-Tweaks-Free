#import <UIKit/UIKit.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshadow-ivar"

@protocol ScrollViewDelegate

- (void)scrollViewDidChangeProgress:(CGFloat)progress;

@end

@interface TDScrollView : UIView

@property (weak) id <ScrollViewDelegate> delegate;

- (void)configure;

@end
