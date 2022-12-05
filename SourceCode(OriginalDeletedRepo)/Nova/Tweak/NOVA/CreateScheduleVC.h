#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "ActiveCell.h"
#import "ContactCell.h"
#import "DateCell.h"
#import "BubbleCell.h"
#import "ComposeMessageVC.h"
#import "Colour-Scheme.h"

//[Black NewCodeStarts] replace your file with this file's code

@interface CreateScheduleVC : UIViewController <UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate, UITextViewDelegate, ContactButtonDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

  NSString *firstName;
  NSString *surnameName;
  NSString *mobilePhoneNumber;
  NSString *homePhoneNumber;
  NSString *iphonePhoneNumber;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSString *fullPhoneNumber;
@property (nonatomic, retain) UIImage *contactAvatarImage;
@property (nonatomic, retain) UITextView *senderTextView;
@property (nonatomic, assign) CGFloat defaultChatHeight;
@property (nonatomic, retain) NSMutableArray *savedImageArray;
@property (nonatomic, retain) NSMutableArray *savedImagePathArray;
@property (nonatomic) BOOL includedAttachmentImages;
@property (nonatomic, retain) NSString *contactFullName;
@property (nonatomic) BOOL didAddedContacts;
@end
