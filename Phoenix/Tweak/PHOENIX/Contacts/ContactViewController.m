#import "ContactViewController.h"

long totalContact = 0;

NSMutableArray *arraySearchContactData;

static void deleteDataForID(NSString *idToRemove){

  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/AllFavourites.plist", aDocumentsDirectory];
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
  [mutableDict removeObjectForKey:idToRemove];
  [mutableDict writeToFile:plistPath atomically:YES];

}


static void deleteCategoriesForID(NSString *idToRemove, NSString*categories) {

  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/%@.plist", aDocumentsDirectory, categories];
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
  [mutableDict removeObjectForKey:idToRemove];
  [mutableDict writeToFile:plistPath atomically:YES];

}

static void writePhoneNumberToPlist(NSString * phoneNumber){
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/%@.plist", aDocumentsDirectory, @"PhoenixPhoneNumber"];
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
  [mutableDict setObject:phoneNumber forKey:@"myPhoneNumber"];
  [mutableDict writeToFile:plistPath atomically:YES];
}

static CNContact *getMyContact(){
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/%@.plist", aDocumentsDirectory, @"PhoenixPhoneNumber"];
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  
  if(!dict[@"myPhoneNumber"])
    return nil;

  id keysToFetch = @[[CNContactViewController descriptorForRequiredKeys]];
  CNContactStore *contactStore = [[CNContactStore alloc] init];
  NSError *error;
  return [contactStore unifiedContactsMatchingPredicate:[CNContact predicateForContactsWithIdentifiers:@[dict[@"myPhoneNumber"]]] keysToFetch:keysToFetch error:&error][0];
}


@implementation ContactViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
  [self refreshData];
}


- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
  [super viewDidLoad];
  arraySearchContactData = [NSMutableArray new];

  self.view.backgroundColor = UIColor.systemBackgroundColor;
  UIWindow *keyWindow = nil;
  NSArray *windows = [[UIApplication sharedApplication] windows];
  for (UIWindow *window in windows) {
    if (window.isKeyWindow) {
      keyWindow = window;
      break;
    }
  }

  keyWindow.tintColor = [[SettingManager sharedInstance] accentColour];
  self.view.tintColor = [[SettingManager sharedInstance] accentColour];
  self.accentColour = [[SettingManager sharedInstance] accentColour];
  self.store = [[CNContactStore alloc] init];

  self.categoriesName = [[SettingManager sharedInstance] objectForKey:@"savedCategoriesName" defaultValue:@"All Favourites"];
  self.showFavourite = [[SettingManager sharedInstance] boolForKey:@"showFavourites" defaultValue:YES];
  self.hideContactsDetails = [[SettingManager sharedInstance] boolForKey:@"hideContactsDetails" defaultValue:NO];

  if(getMyContact() && !self.meContact){
    self.meContact = getMyContact();
    self.isMyCardAvailable = YES;
  }
  else
    self.isMyCardAvailable = NO;

  [self copyDefaultCategoriesPlist];
  [self getFavouriteData];
  [self layoutHeaderView];
  [self getContacts];
  [self appendContacts];
  [self layoutTableView];
  [self layoutBannerAccessoriesView];
  [self checkIfFavouriteIsEmpty];

  if (!self.isMyCardAvailable) {
    [self showAlertWithTitle:@"Me Card" subtitle:@"To setup Me Card click on the Me Card view and choose your own contact from the list, if you dont have your own contact saved please add your phone number to the contact then it will load your details automatically."];
  }

}


-(void)copyDefaultCategoriesPlist {

  NSFileManager *fileManager = [NSFileManager defaultManager];

  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/Categories.plist", aDocumentsDirectory];

  if(![fileManager fileExistsAtPath:plistPath]) {
    NSString *defaultPlist = @"/Library/Application Support/Phoenix.bundle/DefaultCategories/Categories.plist";
    [fileManager copyItemAtPath:defaultPlist toPath:plistPath error:nil];
  }
}


-(void)getFavouriteData {
  // [IMPORTANT]
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *categoriesString = [self.categoriesName stringByReplacingOccurrencesOfString:@" " withString:@""];
  NSString *plistPath = [NSString stringWithFormat:@"%@/%@.plist", aDocumentsDirectory, categoriesString];

  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

  self.favouritesArray = [NSMutableArray new];
  for(NSString *key in mutableDict){
    [self.favouritesArray addObject:mutableDict[key]];

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"fullName" ascending:YES];
    [self.favouritesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
  }

}


-(void)checkIfFavouriteIsEmpty {

  if (self.favouritesArray.count == 0) {
    self.messageView.alpha = 1;
  } else {
    self.messageView.alpha = 0;
  }
}


