#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "GridView.h"
#import "SummaryView.h"
#import "Colour-Scheme.h"
#import "DataManager.h"
#import "CloudViewController.h"  
#import "DeviceViewController.h"
#import "BatteryViewController.h"
#import "StorageViewController.h"
#import "MemoryViewController.h"
#import "AboutViewController.h"
#import "AppsViewController.h"
#import "TweaksViewController.h"

@interface HomeViewController : UIViewController
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *grabberView;
@property (nonatomic, retain) UIImageView *avatarImage;
@property (nonatomic, retain) UILabel *welcomeTitle;
@property (nonatomic, retain) UILabel *welcomeSubtitle;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) GridView *icloudView;
@property (nonatomic, retain) GridView *deviceView;
@property (nonatomic, retain) GridView *batteryView;
@property (nonatomic, retain) GridView *storageView;
@property (nonatomic, retain) GridView *memoryView;
@property (nonatomic, retain) GridView *aboutView;
@property (nonatomic, retain) GridView *appsView;
@property (nonatomic, retain) GridView *tweaksView;
@property (nonatomic, retain) UILabel *summaryLabel;
@property (nonatomic, retain) SummaryView *lockedView;
@property (nonatomic, retain) SummaryView *unlockedView;
@property (nonatomic, retain) SummaryView *respringView;
@property (nonatomic, retain) SummaryView *appView;
@property (nonatomic, retain) UIView *footerView;
@end
