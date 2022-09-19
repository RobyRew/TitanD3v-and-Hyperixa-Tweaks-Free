#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "SettingColourCell.h"
#import "SettingSwitchCell.h"
#import "GlobalHaptic.h"

@interface SettingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIColorPickerViewControllerDelegate>
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic) NSInteger colourPickerIndex;
@property (nonatomic, retain) UIColor *accentColour;
@end
