#import <UIKit/UIKit.h>
#import "TYTabPagerBar.h"
#import "TYPagerController.h"
#import "SystemColourViewController.h"
#import "MultiColourViewController.h"
#import "BlackColourViewController.h"
#import "BlueColourViewController.h"
#import "BrownColourViewController.h"
#import "GreyColourViewController.h"
#import "GreenColourViewController.h"
#import "OrangeColourViewController.h"
#import "PinkColourViewController.h"
#import "PurpleColourViewController.h"
#import "RedColourViewController.h"
#import "WhiteColourViewController.h"
#import "YellowColourViewController.h"

@interface ColourSectionViewController : UIViewController <TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>
@property (nonatomic, retain) TYTabPagerBar *tabBar;
@property (nonatomic, retain) TYPagerController *pagerController;
@property (nonatomic, strong) NSArray *datas;
@end

