#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "BlurBaseView.h"
#include "UninstallAppsCell.h"
#include "UninstallAppList.h"
#import "../../Headers.h"
#import "Colour-Scheme.h"
#import "GlobalPreferences.h"

@interface UninstallAppsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *uninstallButton;
@property (nonatomic, retain) UIButton *cancelButton;
@property(nonatomic, strong) NSMutableDictionary *appsToUninstall;
@property(nonatomic, strong) NSMutableDictionary *selectedApps;
@property(nonatomic, strong) NSMutableArray *fullAppList;
@property (nonatomic, retain) BlurBaseView *baseView;
@property (nonatomic, retain) UITableView *tableView;
-(void)refreshTable;
-(void)deleteKey:(NSString*)key;
@end