-(void)layoutHeaderView {

  self.headerView = [[UIView alloc] init];
  [self.view addSubview:self.headerView];

  [self.headerView size:CGSizeMake(self.view.frame.size.width, 150)];
  [self.headerView x:self.view.centerXAnchor];
  [self.headerView top:self.view.topAnchor padding:0];


  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textAlignment = NSTextAlignmentLeft;
  self.titleLabel.textColor = UIColor.labelColor;
  self.titleLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBlack];
  self.titleLabel.text = @"Contacts";
  [self.headerView addSubview:self.titleLabel];

  [self.titleLabel top:self.view.safeAreaLayoutGuide.topAnchor padding:0];
  [self.titleLabel leading:self.headerView.leadingAnchor padding:20];
  [self.titleLabel trailing:self.headerView.trailingAnchor padding:-20];


  self.settingButton = [[UIButton alloc] init];
  [self.settingButton addTarget:self action:@selector(settingVC) forControlEvents:UIControlEventTouchUpInside];
  UIImage *settingImage = [UIImage systemImageNamed:@"gear" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:20]];
  [self.settingButton setImage:settingImage forState:UIControlStateNormal];
  self.settingButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.settingButton.tintColor = self.accentColour;
  self.settingButton.layer.cornerRadius = 10;
  self.settingButton.layer.cornerCurve = kCACornerCurveContinuous;
  self.settingButton.backgroundColor = [self.accentColour colorWithAlphaComponent:0.4];
  [self.headerView addSubview:self.settingButton];

  [self.settingButton size:CGSizeMake(45, 45)];
  [self.settingButton top:self.titleLabel.bottomAnchor padding:10];
  [self.settingButton trailing:self.headerView.trailingAnchor padding:-20];


  self.addButton = [[UIButton alloc] init];
  UIImage *addImage = [UIImage systemImageNamed:@"person.crop.circle.badge.plus" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:20]];
  [self.addButton setImage:addImage forState:UIControlStateNormal];
  self.addButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.addButton.tintColor = self.accentColour;
  self.addButton.layer.cornerRadius = 10;
  self.addButton.layer.cornerCurve = kCACornerCurveContinuous;
  self.addButton.backgroundColor = [self.accentColour colorWithAlphaComponent:0.4];
  self.addButton.menu = [self addContactManager];
  self.addButton.showsMenuAsPrimaryAction = true;
  [self.headerView addSubview:self.addButton];

  [self.addButton size:CGSizeMake(45, 45)];
  [self.addButton top:self.titleLabel.bottomAnchor padding:10];
  [self.addButton trailing:self.settingButton.leadingAnchor padding:-10];


  self.searchBarView = [[UIView alloc] init];
  self.searchBarView.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.searchBarView.layer.cornerRadius = 10;
  self.searchBarView.layer.cornerCurve = kCACornerCurveContinuous;
  self.searchBarView.clipsToBounds = YES;
  [self.headerView addSubview:self.searchBarView];

  [self.searchBarView height:45];
  [self.searchBarView top:self.titleLabel.bottomAnchor padding:10];
  [self.searchBarView leading:self.view.leadingAnchor padding:20];
  [self.searchBarView trailing:self.addButton.leadingAnchor padding:-10];


  self.searchIcon = [[UIImageView alloc] init];
  self.searchIcon.contentMode = UIViewContentModeScaleAspectFit;
  self.searchIcon.tintColor = UIColor.tertiaryLabelColor;
  self.searchIcon.image = [UIImage systemImageNamed:@"magnifyingglass" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:20]];
  [self.searchBarView addSubview:self.searchIcon];

  [self.searchIcon size:CGSizeMake(25, 25)];
  [self.searchIcon y:self.searchBarView.centerYAnchor];
  [self.searchIcon leading:self.searchBarView.leadingAnchor padding:5];


  self.searchTextField = [[UITextField alloc] init];
  self.searchTextField.font = [UIFont systemFontOfSize:18];
  self.searchTextField.placeholder = @"Search contacts...";
  self.searchTextField.backgroundColor = UIColor.clearColor;
  self.searchTextField.tintColor = self.accentColour;
  self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.searchTextField.keyboardType = UIKeyboardTypeDefault;
  self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  self.searchTextField.delegate = self;
  [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
  [self.searchBarView addSubview:self.searchTextField];

  [self.searchTextField top:self.searchBarView.topAnchor padding:0];
  [self.searchTextField leading:self.searchIcon.trailingAnchor padding:5];
  [self.searchTextField trailing:self.searchBarView.trailingAnchor padding:-5];
  [self.searchTextField bottom:self.searchBarView.bottomAnchor padding:0];
}

// -(CNContact*)getMeContact:(NSString *)identifier{
-(bool)isFaceTimeContact:(NSString*)identifier{
  // id keysToFetch = @[[CNContactViewController descriptorForRequiredKeys]];
  // CNContact *contact = [self.store unifiedContactWithIdentifier:identifier keysToFetch:keysToFetch error:nil];

  // self.controller = [CNContactViewController viewControllerForContact:contact];
  // self.controller.delegate = self;

  // NSLog(@"AAAAAAAAAAA isFaceTimeContact_faceTimeAction:-%@", self.controller.contentViewController);
  // NSLog(@"AAAAAAAAAAA isFaceTimeContact_faceTimeAudioAction:-%@", self.controller.contentViewController._faceTimeAudioAction);

  return 1;
}

