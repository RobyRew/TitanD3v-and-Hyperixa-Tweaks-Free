#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "ContactViewController.h"
#import "CustomNavigationController.h"
#import "SettingManager.h"
#import "Interfaces.h"
#include <dlfcn.h>

static NSString *BID = @"com.TitanD3v.PhoenixPrefs";
static BOOL togglePhoenix;
BOOL isAddNewCoverImage = NO;
UIImageView *contactCoverImageView;

@interface PhoneTabBarController
- (void)setContactsViewController:(id)arg1;
- (void)setKeypadViewController:(id)arg1;
@end


%group PhoenixHook

%hook PhoneTabBarController

- (void)setContactsViewController:(UIViewController*)arg1 {
  ContactViewController *contactVC = [[ContactViewController alloc] init];
  arg1 = [[%c(CustomNavigationController) alloc] initWithRootViewController:contactVC];
  arg1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contacts" image:[UIImage systemImageNamed:@"person.crop.circle" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:22]] tag:0];
  %orig;
}

- (id)init {
  [self setContactsViewController:nil];
  return %orig;
}
%end


%hook UIColor
+(id)systemBlueColor {
  return [[SettingManager sharedInstance] accentColour];
}
%end


%hook PHBottomBarButton
-(void)setBackgroundColor:(UIColor *)color {

  %orig([[SettingManager sharedInstance] accentColour]);
}
%end


%hook MPFavoritesTableViewCell

-(void)layoutSubviews {
  %orig;

  self.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.layer.cornerRadius = 15;
  self.layer.cornerCurve = kCACornerCurveContinuous;
  self.clipsToBounds = YES;
  self.contentView.clipsToBounds = YES;

  CGRect updateFrame = self.frame;
  updateFrame.size.height = 65;
  self.frame = updateFrame;

}

%end


%hook MPFavoritesTableViewController

-(void)viewDidLoad {

  %orig;

  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat updateHeight = %orig;
  updateHeight = 75;
  return updateHeight;
}

%end


%hook MPRecentsTableViewCell

-(void)layoutSubviews {
  %orig;

  self.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.layer.cornerRadius = 15;
  self.layer.cornerCurve = kCACornerCurveContinuous;
  self.clipsToBounds = YES;
  self.contentView.clipsToBounds = YES;


  CGRect updateFrame = self.frame;
  updateFrame.size.height = 65;
  self.frame = updateFrame;

}

%end


%hook MPRecentsTableViewController

-(void)viewDidLoad {

  %orig;

  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.rowHeight = 75;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat updateHeight = %orig;
  updateHeight = 75;
  return updateHeight;
}

%end


%hook CNUINavigationListViewController
%property (nonatomic, copy) CNContact *contact;

- (void)setItems:(NSArray*)arg1{
  NSMutableArray *itemArray = [arg1 mutableCopy];
  CNUINavigationListItem *newItem = [[CNUINavigationListItem alloc] initWithTitle:@"Delete Contact"];
  UIImage *trashIcon = [UIImage systemImageNamed:@"trash.fill"];
  trashIcon = [trashIcon imageWithTintColor:[UIColor systemRedColor]];
  [newItem setImage:trashIcon];
  [itemArray addObject:newItem];
  %orig(itemArray);
}


-(void)navigationListView:(id)arg1 didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
  long deleteIndex = self.items.count - 1;
  if(indexPath.row == deleteIndex){
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest deleteContact:[self.contact mutableCopy]];

    UIAlertController * alert = [UIAlertController  alertControllerWithTitle:@"Delete Contact"
    message:@"Are you sure you want to delete this contact?"
    preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"YES"
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * action) {
      [contactStore executeSaveRequest:saveRequest error:nil];
      [self dismissViewControllerAnimated:NO completion:nil];
    }];

    UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"NO"
    style:UIAlertActionStyleDestructive
    handler:^(UIAlertAction * action) {
    }];

    [alert addAction:yesButton];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
  }
  %orig;
}

%end


%hook CNAvatarCardViewController
%property (nonatomic, copy) CNContact *contact;

- (void)setCardController:(id)arg1 {
  %orig;
  CNContactActionsController *actionsController = arg1;
  CNContact *contact = actionsController.contact;

  if(!contact || contact.unknown)
  return;

  [[(NSObject *)self valueForKey:@"actionListViewController"] setValue:actionsController.contact forKey:@"contact"];
}
%end


%hook UITableView

-(UIEdgeInsets)_sectionContentInset {
  UIEdgeInsets orig = %orig;

  bool isRecent = [self.dataSource isKindOfClass:[%c(MPRecentsTableViewController) class]];
  bool isFav = [self.prefetchDataSource isKindOfClass:[%c(MPFavoritesTableViewController) class]];

  if(isRecent || isFav){
    return UIEdgeInsetsMake(orig.top, 20, orig.bottom, 20);
  }

  return orig;
}
%end


%hook CNContactContentViewController

