#import "HomeNavigationViewController.h"


@implementation HomeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [super setNavigationBarHidden:hidden animated:animated];
    self.interactivePopGestureRecognizer.delegate = self;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count > 1) {
        return YES;
    }
    return NO;
}

@end