-(bool)isIMessageContact:(NSString*)identifier{
  // id keysToFetch = @[[CNContactViewController descriptorForRequiredKeys]];
  // CNContact *contact = [self.store unifiedContactWithIdentifier:identifier keysToFetch:keysToFetch error:nil];

  // self.controller = [CNContactViewController viewControllerForContact:contact];
  // self.controller.delegate = self;

  // NSLog(@"AAAAAAAAAAA isIMessageContact_faceTimeAction:-%@", self.controller.contentViewController);
  // NSLog(@"AAAAAAAAAAA isIMessageContact_faceTimeAudioAction:-%@", self.controller.contentViewController._faceTimeAudioAction);

  return 1;
}


-(void)getContacts {

  CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
  if (authorizationStatus != CNAuthorizationStatusAuthorized) {
    NSLog(@"No authorization...");
    return;
  }

  self.contactPeople = [[NSMutableArray alloc] init];

  //[NEW CODE];
  [arraySearchContactData removeAllObjects];

  NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactImageDataKey, CNContactIdentifierKey];
  CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
  CNContactStore *contactStore = [[CNContactStore alloc] init];
  [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {

    NSString *givenName = contact.givenName;
    NSString *familyName = contact.familyName;

    ContactsData *contactData = [[ContactsData alloc] init];
    contactData.firstName = givenName;
    contactData.lastName = familyName;

    NSArray *phoneNumbers = contact.phoneNumbers;
    for (CNLabeledValue *labelValue in phoneNumbers) {
      CNPhoneNumber *phoneNumber = labelValue.value;
      NSString * onePhone = phoneNumber.stringValue;

      contactData.phone = [onePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    }


    NSArray *emailArray = contact.emailAddresses;
    for (CNLabeledValue *labelValue2 in emailArray) {
      NSString *email = labelValue2.value;
      contactData.email = email;
    }


    if (contact.imageData != nil ) {
      UIImage *contactImage = [UIImage imageWithData:(NSData *)contact.imageData];
      contactData.avatar = contactImage;
    }


    NSString *ids = contact.identifier;
    contactData.identifier = ids;


    [self.contactPeople addObject:contactData];

    self.contactPeople = [[self.contactPeople sortedArrayUsingComparator:^(ContactsData *obj1, ContactsData *obj2) {
      return [obj1.firstName compare:obj2.firstName options:(NSCaseInsensitiveSearch)];
    }] mutableCopy];

    [arraySearchContactData addObject:contactData];

  }];

}


-(void)appendContacts {

  NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
  validChars = [validChars invertedSet];
  NSMutableArray *notCharContacts = [NSMutableArray new];

  NSMutableArray * columns = [[NSMutableArray alloc] initWithCapacity:26];
  for(int i = 0; i < 26; i ++){
    NSMutableArray * group = [[NSMutableArray alloc] init];
    for(int j = 0; j < self.contactPeople.count ; j++){
      ContactsData *contactData = self.contactPeople [j];
      NSString * letter;
      if(contactData.firstName.length != 0) {
        letter = [contactData.firstName substringToIndex:1];
      }
      else if(contactData.lastName.length != 0) {
        letter = [contactData.lastName substringToIndex:1];
      }

      NSRange  range = [letter rangeOfCharacterFromSet:validChars];
      if (NSNotFound != range.location && letter.length !=0) {
        [notCharContacts addObject:contactData];
      }
      else if( letter == [NSString stringWithFormat: @"%c", i+'A'] ){
        [group addObject:contactData];
      }

      
    }
    if (group.count) {
      [columns addObject:group];
    }
  }

  self.parsedContacts = columns;
  NSMutableArray* letters = [[NSMutableArray alloc] init];

  if(notCharContacts.count !=0){
    NSArray *aSortedArray = [notCharContacts sortedArrayUsingComparator:^(ContactsData *obj1, ContactsData *obj2) {
      return (NSComparisonResult) [obj1.firstName compare:obj2.firstName options:(NSCaseInsensitiveSearch)];
    }];

    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:aSortedArray];
    aSortedArray = [[orderedSet array] mutableCopy];

    [self.parsedContacts addObject:aSortedArray];
  }

  for(int i = 0; i < self.parsedContacts.count; i ++){
    NSString * item = [NSString stringWithFormat:@"%c", i+'A'];
    [letters addObject:item];
  }

  if(notCharContacts.count !=0)
    [letters addObject:@"#"];
  self.sectionIndexTitles = [letters copy];
}


