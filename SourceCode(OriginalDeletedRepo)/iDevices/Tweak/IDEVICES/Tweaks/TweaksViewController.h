#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "DataManager.h"
#import "CDHeaderView.h"
#import "TweakCell.h"

@interface TweakModel : NSObject
-(id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@end

@interface TweaksViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) CDHeaderView *headerView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property(nonatomic, retain) NSMutableDictionary *packageInfo;
@property(nonatomic, retain) NSArray *tweakArray;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIImageView *headerIcon;
@property (nonatomic, retain) UILabel *headerTitle;
@end

