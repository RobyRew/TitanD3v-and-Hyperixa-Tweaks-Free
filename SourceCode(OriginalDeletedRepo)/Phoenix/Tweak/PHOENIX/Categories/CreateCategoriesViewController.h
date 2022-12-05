#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "CategoriesNextButton.h"
#import "CategoriesIconCell.h"
#import "CategoriesColourCell.h"
#import "CreateCategoryDataSource.h"
#import "CategoriesColourSection.h"
#import "SettingManager.h"

@protocol CreateNewCategoryProtocol <NSObject>
@required
-(void)didCreatedNewCategory;
@end

@interface CreateCategoriesViewController : UIViewController <UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIColorPickerViewControllerDelegate>
@property (nonatomic, retain) UIColor *accentColour;
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *pageArray;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIView *toolView;
@property (nonatomic, retain) CategoriesNextButton *nameButton;
@property (nonatomic, retain) UICollectionView *iconCollectionView;
@property (nonatomic, retain) CategoriesNextButton *iconButton;
@property (nonatomic, retain) UICollectionView *colourCollectionView;
@property (nonatomic, retain) CategoriesNextButton *colourButton;
@property (nonatomic, retain) NSMutableArray *iconArray;
@property (nonatomic, retain) NSMutableArray *colourArray;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *iconName;
@property (nonatomic, retain) NSString *categoryColour;
@property (nonatomic) BOOL didSelectIcon;
@property (nonatomic) NSInteger iconSelectedIndex;
@property (nonatomic) BOOL didSelectColour;
@property (nonatomic) NSInteger colourSelectedIndex;
@property (nonatomic, retain) CategoriesColourSection *customColour;
@property(nonatomic,assign)id delegate;
@property (nonatomic, retain) NSMutableDictionary *mutableDict;
@end
