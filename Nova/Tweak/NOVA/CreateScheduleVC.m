#import "CreateScheduleVC.h"
#import "../Headers.h"
//[Black NewCodeStarts] replace your file with this file's code

static NSDate *pickedDate;
static NSString *finalPhoneNumber;
static NSString *messageLabel;

static NSMutableArray *phoneNumbers;

static NSString *recipientLabel;
ScheduleManager *sharedInstance;

static NSString *withID;

@implementation CreateScheduleVC

- (void)viewDidLoad {
  [super viewDidLoad];

  loadPrefs();

  self.view.backgroundColor = [UIColor backgroundColour];
  self.title = @"New Schedule";

  if (toggleWallpaper) {
      UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
      backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
      backgroundImage.image = [UIImage imageWithData:wallpaperImage];
      [self.view addSubview:backgroundImage];
  }

  self.contactAvatarImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Nova.bundle/Assets/avatar.png"];

  if (toggleCustomColour) {
    self.navigationController.navigationBar.barTintColor = [[TDTweakManager sharedInstance] colourForKey:@"navbarColour" defaultValue:@"FFFFFF" ID:BID];
  }
  self.navigationController.navigationBar.tintColor = [UIColor accentColour];
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor fontColour]}];

  UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveScheduleMessage)];
  self.navigationItem.rightBarButtonItem = saveButton;


  self.defaultChatHeight = 40;

  [self layoutTableView];

  [self performSelector:@selector(refreshSenderChatHeight) withObject:nil afterDelay:0.1];

  self.savedImageArray = [NSMutableArray array];
  self.savedImagePathArray = [NSMutableArray array];

  sharedInstance  = [[ScheduleManager sharedInstance] init];

  withID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000.0)];
}


-(void)refreshSenderChatHeight {

  [self.tableView beginUpdates];
  [UIView animateWithDuration:.3 animations:^(void) {
    CGFloat paddingForTextView = 10;
    self.defaultChatHeight = self.senderTextView.contentSize.height + paddingForTextView;
  }];
  [self.tableView endUpdates];

}


