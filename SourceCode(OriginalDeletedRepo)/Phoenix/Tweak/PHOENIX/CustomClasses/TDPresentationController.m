#import "TDPresentationController.h"

#define XYHALFMODALHEIGHT 500


@interface TDPresentationController ()
@property (nonatomic, strong) _UIBackdropViewSettings *dimViewSetting;
@property (nonatomic, strong) _UIBackdropView *dimView;
@property(nonatomic,strong)UITapGestureRecognizer * tap;
@property (nonatomic, assign) CGFloat controllerHeight;
@property (nonatomic, assign) CGFloat dimAlpha;
@end


@implementation TDPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController andControllerHeight:(CGFloat)cHeight andDimAlpha:(CGFloat)dimAlpha {
  self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
  if (self) {
    _controllerHeight = cHeight;
    _dimAlpha = dimAlpha;
  }
  return self;
}

- (void)containerViewWillLayoutSubviews {
  [super containerViewWillLayoutSubviews];

  UIView *mainView = self.presentedView;

  [self.containerView addSubview:mainView];

  if (!self.dimView) {
    self.dimViewSetting = [_UIBackdropViewSettings settingsForStyle:2];
    self.dimView = [[_UIBackdropView alloc] initWithSettings:self.dimViewSetting];
    self.dimView.alpha = 0;
    self.dimView.userInteractionEnabled = YES;
    [self.containerView insertSubview:self.dimView atIndex:0];
  }

  [self.dimView addGestureRecognizer:self.tap];

  if (self.dimAlpha >=1) {
    self.dimAlpha = 1;
  }else if (self.dimAlpha <0) {
    self.dimAlpha = 1;
  }

  [UIView animateWithDuration:0.20 animations:^{
    self.dimView.alpha = self.dimAlpha;
  }];

  [self frameSetup];
}

- (void)dismissalTransitionWillBegin {
  [UIView animateWithDuration:0.25 animations:^{
    self.dimView.alpha = 0;
  }];
}


- (void)frameSetup {

  CGFloat x,y,w,h,cHeight;

  cHeight = self.controllerHeight <= 0 ? XYHALFMODALHEIGHT:self.controllerHeight;

  x = 0;
  y = [UIScreen mainScreen].bounds.size.height - cHeight;
  w = [UIScreen mainScreen].bounds.size.width;
  h = cHeight;

  self.presentedView.frame = CGRectMake(x, y, w, h);

  y = 0;

  h = [UIScreen mainScreen].bounds.size.height;

  self.dimView.frame = CGRectMake(x,  y,  w,  h);

}


- (void)tapClick {

  [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];

}


- (UITapGestureRecognizer *)tap {
  if (!_tap) {
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
  }
  return _tap;
}

@end
