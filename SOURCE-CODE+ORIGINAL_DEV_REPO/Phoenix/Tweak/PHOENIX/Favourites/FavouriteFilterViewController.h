#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "TDAnimator.h"
#import "FavouriteFilterCell.h"
#import "SettingManager.h"

@protocol FavouriteFilterProtocol <NSObject>
@required
-(void)filterFavouritesWithCategoriesName:(NSString *)categories;
@end

@interface FavouriteFilterViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
-(instancetype)initWithHeight:(CGFloat)height;
@property (nonatomic, retain) TDAnimator *myAnimator;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *categoriesArray;
@property (nonatomic) NSInteger categoriesIndex;
@property (nonatomic) BOOL didChooseCategories;
@property (nonatomic, retain) NSString *categoriesName;
@property(nonatomic,assign)id delegate;
@end
