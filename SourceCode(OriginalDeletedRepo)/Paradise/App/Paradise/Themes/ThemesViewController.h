#import <UIKit/UIKit.h>
#import "CreateThemeFolderVC.h"
#import "AddFolderCell.h"
#import "ThemesCell.h"
#import "AppManager.h"

@interface ThemesViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate> {
    UIBarButtonItem *createButton;
}

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong) NSString *selectedTheme;
@property (nonatomic, strong) NSIndexPath *checkedIndexPath;

@end
