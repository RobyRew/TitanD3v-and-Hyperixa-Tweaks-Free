#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "FavouriteCategoriesCell.h"
#import "CreateCategoriesViewController.h"
#import "SettingManager.h"

@protocol CreateNewFavouriteProtocol <NSObject>
@required
-(void)didCreatedNewFavourite;
@end

@interface CreateFavouriteViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, TDContactPickerProtocol, TDAvatarPickerProtocol, CreateNewCategoryProtocol>
@property (nonatomic, retain) UIColor *accentColour;
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) UIImageView *avatarImage;
@property (nonatomic, retain) UIButton *addButton;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIButton *avatarButton;
@property (nonatomic, retain) UILabel *categoriesLabel;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *categoriesArray;
@property (nonatomic) NSInteger categoriesIndex;
@property (nonatomic) BOOL didChooseContact;
@property (nonatomic) BOOL didChooseCategories;
@property (nonatomic, retain) NSString *categoriesName;
@property (nonatomic, retain) NSString *categoriesColour;
@property (nonatomic, retain) NSString *categoriesIcon;
@property (nonatomic, retain) TDContact *tdcontact;
@property (nonatomic, retain) NSMutableDictionary *mutableDict;
@property (nonatomic, retain) NSMutableDictionary *categoriesDict;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *emailAddress;
@property(nonatomic,assign)id delegate;
@property (nonatomic) BOOL isPhoneNumberAvailable;
@property (nonatomic) BOOL didChooseAvatar;
@end