-(void)layoutTableView {

  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;;
  self.tableView.sectionIndexColor = self.accentColour;
  self.tableView.showsVerticalScrollIndicator = NO;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.view addSubview:self.tableView];

  self.tableView.delegate = self;
  self.tableView.dataSource = self;

  [self.tableView top:self.headerView.bottomAnchor padding:0];
  [self.tableView leading:self.view.leadingAnchor padding:0];
  [self.tableView trailing:self.view.trailingAnchor padding:0];
  [self.tableView bottom:self.view.bottomAnchor padding:0];


  self.refreshController = [[UIRefreshControl alloc] init];
  [self.refreshController addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
  NSString *title = @"Refresh Contacts";
  NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:self.accentColour forKey:NSForegroundColorAttributeName];
  NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
  self.refreshController.attributedTitle = attributedTitle;
  self.refreshController.tintColor = self.accentColour;
  [self.tableView addSubview:self.refreshController];


  self.indexBar = [[TDIndexBar alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 0, 25, self.view.frame.size.height)];
  self.indexBar.delegate = self;
  [self.view addSubview:self.indexBar];

  self.indexBar.textColor = self.accentColour;
  self.indexBar.selectedTextColor = self.accentColour;
  self.indexBar.selectedBackgroundColor = UIColor.clearColor;
  self.indexBar.detailViewDrawColor = self.accentColour;
  self.indexBar.detailViewTextColor = UIColor.whiteColor;


  NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
  validChars = [validChars invertedSet];

  NSMutableArray <NSString*> *indices = [[NSMutableArray alloc] init];
  for (int i = 0; i < self.parsedContacts.count; ++i) {
    ContactsData *contactsData = self.parsedContacts[i][0];
    NSString * title;

    
    if (contactsData.firstName.length != 0) {
      title = [contactsData.firstName substringToIndex:1];
    } else {
      title = [contactsData.lastName substringToIndex:1];
    }

    NSRange range = [title rangeOfCharacterFromSet:validChars];
    if (NSNotFound != range.location) {
      title = @"#";
    }

    [indices addObject:title];
  }

  [self.indexBar setIndexes:indices];


  self.bannerView = [[UIView alloc] init];
  if (self.showFavourite) {
    self.bannerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 285);
  } else {
    self.bannerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 80);
  }
  self.tableView.tableHeaderView = self.bannerView;
}


