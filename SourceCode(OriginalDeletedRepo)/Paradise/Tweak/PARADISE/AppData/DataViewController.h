#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "GlobalPreferences.h"
#import "BlurBaseView.h"
#import "IconCell.h"
#import "AccessoriesCell.h"
#import "../../Headers.h"
#import "ParadiseManager.h"
#import "ParadiseSettingViewController.h"
#import "UninstallAppsViewController.h"
#import "AccessoriesColourCell.h"

@interface DataViewController : UIViewController <UIColorPickerViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
  SBIconView *iconVieww;
}
-(instancetype)initWithIconView:(id)iconView imgTitle:(NSString*)title iconID:(NSString*)iconID;
@property (nonatomic, retain) BlurBaseView *baseView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *appImage;
@property (nonatomic, retain) UILabel *appLabel;
@property (nonatomic, retain) UILabel *versionLabel;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *listArray;
@property (nonatomic, retain) NSArray *iconArray;
@property (nonatomic, strong) ParadiseManager *paradiseManager;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *bundleIdentifier;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSURL *bundleURL;
@property (nonatomic, strong) NSURL *dataContainerURL;
@property (nonatomic, assign) NSInteger diskUsage;
@property (nonatomic, strong) NSString *diskUsageString;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *toolsArray;
@property (nonatomic, retain) UIButton *menuButton;
@property (nonatomic, retain) UIButton *settingButton;
@property (nonatomic, retain) UILabel *accessoriesLabel;
@property (nonatomic, retain) UILabel *infoLabel;

@property (nonatomic, retain) NSString *lockButton;


@property (nonatomic, strong) NSString *iconID;
@end
