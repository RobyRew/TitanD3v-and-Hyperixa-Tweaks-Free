#import "TDContactPickerViewController.h"

@implementation TDContactPickerViewController

-(instancetype)initWithTitle:(NSString *)title accentColour:(UIColor *)accent {
    
    self = [super init];
    if (self) {
        self.titleString = title;
        self.accentColour = accent;
        
        self.tdcontact = [[TDContact alloc] init];
    }
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self layoutHeaderView];
    [self getContacts];
    [self appendContacts];
    [self layoutTableView];
}


-(void)layoutHeaderView {
    
    
    self.headerView = [[TDHeaderView alloc] initWithTitle:self.titleString accent:self.accentColour leftIcon:@"xmark" leftAction:@selector(dismissVC) rightIcon:@"person.crop.circle.fill.badge.checkmark" rightAction:@selector(applyContact)];
    self.headerView.rightButton.tintColor = UIColor.whiteColor;
    self.headerView.rightButton.backgroundColor = self.accentColour;
    self.headerView.rightButton.alpha = 0;
    [self.view addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 75)];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];  
}


-(void)getContacts {
    
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus != CNAuthorizationStatusAuthorized) {
        NSLog(@"No authorization...");
        return;
    }
    
    self.contactPeople = [[NSMutableArray alloc] init];
    
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactImageDataKey, CNContactIdentifierKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        
        TDPeople *tdpeople = [[TDPeople alloc] init];
        tdpeople.firstName = givenName;
        tdpeople.lastName = familyName;
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phoneNumbers) {
            CNPhoneNumber *phoneNumber = labelValue.value;
            NSString * onePhone = phoneNumber.stringValue;
            
            tdpeople.phone = [onePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
        
        NSArray *emailArray = contact.emailAddresses;
        for (CNLabeledValue *labelValue2 in emailArray) {
            NSString *email = labelValue2.value;
            tdpeople.email = email;
        }
        
        
        if (contact.imageData != nil ) {
            UIImage *contactImage = [UIImage imageWithData:(NSData *)contact.imageData];
            tdpeople.avatar = contactImage;
        }
        
        
        NSString *ids = contact.identifier;
        tdpeople.identifier = ids;
        
        
        [self.contactPeople addObject:tdpeople];
    }];
}


-(void)appendContacts {
    
    NSMutableArray * columns = [[NSMutableArray alloc] initWithCapacity:26];
    for(int i = 0; i < 26; i ++){
        NSMutableArray * group = [[NSMutableArray alloc] init];
        for(int j = 0; j < self.contactPeople.count ; j++){
            TDPeople *tdpeople = self.contactPeople [j];
            NSString * letter;
            if(tdpeople.firstName.length != 0) {
                letter = [tdpeople.firstName substringToIndex:1];
            }
            else if(tdpeople.lastName.length != 0) {
                letter = [tdpeople.lastName substringToIndex:1];
            }
            if( letter == [NSString stringWithFormat: @"%c", i+'A'] ){
                [group addObject:tdpeople];
            }
        }
        if (group.count) {
            [columns addObject:group];
        }
    }
    self.parsedContacts = columns;
    
    NSMutableArray* letters = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.parsedContacts.count; i ++){
        NSString * item = [NSString stringWithFormat:@"%c", i+'A'];
        [letters addObject:item];
    }
    
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
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TDPeople *tdpeople = self.parsedContacts [section] [0];
    NSString * title;
    if(tdpeople.firstName.length != 0) {
        title = [tdpeople.firstName substringToIndex:1];
    } else {
        title = [tdpeople.lastName substringToIndex:1];
    }
    return title;
}


