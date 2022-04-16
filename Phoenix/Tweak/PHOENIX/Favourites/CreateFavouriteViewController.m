#import "CreateFavouriteViewController.h"

static void deleteDataForID(NSString *idToRemove){

  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/Categories.plist", aDocumentsDirectory];
  //NSString *plistPath = @"/var/mobile/Library/Preferences/PaletteCollections.plist";
  //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
  [mutableDict removeObjectForKey:idToRemove];
  [mutableDict writeToFile:plistPath atomically:YES];

}


@implementation CreateFavouriteViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.systemBackgroundColor;

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

  self.tdcontact = [[TDContact alloc] init];

  [self layoutHeaderView];
  [self layoutHeaderSubViews];
  [self setupCategoriesData];
  [self layoutCollectionView];
}


-(void)layoutHeaderView {

  self.headerView = [[TDHeaderView alloc] initWithTitle:@"New Favourite" accent:self.accentColour leftIcon:@"xmark" leftAction:@selector(dismissVC) rightIcon:@"person.crop.circle.fill.badge.checkmark" rightAction:@selector(applyChanges)];
  self.headerView.leftButton.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.headerView.rightButton.tintColor = UIColor.whiteColor;
  self.headerView.rightButton.backgroundColor = self.accentColour;
  self.headerView.rightButton.alpha = 0;
  [self.view addSubview:self.headerView];

  [self.headerView size:CGSizeMake(self.view.frame.size.width, 75)];
  [self.headerView x:self.view.centerXAnchor];
  [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];
}


-(void)layoutHeaderSubViews {

  self.avatarImage = [[UIImageView alloc] init];
  self.avatarImage.layer.cornerRadius = 55;
  self.avatarImage.clipsToBounds = YES;
  self.avatarImage.image = [UIImage systemImageNamed:@"person.crop.circle.fill"];
  self.avatarImage.contentMode = UIViewContentModeScaleAspectFit;
  self.avatarImage.tintColor = UIColor.tertiaryLabelColor;
  self.avatarImage.userInteractionEnabled = YES;
  [self.view addSubview:self.avatarImage];

  [self.avatarImage size:CGSizeMake(110, 110)];
  [self.avatarImage x:self.view.centerXAnchor];
  [self.avatarImage top:self.headerView.bottomAnchor padding:20];

  [self.avatarImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentContactPickerVC)]];


  self.addButton = [[UIButton alloc] init];
  self.addButton.backgroundColor = self.accentColour;
  self.addButton.tintColor = UIColor.whiteColor;
  self.addButton.layer.cornerRadius = 15;
  [self.addButton addTarget:self action:@selector(presentContactPickerVC) forControlEvents:UIControlEventTouchUpInside];
  UIImage *addImage = [UIImage systemImageNamed:@"plus"];
  [self.addButton setImage:addImage forState:UIControlStateNormal];
  [self.view addSubview:self.addButton];

  [self.addButton size:CGSizeMake(30, 30)];
  [self.addButton trailing:self.avatarImage.trailingAnchor padding:-3];
  [self.addButton bottom:self.avatarImage.bottomAnchor padding:-3];


  self.nameLabel = [[UILabel alloc] init];
  self.nameLabel.textAlignment = NSTextAlignmentCenter;
  self.nameLabel.textColor = UIColor.labelColor;
  self.nameLabel.font = [UIFont systemFontOfSize:26 weight:UIFontWeightSemibold];
  self.nameLabel.text = @"Choose Contact";
  [self.view addSubview:self.nameLabel];

  [self.nameLabel x:self.view.centerXAnchor];
  [self.nameLabel top:self.avatarImage.bottomAnchor padding:15];
  [self.nameLabel leading:self.view.leadingAnchor padding:20];
  [self.nameLabel trailing:self.view.trailingAnchor padding:-20];


  self.avatarButton = [[UIButton alloc] init];
  [self.avatarButton addTarget:self action:@selector(presentAvatarPickerVC) forControlEvents:UIControlEventTouchUpInside];
  [self.avatarButton setTitle:@"Choose Avatar" forState:UIControlStateNormal];
  [self.avatarButton setTitleColor:self.accentColour forState:UIControlStateNormal];
  self.avatarButton.alpha = 0;
  [self.view addSubview:self.avatarButton];

  [self.avatarButton size:CGSizeMake(200, 30)];
  [self.avatarButton x:self.view.centerXAnchor];
  [self.avatarButton top:self.nameLabel.bottomAnchor padding:3];


  self.categoriesLabel = [[UILabel alloc] init];
  self.categoriesLabel.textAlignment = NSTextAlignmentLeft;
  self.categoriesLabel.textColor = UIColor.tertiaryLabelColor;
  self.categoriesLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
  self.categoriesLabel.text = @"Categories";
  [self.view addSubview:self.categoriesLabel];

  [self.categoriesLabel top:self.avatarButton.bottomAnchor padding:20];
  [self.categoriesLabel leading:self.view.leadingAnchor padding:20];
  [self.categoriesLabel trailing:self.view.trailingAnchor padding:-20];

}


