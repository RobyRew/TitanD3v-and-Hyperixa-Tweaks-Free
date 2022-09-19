#import "TDAnimator.h"
#import "TDPresentationController.h"


@implementation TDAnimator

- (instancetype)initWithCHeight:(CGFloat)cHeight andDimALpha:(CGFloat)dimAlpha {
  self = [super init];
  if (self) {
    _cHeight = cHeight;
    _dimAlpha = dimAlpha;
  }
  return self;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {

  TDPresentationController * prensentVc = [[TDPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting andControllerHeight:self.cHeight andDimAlpha:_dimAlpha];
  return prensentVc;
}

@end