-(BOOL)allowsActions{
  return 1;
}

-(BOOL)allowsContactBlocking{
  return 1;
}

-(void)setAllowsEditPhoto:(BOOL)arg1{
  %orig(1);
}

-(BOOL)allowsDeletion{
  return 1;
}

-(void)setAllowsDeletion:(BOOL)arg1{
  %orig(1);
}
%end


%hook CNActionsView
- (void)addActionItem:(CNActionItem *)action {
  %orig;
  if ([action.type isEqualToString:@"AudioCallActionType"]) {
    CNActionItem *action = [[%c(CNActionItem) alloc] initWithImage:[UIImage systemImageNamed:@"photo.fill"] type:@"SET_COVER_IMAGE"];
    [action setTitle:@"Cover Image"];
    [self addActionItem:action];
  }
}
%end


%hook CNContactInlineActionsViewController
- (void)didSelectAction:(CNActionItem *)action withSourceView:(id)arg2 longPress:(BOOL)arg3 {
  if ([action.type isEqualToString:@"SET_COVER_IMAGE"]) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Phoenix/PresentPhotoPickerVC" object:nil userInfo:nil];
  } else {
    %orig;
  }
}
%end


%hook CNContactContentViewController

-(void)viewDidDisappear:(BOOL)arg1 {
  %orig;
  isAddNewCoverImage = NO;
}

- (id)headerHeightConstraint{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Phoenix/updateCoverImageHeight" object:nil userInfo:nil];
  return %orig;
}

%end



%hook CNContactHeaderDisplayView
%property (nonatomic, copy) UIImage *headerImage;
%property (nonatomic, copy) NSString *contactId;


-(id)initWithContact:(id)arg1 frame:(CGRect)arg2 monogrammerStyle:(long long)arg3 shouldAllowImageDrops:(BOOL)arg4 showingNavBar:(BOOL)arg5 monogramOnly:(BOOL)arg6 delegate:(id)arg7 {

  [[NSNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.Phoenix/updateCoverImageHeight" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
    contactCoverImageView.frame = self.frame;
  }];
  return %orig;
}


-(void)layoutSubviews{
  %orig;

  if(isAddNewCoverImage || [self contacts].count == 0)
  return;

  isAddNewCoverImage = YES;

  CNContact *contact = [self contacts][0];
  self.contactId = contact.identifier;

  self.headerImage = [self coverImageForCID:self.contactId];

  if(!self.headerImage) {

    contactCoverImageView = [[UIImageView alloc] init];
    contactCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    contactCoverImageView.clipsToBounds = YES;
    contactCoverImageView.frame = self.frame;
    contactCoverImageView.layer.cornerRadius = 20;
    contactCoverImageView.layer.cornerCurve = kCACornerCurveContinuous;
    contactCoverImageView.layer.maskedCorners = 12;
    [self insertSubview:contactCoverImageView atIndex:0];

  } else {

    contactCoverImageView = [[UIImageView alloc] initWithImage:self.headerImage];
    contactCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    contactCoverImageView.clipsToBounds = YES;
    contactCoverImageView.frame = self.frame;
    contactCoverImageView.layer.cornerRadius = 20;
    contactCoverImageView.layer.cornerCurve = kCACornerCurveContinuous;
    contactCoverImageView.layer.maskedCorners = 12;
    [self insertSubview:contactCoverImageView atIndex:0];
  }

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentImagePickerVC) name:@"com.TitanD3v.Phoenix/PresentPhotoPickerVC" object:nil];
}



%new
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

  UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
  self.headerImage = chosenImage;
  contactCoverImageView.image = chosenImage;
  CNContact *contact = [self contacts][0];
  self.contactId = contact.identifier;
  [self setCoverImageForCID:self.contactId image:self.headerImage];

  [picker dismissViewControllerAnimated:YES completion:nil];

}



%new
-(void)presentImagePickerVC {

  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  picker.allowsEditing = YES;

  UIViewController *controller = [self _viewControllerForAncestor];
  [controller presentViewController:picker animated:YES completion:nil];
}


%new
-(UIImage *)coverImageForCID:(NSString *)CID {

  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/PhoenixBannerImages.plist", aDocumentsDirectory];
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  return [[UIImage alloc] initWithData:dict[CID]];
}


%new
-(void)setCoverImageForCID:(NSString *)CID image:(UIImage*)coverImage {

  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/PhoenixBannerImages.plist", aDocumentsDirectory];
  NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ?: [NSMutableDictionary new];
  [mutableDict setObject:UIImagePNGRepresentation(coverImage) forKey:CID];
  [mutableDict writeToFile:plistPath atomically:YES];
}

%end

%end


void SettingsChanged() {
  togglePhoenix = [[TDTweakManager sharedInstance] boolForKey:@"togglePhoenix" defaultValue:NO ID:BID];
}

%ctor {

  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.PhoenixPrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  SettingsChanged();

  if (togglePhoenix) {
    %init(PhoenixHook);
  }

}