-(void)setupCategoriesData {
  // [IMPORTANT]
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/Categories.plist", aDocumentsDirectory];
  //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];

  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

  self.categoriesArray = [NSMutableArray new];
  for(NSString *key in mutableDict){
    [self.categoriesArray addObject:mutableDict[key]];

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"categoriesName" ascending:YES];
    [self.categoriesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
  }

}


-(void)layoutCollectionView {

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = UIColor.secondarySystemBackgroundColor;
  self.collectionView.layer.cornerRadius = 15;
  self.collectionView.layer.cornerCurve = kCACornerCurveContinuous;
  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.collectionView setShowsHorizontalScrollIndicator:NO];
  [self.collectionView setShowsVerticalScrollIndicator:NO];
  [self.collectionView registerClass:[FavouriteCategoriesCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.view addSubview:self.collectionView];

  [self.collectionView leading:self.view.leadingAnchor padding:20];
  [self.collectionView trailing:self.view.trailingAnchor padding:-20];
  [self.collectionView top:self.categoriesLabel.bottomAnchor padding:10];
  [self.collectionView bottom:self.view.safeAreaLayoutGuide.bottomAnchor padding:-15];

  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;

}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.categoriesArray.count+1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  FavouriteCategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  if (indexPath.row == 0) {

    cell.backgroundColor = UIColor.clearColor;
    cell.baseView.backgroundColor = [self.accentColour colorWithAlphaComponent:0.4];
    cell.iconImage.image = [UIImage systemImageNamed:@"folder.fill.badge.plus"];
    cell.iconImage.tintColor = self.accentColour;
    cell.titleLabel.text = @"Create New";

  } else {

    cell.baseView.backgroundColor = [[self colorWithHexString:(NSString*)[[self.categoriesArray objectAtIndex:indexPath.row-1 ] objectForKey:@"categoriesColour"]] colorWithAlphaComponent:0.4];
    cell.titleLabel.text = self.categoriesArray[indexPath.row-1][@"categoriesName"];
    cell.iconImage.image = [UIImage systemImageNamed:self.categoriesArray[indexPath.row-1][@"categoriesIcon"]];
    cell.iconImage.tintColor = [self colorWithHexString:(NSString*)[[self.categoriesArray objectAtIndex:indexPath.row-1 ] objectForKey:@"categoriesColour"]];

    if (indexPath.row == self.categoriesIndex) {
      cell.iconImage.image = self.didChooseCategories ? [UIImage systemImageNamed:@"checkmark"] : [UIImage systemImageNamed:self.categoriesArray[indexPath.row-1][@"categoriesIcon"]];
      cell.iconImage.tintColor = UIColor.whiteColor;
    }
  }

  return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat width = (self.view.frame.size.width-110)/3;
  return CGSizeMake(width, width-30);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 10.0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(20,20,20,20);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  if (indexPath.row == 0) {

    CreateCategoriesViewController *vc = [[CreateCategoriesViewController alloc] init];
    vc.delegate = self;
    vc.modalInPresentation = YES;
    [self presentViewController:vc animated:YES completion:nil];
  } else {

    self.modalInPresentation = YES;
    self.didChooseCategories = YES;

    self.categoriesIndex = indexPath.row;
    self.categoriesName = self.categoriesArray[indexPath.row-1][@"categoriesName"];
    self.categoriesColour = self.categoriesArray[indexPath.row-1][@"categoriesColour"];
    self.categoriesIcon = self.categoriesArray[indexPath.row-1][@"categoriesIcon"];

    [self.collectionView reloadData];
    self.avatarButton.alpha = 1;
    [self didCompletedRequirements];
  }

}


