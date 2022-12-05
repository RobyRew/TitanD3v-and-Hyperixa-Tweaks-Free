#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "GlobalPreferences.h"
#import "BlurBaseView.h"  
#import "LibraryCell.h"
#import "../../Headers.h"
#import "ColourCell.h"

@interface AppLibraryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIColorPickerViewControllerDelegate> 

@property (nonatomic, retain) BlurBaseView *baseView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *listArray;
@property (nonatomic, retain) NSArray *iconArray;

@property (nonatomic, retain) SBIconView *iconView;
@property (nonatomic, retain) NSString *imgHash;
@property (nonatomic, retain) NSString *imgTitle;

-(instancetype)initWithHash:(NSString*)imgHash imgTitle:(NSString*)title iconView:(SBIconView*)iconView;

@end