-(void)layoutBannerAccessoriesView {

  if (self.showFavourite) {
    self.favouriteSectionView = [[UIView alloc] init];
    [self.bannerView addSubview:self.favouriteSectionView];

    [self.favouriteSectionView size:CGSizeMake(self.view.frame.size.width, 40)];
    [self.favouriteSectionView top:self.bannerView.topAnchor padding:5];
    [self.favouriteSectionView x:self.bannerView.centerXAnchor];


    self.favouriteSectionLabel = [[UILabel alloc] init];
    self.favouriteSectionLabel.textAlignment = NSTextAlignmentLeft;
    self.favouriteSectionLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.favouriteSectionLabel.textColor = UIColor.tertiaryLabelColor;
    self.favouriteSectionLabel.text = self.categoriesName;
    [self.favouriteSectionView addSubview:self.favouriteSectionLabel];

    [self.favouriteSectionLabel y:self.favouriteSectionView.centerYAnchor];
    [self.favouriteSectionLabel leading:self.favouriteSectionView.leadingAnchor padding:20];


    self.favouriteSectionButton = [[UIButton alloc] init];
    self.favouriteSectionButton.tintColor = self.accentColour;
    UIImage *favImage = [UIImage systemImageNamed:@"switch.2" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:20]];
    [self.favouriteSectionButton setImage:favImage forState:UIControlStateNormal];
    self.favouriteSectionButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.favouriteSectionButton addTarget:self action:@selector(presentFavouriteFilterVC) forControlEvents:UIControlEventTouchUpInside];
    [self.favouriteSectionView addSubview:self.favouriteSectionButton];

    [self.favouriteSectionButton size:CGSizeMake(25, 25)];
    [self.favouriteSectionButton y:self.favouriteSectionView.centerYAnchor];
    [self.favouriteSectionButton trailing:self.favouriteSectionView.trailingAnchor padding:-20];


    self.favouriteView = [[UIView alloc] init];
    [self.bannerView addSubview:self.favouriteView];

    [self.favouriteView size:CGSizeMake(self.view.frame.size.width, 140)];
    [self.favouriteView x:self.bannerView.centerXAnchor];
    [self.favouriteView top:self.favouriteSectionView.bottomAnchor padding:0];


    self.messageView = [[MessageView alloc] init];
    self.messageView.icon.image = [UIImage systemImageNamed:@"heart.fill"];
    self.messageView.icon.tintColor = self.accentColour;
    self.messageView.title.text = @"You don't have any favourites!";
    self.messageView.alpha = 0;
    self.messageView.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.messageView.layer.cornerRadius = 15;
    self.messageView.layer.cornerCurve = kCACornerCurveContinuous;
    [self.favouriteView addSubview:self.messageView];

    [self.messageView top:self.favouriteView.topAnchor padding:0];
    [self.messageView leading:self.favouriteView.leadingAnchor padding:20];
    [self.messageView trailing:self.favouriteView.trailingAnchor padding:-20];
    [self.messageView bottom:self.favouriteView.bottomAnchor padding:0];


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[FavouriteCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.favouriteView addSubview:self.collectionView];

    [self.collectionView height:150];
    [self.collectionView x:self.favouriteView.centerXAnchor];
    [self.collectionView leading:self.favouriteView.leadingAnchor padding:20];
    [self.collectionView trailing:self.favouriteView.trailingAnchor padding:-20];
    [self.collectionView top:self.favouriteView.topAnchor padding:0];


    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
  }

  self.myCardView = [[UIView alloc] init];
  self.myCardView.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.myCardView.layer.cornerRadius = 15;
  self.myCardView.layer.cornerCurve = kCACornerCurveContinuous;
  self.myCardView.clipsToBounds = YES;
  [self.bannerView addSubview:self.myCardView];

  if (self.showFavourite) {
    [self.myCardView size:CGSizeMake(self.view.frame.size.width-40, 70)];
    [self.myCardView x:self.bannerView.centerXAnchor];
    [self.myCardView top:self.favouriteView.bottomAnchor padding:20];
  } else {
    [self.myCardView size:CGSizeMake(self.view.frame.size.width-40, 70)];
    [self.myCardView x:self.bannerView.centerXAnchor];
    [self.myCardView top:self.bannerView.topAnchor padding:10];
  }


  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMyCardVC)];
  tapRecognizer.delegate = self;
  [self.myCardView addGestureRecognizer:tapRecognizer];

  self.avatarImage = [[UIImageView alloc] init];
  if(self.isMyCardAvailable) {
    self.avatarImage.image = [UIImage imageWithData:(NSData *)self.meContact.imageData];
  } else {
    self.avatarImage.image = [[SettingManager sharedInstance] icloudAvatar];
  }
  self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
  self.avatarImage.layer.cornerRadius = 25;
  self.avatarImage.clipsToBounds = YES;
  self.avatarImage.layer.borderWidth = 1.5;
  self.avatarImage.layer.borderColor = self.accentColour.CGColor;
  [self.myCardView addSubview:self.avatarImage];

  [self.avatarImage size:CGSizeMake(50, 50)];
  [self.avatarImage y:self.myCardView.centerYAnchor];
  [self.avatarImage leading:self.myCardView.leadingAnchor padding:10];


  self.contactCardButton = [[UIButton alloc] init];
  self.contactCardButton.tintColor = self.accentColour;
  [self.contactCardButton addTarget:self action:@selector(presentContactCardsVC) forControlEvents:UIControlEventTouchUpInside];
  UIImage *cardImage = [UIImage systemImageNamed:@"rectangle.stack.person.crop.fill" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:20]];
  [self.contactCardButton setImage:cardImage forState:UIControlStateNormal];
  self.contactCardButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  [self.myCardView addSubview:self.contactCardButton];

  [self.contactCardButton size:CGSizeMake(40, 40)];
  [self.contactCardButton y:self.myCardView.centerYAnchor];
  [self.contactCardButton trailing:self.myCardView.trailingAnchor padding:-10];


  self.nameLabel = [[UILabel alloc] init];
  self.nameLabel.textAlignment = NSTextAlignmentLeft;
  self.nameLabel.textColor = UIColor.labelColor;
  self.nameLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
  if(self.isMyCardAvailable) {
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.meContact.givenName, self.meContact.familyName];
  } else {
    self.nameLabel.text = [[SettingManager sharedInstance] icloudFullName];
  }
  [self.myCardView addSubview:self.nameLabel];

  [self.nameLabel top:self.avatarImage.topAnchor padding:3];
  [self.nameLabel leading:self.avatarImage.trailingAnchor padding:10];
  [self.nameLabel trailing:self.contactCardButton.leadingAnchor padding:-10];


  self.countLabel = [[UILabel alloc] init];
  self.countLabel.textAlignment = NSTextAlignmentLeft;
  self.countLabel.textColor = UIColor.labelColor;
  self.countLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
  [self.myCardView addSubview:self.countLabel];

  [self.countLabel bottom:self.avatarImage.bottomAnchor padding:-3];
  [self.countLabel leading:self.avatarImage.trailingAnchor padding:10];
  [self.countLabel trailing:self.contactCardButton.leadingAnchor padding:-10];

  [self updateContactCount];

}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  ContactsData *contactsData = self.parsedContacts [section] [0];
  NSString * title;
  if(contactsData.firstName.length != 0) {
    title = [contactsData.firstName substringToIndex:1];
  } else {
    title = [contactsData.lastName substringToIndex:1];
  }
  return title;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.parsedContacts[section] count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.parsedContacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

  if (cell == nil) {
    cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  }

  UIView *bgColorView = [[UIView alloc] init];
  bgColorView.backgroundColor = UIColor.clearColor;
  [cell setSelectedBackgroundView:bgColorView];

  cell.backgroundColor = UIColor.clearColor;

  ContactsData *contactsData = self.parsedContacts [indexPath.section] [indexPath.row];
  cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", contactsData.firstName, contactsData.lastName];

  //cell.emailLabel.text = contactsData.email;

  if (!self.hideContactsDetails) {
  if (contactsData.phone != nil) {
    cell.numberLabel.text = contactsData.phone;
  } else {
    cell.numberLabel.text = @"No phone number available";
  }


  if (contactsData.email != nil) {
    cell.emailLabel.text = contactsData.email;
  } else {
    cell.emailLabel.text = @"No email address available";
  }
  }


  if (contactsData.avatar !=nil) {
    cell.avatar.image = contactsData.avatar;
  } else {
    cell.avatar.image = [UIImage systemImageNamed:@"person.crop.circle.fill"];
    cell.avatar.tintColor = self.accentColour;
  }

  UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
  [gestureRecognizer addTarget:self action:@selector(contactsLongPressed:)];
  gestureRecognizer.delegate = self;
  gestureRecognizer.minimumPressDuration = 0.3;
  [cell addGestureRecognizer:gestureRecognizer];


  [self isFaceTimeContact:contactsData.identifier];
  [self isIMessageContact:contactsData.identifier];

  return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 75;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];

  invokeHaptic();

  ContactsData *contactsData = self.parsedContacts[indexPath.section][indexPath.row];
  [self showContactDetailsWthID:contactsData.identifier];
  
  self.indexBar.alpha = 1;
  [self.searchTextField resignFirstResponder];
  self.searchTextField.text = nil;
  [self refreshData];
}


