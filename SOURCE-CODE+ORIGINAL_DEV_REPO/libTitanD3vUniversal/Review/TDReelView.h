#import <UIKit/UIKit.h>
#import "TDPie.h"

@interface TDReelView : UIView

- (void)configureWithBadPie:(TDPie *)badPie
                     ughPie:(TDPie *)ughPie
                      okPie:(TDPie *)okPie
                    goodPie:(TDPie *)goodPie;

@end
