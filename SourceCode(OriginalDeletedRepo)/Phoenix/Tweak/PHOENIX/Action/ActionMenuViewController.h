#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "ContactsData.h"
#import "ActionMenuCell.h"
#import "TDAnimator.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "SettingManager.h"

@protocol DeleteContactProtocol <NSObject>
@required
-(void)needRefreshDataSourceAfterDeleteContact;
@end

@interface ActionMenuViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong) CNContactStore *store;
@property (strong) CNContact *contact;
-(instancetype)initWithData:(ContactsData *)data cncontact:(CNContact *)cncontact height:(CGFloat)height;
@property (nonatomic, retain) ContactsData *contactData;
@property (nonatomic, retain) TDAnimator *myAnimator;
@property (nonatomic, retain) UIImageView *avatar;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *actionArray;
@property(nonatomic,assign)id delegate;
@end