-(void)layoutTableView {

  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.view addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  if (section == 0) { // Contact
    return 1;
  } else if (section == 1) { // Future
    return 1;
  } else { // Sent
    return 1;
  }

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  } else {
    return 35.0f;
  }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

  UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width -15, 45)];
  sectionHeaderView.backgroundColor = UIColor.clearColor;
  sectionHeaderView.layer.cornerRadius = 15;
  sectionHeaderView.clipsToBounds = true;

  UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, sectionHeaderView.frame.size.height /2 -9, 200, 18)];
  headerLabel.backgroundColor = [UIColor clearColor];
  headerLabel.textColor = [UIColor fontColour];
  headerLabel.textAlignment = NSTextAlignmentLeft;
  headerLabel.font = [UIFont boldSystemFontOfSize:16];
  [sectionHeaderView addSubview:headerLabel];

  if (section == 0) {
    headerLabel.text = @"";
  } else if (section == 1) {
    headerLabel.text = @"Date & Time";
  } else {
    headerLabel.text = @"Message";
  }

  return sectionHeaderView;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  if (indexPath.section == 0) {

    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
      cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;

    cell.avatarImage.image = self.contactAvatarImage;
    [cell.avatarImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(contactButtonTappedForCell:)]];
    cell.avatarImage.userInteractionEnabled = YES;

    cell.contactDelegate = self;
    cell.menuButton.menu = [self contactMenu];
    cell.menuButton.showsMenuAsPrimaryAction = true;

    return cell;

  } else if (indexPath.section == 1) {

    DateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
      cell = [[DateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;


    self.datePicker = [[UIDatePicker alloc] init];
    [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    self.datePicker.preferredDatePickerStyle = UIDatePickerStyleCompact;
    [self.datePicker setValue:[UIColor fontColour] forKey:@"textColor"];
    [cell.contentView addSubview:self.datePicker];

    [self.datePicker size:CGSizeMake(190, 40)];
    [self.datePicker y:cell.baseView.centerYAnchor];
    [self.datePicker trailing:cell.baseView.trailingAnchor padding:-10];


    return cell;

  } else {

    BubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
      cell = [[BubbleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;

    self.senderTextView = [[UITextView alloc] init];
    self.senderTextView.delegate = self;
    self.senderTextView.backgroundColor = UIColor.systemBlueColor;
    self.senderTextView.contentInset = UIEdgeInsetsMake(0, 5, 0, 0);
    self.senderTextView.font = [UIFont systemFontOfSize:18];
    self.senderTextView.layer.cornerRadius = 20;
    self.senderTextView.layer.maskedCorners = 14;
    self.senderTextView.text = @"Write a message...";
    self.senderTextView.editable = NO;
    self.senderTextView.textColor = [UIColor bubbleFontColour];
    [cell.contentView addSubview:self.senderTextView];

    [self.senderTextView trailing:cell.baseView.trailingAnchor padding:0];
    [self.senderTextView leading:cell.baseView.leadingAnchor padding:0];
    [self.senderTextView top:cell.baseView.topAnchor padding:0];
    [self.senderTextView bottom:cell.baseView.bottomAnchor padding:0];

    [self.senderTextView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentMessageVC)]];


    return cell;
  }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  float heights;

  if (indexPath.section == 0) {
    heights = 260;
  } else if (indexPath.section == 1) {
    heights = 60;
  }else {
    heights = self.defaultChatHeight;
  }

  return heights;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

  if (toggleHaptic) {

    if (hapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (hapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (hapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }

  }

  if (indexPath.section == 2) {
    [self presentMessageVC];
  }

}


-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {

  self.didAddedContacts = YES;

  phoneNumbers = [[NSMutableArray alloc] init];
  CNContactStore *store = [[CNContactStore alloc] init];

  [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {

    CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
    picker.delegate = self;
    picker.displayedPropertyKeys = @[CNContactGivenNameKey];

    [self presentViewController:picker animated:YES completion:nil];

  }];


  if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {

    NSIndexPath *_indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    ContactCell *cell = (ContactCell *)[self.tableView cellForRowAtIndexPath:_indexPath];

    if (contact.imageData != nil ) {
      UIImage *CIMage = [UIImage imageWithData:(NSData *)contact.imageData];
      cell.avatarImage.image = CIMage;
      self.contactAvatarImage = CIMage;
    } else {
      cell.avatarImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Nova.bundle/Assets/avatar.png"];
    }

    firstName = contact.givenName;
    surnameName = contact.familyName;

    recipientLabel = [NSString stringWithFormat:@"%@ %@", firstName, surnameName];

    cell.nameLabel.text = recipientLabel;
    self.contactFullName = recipientLabel;

    for (NSString* phoneNumber in contact.phoneNumbers){

      NSString * phoneLabel = [phoneNumber valueForKey:@"label"];

      if ([phoneLabel rangeOfString:@"Home"].location != NSNotFound){

        homePhoneNumber = [[phoneNumber valueForKey:@"value"] valueForKey:@"digits"];
        mobilePhoneNumber = @"";
        iphonePhoneNumber = @"";

      }else{

        homePhoneNumber = @"";
      }

      if ([phoneLabel rangeOfString:@"Mobile"].location != NSNotFound){ // Add iPhone

        mobilePhoneNumber = [[phoneNumber valueForKey:@"value"] valueForKey:@"digits"];
        homePhoneNumber = @"";
        iphonePhoneNumber = @"";

      }else{

        mobilePhoneNumber = @"";
      }

      if ([phoneLabel rangeOfString:@"iPhone"].location != NSNotFound){

        iphonePhoneNumber = [[phoneNumber valueForKey:@"value"] valueForKey:@"digits"];
        homePhoneNumber = @"";
        mobilePhoneNumber = @"";

      }else{

        iphonePhoneNumber = @"";
      }


      // if([mobilePhoneNumber length] != 0)
      //   finalPhoneNumber = [NSString stringWithFormat:@"%@", mobilePhoneNumber];
      // if([iphonePhoneNumber length] != 0)
      //   finalPhoneNumber = [NSString stringWithFormat:@"%@", iphonePhoneNumber];
      // else
      //   finalPhoneNumber = [NSString stringWithFormat:@"%@", homePhoneNumber];

      // UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Nova" message:@"This contact has multiple phone numbers. Please pick one contact from below." preferredStyle:UIAlertControllerStyleActionSheet];
      // alertController.modalPresentationStyle = UIModalPresentationPopover;

      if([mobilePhoneNumber length] != 0){
        finalPhoneNumber = [NSString stringWithFormat:@"%@", mobilePhoneNumber];
      }

      if([iphonePhoneNumber length] != 0){
        finalPhoneNumber = [NSString stringWithFormat:@"%@", iphonePhoneNumber];
      }

      if([homePhoneNumber length] != 0){
        finalPhoneNumber = [NSString stringWithFormat:@"%@", homePhoneNumber];
      }

      if(![phoneNumbers containsObject:finalPhoneNumber])
      [phoneNumbers addObject:finalPhoneNumber];

      self.fullPhoneNumber = finalPhoneNumber;

      NSString *lastChr = [finalPhoneNumber substringFromIndex: [finalPhoneNumber length] - 3];

      NSMutableString *mask = [[NSMutableString alloc]init];

      for (int i=0; i<[finalPhoneNumber length]-3; i++) {
        [mask appendString:@"•"];

      }
      [mask appendString:lastChr];

      cell.phoneLabel.text = mask;


    }
  }
}


- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {

}

- (void)datePickerChanged:(UIDatePicker *)datePicker {
  pickedDate = [datePicker date];
}


-(void)presentMessageVC {

  if (self.didAddedContacts) {
    ComposeMessageVC *mvc = [[ComposeMessageVC alloc] init];
    mvc.modalInPresentation = YES;
    mvc.messageDataDelegate = self;
    if (self.includedAttachmentImages){
      [mvc setDidAddedAttachmentImages:YES];
    }
    mvc.recipientNameString = self.contactFullName;
    mvc.recipientAvatarImage = self.contactAvatarImage;
    [self presentViewController:mvc animated:YES completion:nil];


    if (![self.senderTextView.text isEqualToString:@"Write a message..."]) {
      mvc.senderTextString = self.senderTextView.text;
    }

    mvc.imageArray = self.savedImageArray;

  } else {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Please choose contact before you can compose a message." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

    }];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
  }

}


-(void)saveScheduleMessage {

  if (toggleHaptic) {

    if (hapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (hapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (hapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }
  }


  messageLabel = self.senderTextView.text;


  if([recipientLabel length] == 0 || [messageLabel length] == 0 || pickedDate == nil || [finalPhoneNumber length] == 0){
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nova" message:@"Please enter all the required details." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* cnlButton = [UIAlertAction actionWithTitle:@"OK"
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * action) {
      [alert dismissViewControllerAnimated:YES completion:nil];
    }];

    [alert addAction:cnlButton];
    [self presentViewController:alert animated:YES completion:nil];
  }
  else if ([phoneNumbers count] > 1){

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Nova" message:@"This contact has multiple phone numbers. Please pick one phone number from below." preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.modalPresentationStyle = UIModalPresentationPopover;

    for(NSString *phoneNumber in phoneNumbers){
      [alertController addAction:[UIAlertAction actionWithTitle:phoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        finalPhoneNumber = phoneNumber;
        NSString *imgName = [NSString stringWithFormat:@"/Library/Application Support/Nova.bundle/Avatars/%@-Avatar.png", withID];
        NSDictionary *data = @{@"id" : withID, @"attachedImages" : self.savedImagePathArray, @"recipientLabel" : recipientLabel, @"messageLabel" : messageLabel, @"scheduleLabel" : pickedDate, @"phoneNumber" : finalPhoneNumber, @"isSent" : @NO, @"avatarImage" : imgName};
        [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/addScheduleWithId" object:nil userInfo:@{@"withID" : withID, @"data" : data} deliverImmediately:YES];
        [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/ActiveScheduleVCReload" object:nil userInfo:nil deliverImmediately:YES];

        [self.navigationController popViewControllerAnimated:YES];
      }]];
    }

    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
    [self presentViewController:alertController animated:YES completion:nil];
  }
  else{


    NSString *imgName = [NSString stringWithFormat:@"/Library/Application Support/Nova.bundle/Avatars/%@-Avatar.png", withID];
    NSDictionary *data = @{@"id" : withID, @"attachedImages" : self.savedImagePathArray, @"recipientLabel" : recipientLabel, @"messageLabel" : messageLabel, @"scheduleLabel" : pickedDate, @"phoneNumber" : finalPhoneNumber, @"isSent" : @NO, @"avatarImage" : imgName};
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/addScheduleWithId" object:nil userInfo:@{@"withID" : withID, @"data" : data} deliverImmediately:YES];
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/ActiveScheduleVCReload" object:nil userInfo:nil deliverImmediately:YES];

    [self.navigationController popViewControllerAnimated:YES];

  }

  //[Black NewCodeStarts] this is where we save users Avatar to /tmp/ and will copy from there to App support
  if(self.contactAvatarImage){
    NSString *imgName = [NSString stringWithFormat:@"/tmp/%@-Avatar.png", withID];
    [UIImagePNGRepresentation(self.contactAvatarImage) writeToFile:imgName atomically:YES];
  }
}


- (void)contactButtonTappedForCell:(UITableViewCell *)cell {

  [self invokeHapticFeedback];

  CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
  picker.delegate = self;
  picker.displayedPropertyKeys = @[CNContactGivenNameKey];
  [self presentViewController:picker animated:YES completion:nil];
}


-(UIMenu *)contactMenu {

  UIAction *photoAction = [UIAction actionWithTitle:@"Choose Contact Photo" image:[UIImage systemImageNamed:@"photo.fill"] identifier:nil handler:^(UIAction *action) {
    [self presentPhotoPickerVC];
    [self invokeHapticFeedback];
  }];

  UIAction *previewAction = [UIAction actionWithTitle:@"Show Phone Number" image:[UIImage systemImageNamed:@"eye.fill"] identifier:nil handler:^(UIAction *action) {
    NSIndexPath *_indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    ContactCell *cell = (ContactCell *)[self.tableView cellForRowAtIndexPath:_indexPath];
    cell.phoneLabel.text = self.fullPhoneNumber;
    [self invokeHapticFeedback];
  }];

  return [UIMenu menuWithTitle:@"Contact Settings" children:@[photoAction, previewAction]];
}


-(void)presentPhotoPickerVC {

  UIImagePickerController *avatarImagePickerController = [[UIImagePickerController alloc] init];
  avatarImagePickerController.delegate = self;
  avatarImagePickerController.allowsEditing = false;
  avatarImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  [self presentViewController:avatarImagePickerController animated:YES completion:nil];

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {

  NSIndexPath *_indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
  ContactCell *cell = (ContactCell *)[self.tableView cellForRowAtIndexPath:_indexPath];
  cell.avatarImage.image = info[UIImagePickerControllerOriginalImage];
  self.contactAvatarImage = info[UIImagePickerControllerOriginalImage];
  [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)passDataToCreateVC:(NSMutableArray *)imageArrays message:(NSString *)messageString includedAttachment:(BOOL)didIncludedAttachment {

  self.senderTextView.text = messageString;

  if (self.senderTextView.text && self.senderTextView.text.length > 0) {
    self.senderTextView.text = messageString;
  } else {
    self.senderTextView.text = @"Write a message...";
  }

  [self.tableView beginUpdates];
  [UIView animateWithDuration:.3 animations:^(void) {
    CGFloat paddingForTextView = 10;
    self.defaultChatHeight = self.senderTextView.contentSize.height + paddingForTextView;
  }];
  [self.tableView endUpdates];


  if (didIncludedAttachment) {
    self.includedAttachmentImages = YES;
  }


  if (imageArrays != nil) {
    self.savedImageArray = imageArrays;
    
    long imgCount = 0;
    NSString *imgName;
    
    while(imgCount < self.savedImageArray.count){
      UIImage *image = self.savedImageArray[imgCount];
      imgName = [NSString stringWithFormat:@"/tmp/%@-%ld.png", withID, imgCount];
      [UIImagePNGRepresentation(image) writeToFile:imgName atomically:YES];
      [self.savedImagePathArray addObject:imgName];
      imgCount++;
    }

  }

}


-(void)invokeHapticFeedback {
    if (toggleHaptic) {
    if (hapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (hapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (hapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }
  }
}

@end