- (UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {

  if (indexPath.row != 0) {

    UIContextMenuConfiguration* config = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu* _Nullable(NSArray<UIMenuElement*>* _Nonnull suggestedActions) {
      // [IMPORTANT] need to post notification to delete categories from plist and delete categories plist name
      UIAction *deleteAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash.fill"] identifier:nil handler:^(UIAction *action) {
        deleteDataForID(self.categoriesArray[indexPath.row-1][@"id"]);
        [self setupCategoriesData];
        [self.collectionView reloadData];
      }];
      deleteAction.attributes = UIMenuElementAttributesDestructive;

      NSString *titleString = self.categoriesArray[indexPath.row-1][@"categoriesName"];
      return [UIMenu menuWithTitle:titleString children:@[deleteAction]];

    }];

    return config;

  } else {
    return nil;
  }

}


-(void)presentContactPickerVC {

  TDContactPickerViewController *vc = [[TDContactPickerViewController alloc] initWithTitle:@"Pick a Contact" accentColour:self.accentColour];
  vc.delegate = self;
  [self presentViewController:vc animated:YES completion:nil];

}


-(void)didPickAContact:(TDContact *)contact {
  NSLog(@"Full name: %@", contact.fullName);
  NSLog(@"Phone number: %@", contact.phoneNumber);
  NSLog(@"Is phone number contain prefix: %d", contact.isPhoneNumberContainPrefix);
  NSLog(@"Email address: %@", contact.emailAddress);
  NSLog(@"Is email address available: %d", contact.isEmailAvailable);
  NSLog(@"ID: %@", contact.identifier);
  NSLog(@"Avatar: %@", contact.avatarImage);
  NSLog(@"Is avatar available: %d", contact.isAvatarAvailable);

  self.tdcontact = contact;

  self.didChooseContact = YES;
  self.modalInPresentation = YES;
  self.avatarButton.alpha = 1;
  [self didCompletedRequirements];

  UIImage *editImage = [UIImage systemImageNamed:@"pencil"];
  [self.addButton setImage:editImage forState:UIControlStateNormal];

  self.nameLabel.text = contact.fullName;

  if (contact.avatarImage != nil) {
    self.avatarImage.image = contact.avatarImage;
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.avatarButton setTitle:@"Change Avatar" forState:UIControlStateNormal];
    self.didChooseAvatar = YES;
  } else {
    self.avatarImage.image = [UIImage systemImageNamed:@"person.crop.circle.fill"];
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.avatarButton setTitle:@"Choose Avatar" forState:UIControlStateNormal];
    self.didChooseAvatar = NO;
  }

}


-(void)didCancelPickAContact {
  NSLog(@"Cancelled pick a contact");
}


-(void)presentAvatarPickerVC {
  TDAvatarIdentityPickerViewController *vc = [[TDAvatarIdentityPickerViewController alloc] initWithTitle:@"Avatar" showDefaultAvatar:YES avatarImage:nil accent:self.accentColour];
  vc.delegate = self;
  [self presentViewController:vc animated:YES completion:nil];
}