-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray <NSString*> * indices = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.parsedContacts.count; ++i) {
        TDPeople *tdpeople = self.parsedContacts[i][0];
        NSString *title;
        if (tdpeople.firstName.length != 0) {
            title = [tdpeople.firstName substringToIndex:1];
        } else {
            title = [tdpeople.lastName substringToIndex:1];
        }
        [indices addObject:title];
    }
    return indices;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.parsedContacts[section] count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.parsedContacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TDContactPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[TDContactPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = UIColor.clearColor;
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.backgroundColor = UIColor.clearColor;
    
    TDPeople *tdpeople = self.parsedContacts [indexPath.section] [indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", tdpeople.firstName, tdpeople.lastName];
    
    cell.emailLabel.text = tdpeople.email;
    
    
    if (tdpeople.phone != nil) {
        cell.numberLabel.text = tdpeople.phone;
    } else {
        cell.numberLabel.text = @"No phone number available";
    }
    
    
    if (tdpeople.email != nil) {
        cell.emailLabel.text = tdpeople.email;
    } else {
        cell.emailLabel.text = @"No email address available";
    }
    
    
    if (tdpeople.avatar !=nil) {
        cell.avatar.image = tdpeople.avatar;
    } else {
        cell.avatar.image = [UIImage systemImageNamed:@"person.crop.circle.fill"];
        cell.avatar.tintColor = self.accentColour;
    }
    
    
    if (self.didSelectedContact) {
        if ((indexPath.section == self.selectedSection) && (indexPath.row == self.selectedIndex)) {
            cell.baseView.backgroundColor = self.accentColour;
            cell.nameLabel.textColor = UIColor.whiteColor;
            cell.numberLabel.textColor = UIColor.whiteColor;
            cell.emailLabel.textColor = UIColor.whiteColor;
            UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"checkmark"]];
            checkmark.tintColor = UIColor.whiteColor;
            cell.accessoryView = checkmark;
            cell.avatar.tintColor = UIColor.whiteColor;
        } else {
            cell.baseView.backgroundColor = UIColor.secondarySystemBackgroundColor;
            cell.nameLabel.textColor = UIColor.labelColor;
            cell.numberLabel.textColor = UIColor.tertiaryLabelColor;
            cell.emailLabel.textColor = UIColor.tertiaryLabelColor;
            cell.accessoryView = nil;
            cell.avatar.tintColor = self.accentColour;
        }
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TDPeople *tdpeople = self.parsedContacts [indexPath.section] [indexPath.row];
    
    self.tdcontact.fullName = [NSString stringWithFormat:@"%@ %@", tdpeople.firstName, tdpeople.lastName];
    self.tdcontact.phoneNumber = tdpeople.phone;
    self.tdcontact.emailAddress = tdpeople.email;
    self.tdcontact.identifier = tdpeople.identifier;
    self.tdcontact.avatarImage = tdpeople.avatar;
    
    NSRange rangeValue = [self.tdcontact.phoneNumber rangeOfString:@"+" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0) {
        self.tdcontact.isPhoneNumberContainPrefix = YES;
    } else {
        self.tdcontact.isPhoneNumberContainPrefix = NO;
    }
    
    
    if (self.tdcontact.emailAddress != nil) {
        self.tdcontact.isEmailAvailable = YES;
    } else {
        self.tdcontact.isEmailAvailable = NO;
    }
    
    if (self.tdcontact.avatarImage != nil) {
        self.tdcontact.isAvatarAvailable = YES;
    } else {
        self.tdcontact.isAvatarAvailable = NO;
    }
    
    self.headerView.rightButton.alpha = 1;
    self.modalInPresentation = YES;
    self.didSelectedContact = YES;
    self.selectedSection = indexPath.section;
    self.selectedIndex = indexPath.row;
    [self.tableView reloadData];
}


-(void)dismissVC {
    [self.delegate didCancelPickAContact];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)applyContact {
    [self.delegate didPickAContact:self.tdcontact];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(UIColor *)randomColor {
    static NSArray *__colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __colors = @[UIColor.systemRedColor,
                     UIColor.systemIndigoColor,
                     UIColor.systemTealColor,
                     UIColor.systemPinkColor,
                     UIColor.systemYellowColor,
                     UIColor.systemOrangeColor,
                     UIColor.systemGreenColor
        ];
    });
    int index = arc4random_uniform((uint32_t)__colors.count);
    return __colors[index];
}

@end
