#import <UIKit/UIKit.h>

@interface CNContactNavigationController : UINavigationController
@end

@interface CustomNavigationController : CNContactNavigationController
+ (id)defaultPNGName;
-(BOOL)shouldSnapshot;
@end
