#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "DataManager.h"
#import "CDHeaderView.h"
#import "StorageCell.h"
#import "SectionCellHeaderView.h"

@interface StorageViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) CDHeaderView *headerView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *mediaArray;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIImageView *headerIcon;
@property (nonatomic, retain) UILabel *headerTitle;
@end