-(void)showContactDetailsWthID:(NSString *)identifier {
  // Here we push contact id to show contact details
  id keysToFetch = @[[CNContactViewController descriptorForRequiredKeys]];
  CNContact *contact = [self.store unifiedContactWithIdentifier:identifier keysToFetch:keysToFetch error:nil];


  self.controller = [CNContactViewController viewControllerForContact:contact];
  self.controller.delegate = self;
  self.controller.allowsEditing = YES;
  self.controller.allowsActions = YES;
  [self.navigationController pushViewController:self.controller animated:YES];

}


- (void)textFieldDidChange:(UITextField *)textField {
  [self updateSearchResultWithString:textField.text];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
  [self updateSearchResultWithString:textField.text];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

  [self updateSearchResultWithString:textField.text];

  UIToolbar *textToolbar = [[UIToolbar alloc] init];
  [textToolbar sizeToFit];
  textToolbar.barStyle = UIBarStyleDefault;
  textToolbar.tintColor = self.accentColour;
  textToolbar.items = [self textToolBarButtons];
  self.searchTextField.inputAccessoryView = textToolbar;

  return YES;

}


-(NSArray *)textToolBarButtons {

  NSMutableArray *textButtons = [[NSMutableArray alloc] init];

  [textButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];

  [textButtons addObject:[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)]];

  return [textButtons copy];

}


-(void)dismissKeyboard {
  invokeHaptic();
  [self.searchTextField resignFirstResponder];
}


