#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "ContactsData.h"
#import "ContactCell.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "FavouriteCell.h"
#import "CreateFavouriteViewController.h"
#import "ActionMenuViewController.h"
#import "FavouriteFilterViewController.h"
#import "MessageView.h"
#import "SettingManager.h"
#import "SettingViewController.h"
#import "GlobalHaptic.h"

@interface CNContactContentViewController
-(id)_faceTimeAction;
-(id)_faceTimeAudioAction;
@end

@interface CNPhoneNumber (Priv)
-(id)initWithStringValue:(id)arg1 ;
@end

@interface CNContact(Priv)
+(id)predicateForMeContact;
-(id)initWithIdentifier:(id)arg1;
+(id)contactWithIdentifier:(id)arg1;
@end

@interface CNContactViewController (Priv)
@property (nonatomic,retain) CNContactContentViewController * contentViewController;
-(void)presentationControllerDidAttemptToDismiss:(id)arg1;
@end

@interface ContactViewController : UIViewController <CNContactPickerDelegate, UITableViewDelegate, UITableViewDataSource, CNContactViewControllerDelegate, UITextFieldDelegate, TDIndexBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, DeleteContactProtocol, CreateNewFavouriteProtocol, FavouriteActionButtonDelegate, FavouriteFilterProtocol> {
    UIImpactFeedbackGenerator *haptic;
}
@property (strong) CNContactStore *store;
@property (strong) CNContactViewController *controller;
@property (nonatomic, retain) UITableView *tableView;
@property (strong, nonatomic) NSArray <NSString*> * sectionIndexTitles;
@property (strong, nonatomic) NSMutableArray * contactPeople;
@property (strong, nonatomic) NSMutableArray * parsedContacts;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *addButton;
@property (nonatomic, retain) UIButton *settingButton;
@property (nonatomic, retain) UIView *searchBarView;
@property (nonatomic, retain) UIImageView *searchIcon;
@property (nonatomic, retain) UITextField *searchTextField;
@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIView *myCardView;
@property (nonatomic, retain) TDIndexBar *indexBar;
@property (nonatomic, retain) UIColor *accentColour;
@property (nonatomic, retain) UIImageView *avatarImage;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *countLabel;
@property (nonatomic, retain) UIRefreshControl *refreshController;
@property (nonatomic, retain) UIView *favouriteView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIButton *contactCardButton;
@property (nonatomic, retain) CNContact *meContact;
@property (nonatomic, retain) NSMutableArray *favouritesArray;
@property (nonatomic, retain) UIView *favouriteSectionView;
@property (nonatomic, retain) UILabel *favouriteSectionLabel;
@property (nonatomic, retain) UIButton *favouriteSectionButton;
@property (nonatomic, retain) NSString *categoriesName;
@property (nonatomic, retain) MessageView *messageView;
@property (nonatomic) BOOL showFavourite;
@property (nonatomic) BOOL isMyCardAvailable;
@property (nonatomic) BOOL hideContactsDetails;

+ (id)defaultPNGName;
-(bool)isFaceTimeContact:(NSString*)identifier;
-(bool)isIMessageContact:(NSString*)identifier;
@end
