#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "DeviceUsageView.h"
#import "Colour-Scheme.h"

@interface BatteryCell : UICollectionViewCell
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) DeviceUsageView *usageView;
@property (nonatomic, retain) UIImageView *deviceImage;
@property (nonatomic, retain) UILabel *deviceLabel;
@property (nonatomic, retain) UILabel *batteryLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@end