-(void)didCreatedAvatar:(UIImage *)avatar {
  self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
  self.avatarImage.image = avatar;
  self.didChooseAvatar = YES;
}


-(void)didDismissedAvatarPicker {
  NSLog(@"Avatar picker dismissed");
}


-(void)didCompletedRequirements {
  if (self.didChooseContact && self.didChooseCategories) {
    self.headerView.rightButton.alpha = 1;
  }
}


-(void)applyChanges {

  if (!self.didChooseAvatar) {
    [self showAlertWithTitle:@"Warning!" subtitle:@"Your contact doesn't have an avatar image, please choose an avatar image."];
  } else {

    if (self.tdcontact.phoneNumber != nil) {
      self.phoneNumber = self.tdcontact.phoneNumber;
      self.isPhoneNumberAvailable = YES;
    } else {
      self.phoneNumber = @"";
      self.isPhoneNumberAvailable = NO;
    }


    if (self.tdcontact.emailAddress != nil) {
      self.emailAddress = self.tdcontact.emailAddress;
    } else {
      self.emailAddress = @"";
    }


    // [IMPORTANT] need to post notification to write new categories to plist
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *plistPath = [NSString stringWithFormat:@"%@/AllFavourites.plist", aDocumentsDirectory];

    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    self.mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

    UIImage *image = self.avatarImage.image;
    NSData *avatarData = UIImagePNGRepresentation(image);

    NSString *withID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000.0)];
    NSDictionary *data = @{@"id" : withID, @"categoriesName" : self.categoriesName, @"categoriesColour" : self.categoriesColour, @"categoriesIcon" : self.categoriesIcon, @"fullName" : self.tdcontact.fullName, @"phoneNumber" : self.phoneNumber, @"isPhoneNumberAvailable" : [NSNumber numberWithBool:self.isPhoneNumberAvailable], @"emailAddress" : self.emailAddress, @"isEmailAvailable" : [NSNumber numberWithBool:self.tdcontact.isEmailAvailable], @"contactIdentifier" : self.tdcontact.identifier, @"avatarImage" : avatarData};


    [self.mutableDict setValue:data forKey:withID];
    [self.mutableDict writeToFile:plistPath atomically:YES];


    // Write to other plist with categories name
    NSString *aDocumentsDirectory2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *plistName = [self.categoriesName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *plistPath2 = [NSString stringWithFormat:@"%@/%@.plist", aDocumentsDirectory2, plistName];

    NSDictionary *dict2 = [NSDictionary dictionaryWithContentsOfFile:plistPath2];
    self.categoriesDict = dict2 ? [dict2 mutableCopy] : [NSMutableDictionary dictionary];

    //NSDictionary *data2 = @{@"id" : withID, @"categoriesName" : self.categoriesName, @"categoriesColour" : self.categoriesColour, @"categoriesIcon" : self.categoriesIcon, @"fullName" : self.tdcontact.fullName, @"phoneNumber" : self.tdcontact.phoneNumber, @"emailAddress" : self.tdcontact.emailAddress, @"isEmailAvailable" : [NSNumber numberWithBool:self.tdcontact.isEmailAvailable], @"contactIdentifier" : self.tdcontact.identifier, @"avatarImage" : avatarData};

    [self.categoriesDict setValue:data forKey:withID];
    [self.categoriesDict writeToFile:plistPath2 atomically:YES];


    [self.delegate didCreatedNewFavourite];
    [self dismissVC];
  }
}


-(void)didCreatedNewCategory {
  [self setupCategoriesData];
  [self.collectionView reloadData];
}


-(void)dismissVC {
  [self dismissViewControllerAnimated:YES completion:nil];
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

  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
  }];
  [alert addAction:ok];
  [self presentViewController:alert animated:YES completion:nil];

}

@end
