#import "ActionMenuViewController.h"

#define CELL_WIDTH 50
#define CELL_SPACING 10

@implementation ActionMenuViewController

-(instancetype)initWithData:(ContactsData *)data cncontact:(CNContact *)cncontact height:(CGFloat)height {

  self = [super init];
  if (self) {
    self.contactData = data;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.myAnimator = [[TDAnimator alloc] initWithCHeight:height andDimALpha:1.0];
    self.transitioningDelegate = self.myAnimator;

    self.contact = cncontact;
    self.store = [[CNContactStore alloc] init];
    self.actionArray = [[NSMutableArray alloc] init];

    if (self.contactData.phone != nil) {
      [self.actionArray addObject:@"Phone"];
      [self.actionArray addObject:@"Message"];
    }


    if (self.contactData.email != nil) {
      [self.actionArray addObject:@"Email"];
    }


    // [MBH's task]
    // Need to check if facetime is available for self.contactData.phone then [self.actionArray addObject:@"FaceTime"];


    [self.actionArray addObject:@"Delete"];

  }
  return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.systemBackgroundColor;
  self.view.layer.cornerRadius = 25;
  self.view.layer.cornerCurve = kCACornerCurveContinuous;
  self.view.layer.maskedCorners = 3;

  [self layoutHeaderView];
  [self layoutCollectionView];
}


-(void)layoutHeaderView {


  self.avatar = [[UIImageView alloc] init];
  self.avatar.layer.cornerRadius = 35;
  self.avatar.contentMode = UIViewContentModeScaleAspectFill;
  self.avatar.clipsToBounds = YES;
  if (self.contactData.avatar != nil) {
    self.avatar.image = self.contactData.avatar;
  } else {
    self.avatar.image = [UIImage systemImageNamed:@"person.crop.circle.fill"];
    self.avatar.tintColor = [[SettingManager sharedInstance] accentColour];
  }
  [self.view addSubview:self.avatar];

  [self.avatar size:CGSizeMake(70, 70)];
  [self.avatar x:self.view.centerXAnchor];
  [self.avatar top:self.view.topAnchor padding:20];


  self.nameLabel = [[UILabel alloc] init];
  self.nameLabel.textAlignment = NSTextAlignmentCenter;
  self.nameLabel.textColor = UIColor.labelColor;
  self.nameLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightSemibold];
  self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.contactData.firstName, self.contactData.lastName];
  [self.view addSubview:self.nameLabel];

  [self.nameLabel x:self.view.centerXAnchor];
  [self.nameLabel top:self.avatar.bottomAnchor padding:10];
  [self.nameLabel leading:self.view.leadingAnchor padding:15];
  [self.nameLabel trailing:self.view.trailingAnchor padding:-15];

}


