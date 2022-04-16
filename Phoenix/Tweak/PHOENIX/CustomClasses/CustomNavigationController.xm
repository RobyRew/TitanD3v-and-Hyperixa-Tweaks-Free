#import "CustomNavigationController.h"

// [NEW CODE] also rename this file ext to .xm from .m
%subclass CustomNavigationController : CNContactNavigationController

- (void)viewDidLoad {
  // [super viewDidLoad];
  %orig;
}

%new
+ (id)defaultPNGName{
  return @"Default";
}

%new
-(BOOL)shouldSnapshot{
  return 0;
}

%end