- (void)indexDidChanged:(TDIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title {
  [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}


-(void)updateSearchResultWithString:(NSString *)string {

  [self.contactPeople removeAllObjects];

  NSString *name = @"";
  NSString *phoneNumber = @"";

  if ([string length] > 0)
  {
    self.indexBar.alpha = 0;
    for (int i = 0; i < [arraySearchContactData count] ; i++)
    {
      ContactsData *data = [arraySearchContactData objectAtIndex:i];
      name = [NSString stringWithFormat:@"%@ %@", data.firstName, data.lastName];
      phoneNumber = data.phone;
      if (name.length >= string.length)
      {
        NSRange titleResultsRange = [name rangeOfString:string options:NSCaseInsensitiveSearch];
        NSRange titleResultsRangePhn = [phoneNumber rangeOfString:string options:NSCaseInsensitiveSearch];
        if (titleResultsRange.length > 0 || titleResultsRangePhn.length >0)
        {
          [self.contactPeople addObject:[arraySearchContactData objectAtIndex:i]];
        }
      }
    }
  }
  else{
    //[New Code]
    self.indexBar.alpha = 1;
    [self.contactPeople removeAllObjects];
    [self.contactPeople addObjectsFromArray:arraySearchContactData];
  }

  [self appendContacts];
  [self.tableView reloadData];
  [self updateContactCount];
}


-(void)refreshData {
  [self.refreshController endRefreshing];
  [self getContacts];
  [self appendContacts];
  [self.tableView reloadData];
  [self updateContactCount];

  self.indexBar.alpha = 1; 
  [self.searchTextField resignFirstResponder];
  self.searchTextField.text = nil;


  NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
  validChars = [validChars invertedSet];

  NSMutableArray <NSString*> *indices = [[NSMutableArray alloc] init];
  for (int i = 0; i < self.parsedContacts.count; ++i) {
    ContactsData *contactsData = self.parsedContacts[i][0];
    NSString * title;

    
    if (contactsData.firstName.length != 0) {
      title = [contactsData.firstName substringToIndex:1];
    } else {
      title = [contactsData.lastName substringToIndex:1];
    }

    NSRange range = [title rangeOfCharacterFromSet:validChars];
    if (NSNotFound != range.location) {
      title = @"#";
    }

    [indices addObject:title];
  }

  [self.indexBar setIndexes:indices];
}


-(void)updateContactCount {

  NSString *countString = [NSString stringWithFormat:@"%ld", self.contactPeople.count];
  self.countLabel.text = [NSString stringWithFormat:@"%@ contacts", countString];

  NSMutableAttributedString *attrsString =  [[NSMutableAttributedString alloc] initWithAttributedString:self.countLabel.attributedText];
  NSRange range = [self.countLabel.text rangeOfString:countString];
  if (range.location != NSNotFound) {
    [attrsString addAttribute:NSForegroundColorAttributeName value:self.accentColour range:range];
  }
  self.countLabel.attributedText = attrsString;

}


-(void)settingVC {
  invokeHaptic();
  SettingViewController *vc = [[SettingViewController alloc] init];
  [self presentViewController:vc animated:YES completion:nil];
}


-(void)addContactVC {
  invokeHaptic();
  CNMutableContact *contact = [[CNMutableContact alloc] init];
  CNContactViewController *controller = [CNContactViewController viewControllerForNewContact:contact];
  controller.delegate = self;
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
  [self presentViewController:navController animated:YES completion:nil];
}


- (BOOL)contactViewController:(CNContactViewController *)viewController shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property {
  return YES;
}


-(void)contactViewController:(CNContactViewController*)arg1 didCompleteWithContact:(id)arg2{

  if (arg2 == NULL) {
    [arg1 dismissViewControllerAnimated:YES completion:nil];
  }

  [self refreshData];
  [self refreshController];
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.favouritesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  FavouriteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  cell.backgroundColor = UIColor.clearColor;
  cell.favouriteDelegate = self;

  NSData *avatarImageData = self.favouritesArray[indexPath.row][@"avatarImage"];
  cell.avatarImage.image = [UIImage imageWithData:avatarImageData];

  cell.nameLabel.text = self.favouritesArray[indexPath.row][@"fullName"];

  cell.iconImage.image = [UIImage systemImageNamed:self.favouritesArray[indexPath.row][@"categoriesIcon"]];
  cell.iconView.backgroundColor = [self colorWithHexString:(NSString*)[[self.favouritesArray objectAtIndex:indexPath.row] objectForKey:@"categoriesColour"]];

  BOOL isPhoneNumberAvailable = [self.favouritesArray[indexPath.row][@"isPhoneNumberAvailable"] boolValue];
  if (isPhoneNumberAvailable){
    [cell.favStackView addArrangedSubview:cell.favCallButton];
    [cell.favStackView addArrangedSubview:cell.favMessageButton];
  }

  BOOL isEmailAvailable = [self.favouritesArray[indexPath.row][@"isEmailAvailable"] boolValue];
  if (isEmailAvailable){
    [cell.favStackView addArrangedSubview:cell.favEmailButton];
  }

  return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(180, 150);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  invokeHaptic();
  NSString *contactIdentifier = self.favouritesArray[indexPath.row][@"contactIdentifier"];
  [self showContactDetailsWthID:contactIdentifier];
}


- (void)callButtonTappedForCell:(UICollectionViewCell *)cell {
  NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
  UIApplication *application = [UIApplication sharedApplication];
  NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.favouritesArray[indexPath.row][@"phoneNumber"]]];
  [application openURL:URL options:@{} completionHandler:nil];
}


- (void)messageButtonTappedForCell:(UICollectionViewCell *)cell {
  NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
  UIApplication *application = [UIApplication sharedApplication];
  NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", self.favouritesArray[indexPath.row][@"phoneNumber"]]];
  [application openURL:URL options:@{} completionHandler:nil];
}


- (void)emailButtonTappedForCell:(UICollectionViewCell *)cell {
  NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
  UIApplication *application = [UIApplication sharedApplication];
  NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.favouritesArray[indexPath.row][@"emailAddress"]]];
  [application openURL:URL options:@{} completionHandler:nil];
}


- (UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {

  UIContextMenuConfiguration* config = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu* _Nullable(NSArray<UIMenuElement*>* _Nonnull suggestedActions) {

    UIAction *deleteAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash.fill"] identifier:nil handler:^(UIAction *action) {

      NSString *getCategoriesName = self.favouritesArray[indexPath.row][@"categoriesName"];
      NSString *categoriesString = [getCategoriesName stringByReplacingOccurrencesOfString:@" " withString:@""];

      deleteDataForID(self.favouritesArray[indexPath.row][@"id"]);
      deleteCategoriesForID(self.favouritesArray[indexPath.row][@"id"], categoriesString);
      [self getFavouriteData];
      [self.collectionView reloadData];
      [self checkIfFavouriteIsEmpty];

    }];
    deleteAction.attributes = UIMenuElementAttributesDestructive;

    return [UIMenu menuWithTitle:@"Favourites" children:@[deleteAction]];

  }];

  return config;
}