-(void)layoutCollectionView {

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = UIColor.clearColor;
  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.collectionView setShowsHorizontalScrollIndicator:NO];
  [self.collectionView setShowsVerticalScrollIndicator:NO];
  [self.collectionView registerClass:[ActionMenuCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.view addSubview:self.collectionView];

  [self.collectionView height:70];
  [self.collectionView x:self.view.centerXAnchor];
  [self.collectionView leading:self.view.leadingAnchor padding:0];
  [self.collectionView trailing:self.view.trailingAnchor padding:0];
  [self.collectionView top:self.nameLabel.bottomAnchor padding:15];


  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.actionArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  ActionMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  cell.backgroundColor = UIColor.clearColor;

  if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"Phone"]) {

    cell.iconView.backgroundColor = [[[SettingManager sharedInstance] callButtonColour] colorWithAlphaComponent:0.3];
    cell.iconImage.image = [UIImage systemImageNamed:@"phone.fill"];
    cell.iconImage.tintColor = [[SettingManager sharedInstance] callButtonColour];
    cell.titleLabel.text = @"Call";

  } else if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"Message"]) {
    cell.iconView.backgroundColor = [[[SettingManager sharedInstance] messageButtonColour] colorWithAlphaComponent:0.3];
    cell.iconImage.image = [UIImage systemImageNamed:@"message.fill"];
    cell.iconImage.tintColor = [[SettingManager sharedInstance] messageButtonColour];
    cell.titleLabel.text = @"Message";

  } else if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"Email"]) {
    cell.iconView.backgroundColor = [[[SettingManager sharedInstance] emailButtonColour] colorWithAlphaComponent:0.3];
    cell.iconImage.image = [UIImage systemImageNamed:@"envelope.fill"];
    cell.iconImage.tintColor = [[SettingManager sharedInstance] emailButtonColour];
    cell.titleLabel.text = @"Email";

  } else if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"FaceTime"]) {
    cell.iconView.backgroundColor = [UIColor.systemBlueColor colorWithAlphaComponent:0.3];
    cell.iconImage.image = [UIImage systemImageNamed:@"video.fill"];
    cell.iconImage.tintColor = UIColor.systemBlueColor;
    cell.titleLabel.text = @"FaceTime";

  } else if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"Delete"]) {
    cell.iconView.backgroundColor = [[[SettingManager sharedInstance] deleteButtonColour] colorWithAlphaComponent:0.3];
    cell.iconImage.image = [UIImage systemImageNamed:@"trash.fill"];
    cell.iconImage.tintColor = [[SettingManager sharedInstance] deleteButtonColour];
    cell.titleLabel.text = @"Delete";
  }

  return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(50, 70);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  NSInteger viewWidth = self.view.frame.size.width;
  NSInteger totalCellWidth = CELL_WIDTH * self.actionArray.count;
  NSInteger totalSpacingWidth = CELL_SPACING * (self.actionArray.count -1);

  NSInteger leftInset = (viewWidth - (totalCellWidth + totalSpacingWidth)) / 2;
  NSInteger rightInset = leftInset;

  return UIEdgeInsetsMake(0, leftInset, 0, rightInset);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  UIApplication *application = [UIApplication sharedApplication];

  if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"Phone"]) {

    [self dismissVC];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.contactData.phone]];
    [application openURL:URL options:@{} completionHandler:nil];

  } else if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"Message"]) {

    [self dismissVC];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", self.contactData.phone]];
    [application openURL:URL options:@{} completionHandler:nil];

  } else if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"Email"]) {

    [self presentEmailAlert];

  } else if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"FaceTime"]) {

    [self dismissVC];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"facetime://%@", self.contactData.phone]];
    [application openURL:URL options:@{} completionHandler:nil];

  } else if ([[self.actionArray objectAtIndex:indexPath.row] isEqualToString:@"Delete"]) {

    [self presentDeleteAlert];
  }

}



-(void)presentDeleteAlert {

  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:[NSString stringWithFormat:@"Are you sure you want to delete %@ %@? You can't undo once deleted.", self.contactData.firstName, self.contactData.lastName] preferredStyle:UIAlertControllerStyleAlert];


  UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

    CNMutableContact *mutableContact = self.contact.mutableCopy;

    CNContactStore *store = [[CNContactStore alloc] init];
    CNSaveRequest *deleteRequest = [[CNSaveRequest alloc] init];
    [deleteRequest deleteContact:mutableContact];

    NSError *error;
    if([store executeSaveRequest:deleteRequest error:&error]) {
      NSLog(@"delete complete");
      [self.delegate needRefreshDataSourceAfterDeleteContact];
      [self dismissVC];
    }else {
      NSLog(@"delete error: %@", [error description]);
    }

  }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [self dismissVC];
  }];

  [alert addAction:deleteAction];
  [alert addAction:cancelAction];
  [self presentViewController:alert animated:YES completion:nil];

}


-(void)presentEmailAlert {

  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Email" message:[NSString stringWithFormat:@"Which email app would you like to send the email to %@ %@", self.contactData.firstName, self.contactData.lastName] preferredStyle:UIAlertControllerStyleAlert];

  UIApplication *application = [UIApplication sharedApplication];

  UIAlertAction *mailAction = [UIAlertAction actionWithTitle:@"Mail" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

    [self dismissVC];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.contactData.email]];
    [application openURL:URL options:@{} completionHandler:nil];

  }];

  UIAlertAction *gmailAction = [UIAlertAction actionWithTitle:@"Gmail" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

    [self dismissVC];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"googlegmail:///co?to=%@", self.contactData.email]];
    [application openURL:URL options:@{} completionHandler:nil];
  }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [self dismissVC];
  }];

  [alert addAction:mailAction];
  [alert addAction:gmailAction];
  [alert addAction:cancelAction];
  [self presentViewController:alert animated:YES completion:nil];

}


-(void)dismissVC {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
