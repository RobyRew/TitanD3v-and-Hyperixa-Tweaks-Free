#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import <Contacts/Contacts.h>

@interface PHVoicemailMessageTableViewCell : UITableViewCell
@end 

@interface PHVoicemailMailboxTableViewCell : UITableViewCell
@end 

@interface CNContactListTableView : UITableView
@end 

@interface MPVoicemailMailboxTableViewCell : UITableViewCell
@end 

@interface CNContactListTableViewCell : UITableViewCell
@end 

@interface CNContactListViewController : UITableViewController
@end 

@interface PHVoicemailInboxListViewController : UITableViewController
@end 

@interface PHVoicemailTrashListViewController : UITableViewController
@end 

@interface MPFavoritesTableViewCell : UITableViewCell
@end 

@interface MPFavoritesTableViewController : UITableViewController
@end 

@interface MPRecentsTableViewCell : UITableViewCell
@end 

@interface MPRecentsTableViewController : UITableViewController
@end 

// @interface PHHandsetDialerNumberPadButton : UIControl
// @property (retain) UIView *circleView;
// @end

// @implementation PHHandsetDialerNumberPadButton
// @synthesize circleView=_circleView;
// @end

// @interface TPDialerNumberPad : UIView
// @end

// @interface PHBottomBarButton : UIButton
// @end

@interface CNContactListHeaderFooterView : UIView
@end 

@interface _UITableViewHeaderFooterViewLabel : UILabel 
@end


@interface RTTTelephonyUtilities
+(id)sharedUtilityProvider;
-(id)myPhoneNumber;
@end

@interface CNContact(Priv)
@property (getter=isUnknown,nonatomic,readonly) BOOL unknown; 
@end

@interface CNUINavigationListItem : NSObject
-(void)setImage:(UIImage *)arg1 ;
-(NSString *)subtitle;
-(id)initWithTitle:(id)arg1 ;
-(void)setSubtitle:(NSString *)arg1 ;
-(void)setItems:(NSArray *)arg1 ;
-(void)setIdentifier:(NSString *)arg1 ;
-(void)setDefaultItem:(id)arg1 ;
@end

@interface CNUINavigationListViewController : UIViewController
@property (nonatomic, copy) CNContact *contact;
-(NSArray *)items;
@end

@interface CNContactActionsController
@property (nonatomic, strong, readwrite) CNContact *contact;
@end

@interface CNAvatarCardViewController
@property (nonatomic, strong, readwrite) CNContactActionsController *actionsController;
- (id)actionListViewController;
-(void)dismissAnimated:(BOOL)arg1 ;
@end

@interface CNContactHeaderView : UIView
@property (nonatomic,retain) NSArray * contacts;
@property (nonatomic,retain) UILabel *nameLabel;  
@end

//This is to add contacts headers image
@interface CNContactHeaderDisplayView : CNContactHeaderView <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, copy) UIImage *headerImage;
@property (nonatomic, copy) NSString *contactId;
- (UIViewController *)_viewControllerForAncestor;

-(UIImage *)coverImageForCID:(NSString *)CID;
-(void)setCoverImageForCID:(NSString *)CID image:(UIImage*)headerImage;
@end

@interface CNActionItem : NSObject
- (id)initWithImage:(id)arg1 type:(id)arg2;
- (void)setTitle:(id)arg1;
- (NSString *)type;
@end

@interface CNActionsView : UIView <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (void)addActionItem:(CNActionItem *)action;
@end


@interface CNContactInlineActionsViewController : UIViewController
@end