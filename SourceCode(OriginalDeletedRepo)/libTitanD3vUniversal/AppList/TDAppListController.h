#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>
#import "TDResultsTableController.h"
#import <Preferences/PSViewController.h>
#import "TDAppearance.h"
#import "TDUtilities.h"

@interface TDAppListController : PSViewController <UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate>
@property (nonatomic, retain) UISearchController *searchController;
@property (nonatomic, retain) UITableView *tableView;
@property(nonatomic, strong) NSArray *fullAppList;
@property(nonatomic, strong) NSArray *appList;
@property (nonatomic, retain) NSArray *preferencesAppList;
@property(nonatomic, strong) NSMutableArray *selectedApps;
@property(nonatomic, strong) NSMutableArray *unselectedApps;
@property(nonatomic, assign) NSString *postNotification;
@property(nonatomic, assign) NSString *preferencesSuiteName;
@property(nonatomic, assign) NSString *preferencesKey;
@property(nonatomic, assign) BOOL isLimitApps;
@property(nonatomic, assign) int appsCapacity;
@property (nonatomic, retain) UIColor *navigationBarColour;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *backgroundColour;
@property (nonatomic, retain) UIColor *cellsColour;
@property (nonatomic, retain) UIColor *labelColour;
@end

@interface UIImage (Private)
+(id)_applicationIconImageForBundleIdentifier:(NSString*)displayIdentifier format:(int)form scale:(CGFloat)scale;
@end
