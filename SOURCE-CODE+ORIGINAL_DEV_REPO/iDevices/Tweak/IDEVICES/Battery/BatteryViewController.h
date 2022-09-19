#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "DataManager.h"
#import "CDHeaderView.h"
#import "BatteryCell.h"
#import "SectionCellHeaderView.h"

@interface BatteryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) CDHeaderView *headerView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIImageView *headerIcon;
@property (nonatomic, retain) UILabel *headerTitle;
@end

@interface BCBatteryDevice : NSObject
@property (assign,getter=isFake,nonatomic) BOOL fake; 
//ONLY IN IOS 13
@property (nonatomic,readonly) UIImage * glyph; 
//ONLY IN IOS 14
-(id)batteryWidgetGlyph;
-(long long)percentCharge;
-(BOOL)isBatterySaverModeActive;
-(BOOL)isCharging;
-(BOOL)isLowBattery;
-(BOOL)isInternal;
-(NSString *)identifier;
-(NSString *)name;
-(BOOL)isConnected;
-(NSString *)accessoryIdentifier;
-(NSString *)matchIdentifier;
-(NSString *)groupName;
-(NSString *)modelNumber;
-(unsigned long long)parts;
-(BOOL)isFake;
-(void)setPercentCharge:(long long)arg1;
-(void)updateScrollWidthAndTouchPassthrough;
@end

@interface BCBatteryDeviceController : NSObject
+(id)sharedInstance;
-(NSArray *)connectedDevices;
@property (setter=_setSortedDevices:,getter=_sortedDevices,nonatomic,retain) NSArray * sortedDevices;                                                 
// -(id)_sortedDevices;
//only supported on iOS 13
-(void)removeDeviceChangeHandlerWithIdentifier:(id)arg1;
@end

@interface UIImageAsset ()
@property(nonatomic, assign) NSString *assetName;
@end

