#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import <Contacts/Contacts.h>
#import "TDPeople.h"
#import "TDContactPickerCell.h"
#import "TDContact.h"
#import "TDHeaderView.h"

@protocol TDContactPickerProtocol <NSObject>
@required
-(void)didPickAContact:(TDContact*)contact;
-(void)didCancelPickAContact;
@end

@interface TDContactPickerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
-(instancetype)initWithTitle:(NSString *)title accentColour:(UIColor *)accent;
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) UITableView *tableView;
@property (strong, nonatomic) NSArray <NSString*> * sectionIndexTitles;
@property (strong, nonatomic) NSMutableArray * contactPeople;
@property (strong, nonatomic) NSMutableArray * parsedContacts;
@property (nonatomic) NSInteger selectedSection;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) BOOL didSelectedContact;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) UIColor *accentColour;
@property(nonatomic,assign)id delegate;
@property (nonatomic, retain) TDContact *tdcontact;
@end