-(UIMenu *)addContactManager {

  UIAction *addContactAction = [UIAction actionWithTitle:@"Create New Contact" image:[UIImage systemImageNamed:@"person.crop.circle.fill"] identifier:nil handler:^(UIAction *action) {
    [self addContactVC];
  }];

  UIAction *addFavouriteAction = [UIAction actionWithTitle:@"Create New Favourite" image:[UIImage systemImageNamed:@"rectangle.stack.fill.badge.person.crop"] identifier:nil handler:^(UIAction *action) {
    if (self.showFavourite) {
      [self addFavouriteVC];
    } else {
      [self showAlertWithTitle:@"Sorry!" subtitle:@"You have disabled favourites, please enable them if you want to add new favourites."];
    }
  }];

  return [UIMenu menuWithTitle:@"" children:@[addContactAction, addFavouriteAction]];
}


-(void)addFavouriteVC {
  invokeHaptic();
  CreateFavouriteViewController *vc = [[CreateFavouriteViewController alloc] init];
  vc.delegate = self;
  [self presentViewController:vc animated:YES completion:nil];
}


-(void)pushMyCardVC {

  if (!self.isMyCardAvailable) {
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];

    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = (NSArray *)CNContactGivenNameKey;

    [self presentViewController:contactPicker animated:YES completion:nil];

  } else {
    invokeHaptic();
    self.controller = [CNContactViewController viewControllerForContact:self.meContact];
    self.controller.delegate = self;
    self.controller.allowsEditing = YES;
    self.controller.allowsActions = YES;
    [self.navigationController pushViewController:self.controller animated:YES];
  }
}

-(void) contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
  writePhoneNumberToPlist(contact.identifier);
  self.isMyCardAvailable = YES;
  self.meContact = getMyContact();
  [self refreshData];
}

-(void)presentContactCardsVC {
}

+ (id)defaultPNGName{
  return @"Default";
}


- (void)contactsLongPressed:(UILongPressGestureRecognizer*)sender {

  ContactCell *cell = (ContactCell *)[sender view];

  if (sender.state == UIGestureRecognizerStateBegan) {

    CGPoint touchPoint = [sender locationInView:self.tableView];
    NSIndexPath *contactsIndex = [self.tableView indexPathForRowAtPoint:touchPoint];

    ContactsData *contactsData = self.parsedContacts[contactsIndex.section][contactsIndex.row];

    id keysToFetch = @[[CNContactViewController descriptorForRequiredKeys]];
    CNContact *contact = [self.store unifiedContactWithIdentifier:contactsData.identifier keysToFetch:keysToFetch error:nil];

    NSInteger contactSection = contactsIndex.section;
    NSInteger contactRow = contactsIndex.row;

    if (sender.state == UIGestureRecognizerStateBegan) {
      [UIView animateWithDuration:0.1 animations:^{
        cell.baseView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.97, 0.97);
      }];

      [self presentActionMenuWithData:contactsData cncontact:contact section:contactSection row:contactRow];

    }

  }

}


-(void)presentActionMenuWithData:(ContactsData *)data cncontact:(CNContact*)cncontact section:(NSInteger)section row:(NSInteger)row {

  haptic = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
  [haptic impactOccurred];

  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
  ContactCell *cell = (ContactCell *)[self.tableView cellForRowAtIndexPath:indexPath];

  [UIView animateWithDuration:0.2 animations:^{
    cell.baseView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
  }];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    ActionMenuViewController *vc = [[ActionMenuViewController alloc] initWithData:data cncontact:cncontact height:230];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
  });

}


-(void)needRefreshDataSourceAfterDeleteContact {
  [self refreshData];
}


-(void)didCreatedNewFavourite {
  [self getFavouriteData];
  [self.collectionView reloadData];
  [self checkIfFavouriteIsEmpty];
}


-(void)presentFavouriteFilterVC {
  invokeHaptic();
  FavouriteFilterViewController *vc = [[FavouriteFilterViewController alloc] initWithHeight:240];
  vc.delegate = self;
  [self presentViewController:vc animated:YES completion:nil];
}


-(void)filterFavouritesWithCategoriesName:(NSString *)categories {
  self.categoriesName = categories;
  self.favouriteSectionLabel.text = categories;
  [self getFavouriteData];
  [self.collectionView reloadData];
  [self checkIfFavouriteIsEmpty];
}


-(UIColor*)colorWithHexString:(NSString*)hex {

  NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

  if ([cString length] < 6) return [UIColor grayColor];

  if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];

  if ([cString length] != 6) return  [UIColor grayColor];

  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];

  range.location = 2;
  NSString *gString = [cString substringWithRange:range];

  range.location = 4;
  NSString *bString = [cString substringWithRange:range];

  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];

  return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

  }];

  [alert addAction:defaultAction];
  [self presentViewController:alert animated:YES completion:nil];
}

@end
