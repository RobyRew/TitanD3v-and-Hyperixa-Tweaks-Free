#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "DataManager.h"
#import "CDHeaderView.h"
#import "AboutCell.h"
#import "SectionCellHeaderView.h"
#import "AboutDeviceInfo.h"

@interface AboutViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) CDHeaderView *headerView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *generalArray;
@property (nonatomic, retain) NSMutableArray *networkArray;
@property (nonatomic, retain) NSMutableArray *batteryArray;
@property (nonatomic, retain) NSMutableArray *accessoriesArray;
@property (nonatomic, retain) NSMutableArray *screenArray;
@property (nonatomic, retain) NSMutableArray *processorArray;
@property (nonatomic, retain) NSMutableArray *motionArray;
@property (nonatomic, retain) NSMutableArray *localisationArray;
@property (nonatomic, retain) NSMutableArray *debugArray;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIImageView *headerIcon;
@property (nonatomic, retain) UILabel *headerTitle;
@end
