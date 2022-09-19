#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "DataManager.h"
#import "CDHeaderView.h"
#import "DeviceUsageView.h"
#import "RamManager.h"
#import "MemoryView.h"

@interface MemoryViewController : UIViewController
@property (nonatomic, retain) CDHeaderView *headerView;
@property (nonatomic, retain) DeviceUsageView *totalProgressView;
@property (nonatomic, retain) DeviceUsageView *usedProgressView;
@property (nonatomic, retain) DeviceUsageView *freeProgressView;
@property (nonatomic, retain) MemoryView *totalView;
@property (nonatomic, retain) MemoryView *usedView;
@property (nonatomic, retain) MemoryView *freeView;
@property (nonatomic, retain) UIView *containerView;
@end
