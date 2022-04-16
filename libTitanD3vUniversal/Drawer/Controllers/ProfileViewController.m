#import "ProfileViewController.h"

@implementation ProfileViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.containerColour = [[TDAppearance sharedInstance] containerColour];
  self.tintColour = [[TDAppearance sharedInstance] tintColour];
  self.labelColour = [[TDAppearance sharedInstance] labelColour];
    self.view.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
  self.view.layer.maskedCorners = 12;
  self.view.layer.cornerRadius = 30;
  self.view.layer.cornerCurve = kCACornerCurveContinuous;
  self.view.clipsToBounds = true;
  [self layoutBanner];
  [self layoutTableView];
}


-(void)layoutBanner {

  self.bannerView = [[UIView alloc] init];
  self.bannerView.clipsToBounds = true;
  [self.view addSubview:self.bannerView];

  self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.bannerView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.bannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.bannerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.bannerView.heightAnchor constraintEqualToConstant:140].active = YES;


  self.iconImage = [[UIImageView alloc] init];
  self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/profile.png"];
    	self.iconImage.layer.cornerRadius = 15;
	self.iconImage.clipsToBounds = true;
  [self.bannerView addSubview:self.iconImage];

  self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.iconImage.heightAnchor constraintEqualToConstant:90].active = YES;
  [self.iconImage.widthAnchor constraintEqualToConstant:90].active = YES;
  [self.iconImage.topAnchor constraintEqualToAnchor:self.bannerView.topAnchor constant:10].active = YES;
  [[self.iconImage centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
  self.titleLabel.font = [UIFont systemFontOfSize:16];
  self.titleLabel.text = @"Profile";
  [self.bannerView addSubview:self.titleLabel];

  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
  [[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


  self.tipsButton = [[UIButton alloc] init];
  self.tipsButton.backgroundColor = self.tintColour;
  UIImage *tipsImage = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Tips/tips.png"];
  [self.tipsButton setImage:tipsImage forState:UIControlStateNormal];
  self.tipsButton.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
  [self.tipsButton addTarget:self action:@selector(showTipsTapped:) forControlEvents:UIControlEventTouchUpInside];
  self.tipsButton.layer.cornerRadius = 10;
  [self.bannerView addSubview:self.tipsButton];

  self.tipsButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.tipsButton.widthAnchor constraintEqualToConstant:20.0].active = YES;
  [self.tipsButton.heightAnchor constraintEqualToConstant:20.0].active = YES;
  [self.tipsButton.topAnchor constraintEqualToAnchor:self.bannerView.topAnchor constant:10].active = YES;
  [self.tipsButton.trailingAnchor constraintEqualToAnchor:self.bannerView.trailingAnchor constant:-10].active = YES;

}


-(void)layoutTableView {

  self.tableView = [[UITableView alloc] init];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.view addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;

  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.tableView.topAnchor constraintEqualToAnchor:self.bannerView.bottomAnchor constant:5].active = YES;
  [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

  if (cell == nil) {

    cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  }


  UIView *selectionView = [UIView new];
  selectionView.backgroundColor = UIColor.clearColor;
  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];


  cell.backgroundColor = UIColor.clearColor;
  cell.textField.delegate = self;
  cell.textField.tag = indexPath.row;

  if (indexPath.row == 0) {

    NSString *nameString = [[TDPrefsManager sharedInstance] objectForKey:@"profileName" defaultValue:@"UserName"];

    cell.titleLabel.text = @"Your name:";
    cell.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/profile.png"];
    cell.textField.placeholder = @"Your name";
    cell.textField.text = nameString;

  } else if (indexPath.row == 1) {

    NSString *dobString = [[TDPrefsManager sharedInstance] objectForKey:@"profileDOB" defaultValue:@"22/11"];

    cell.titleLabel.text = @"Birthday date & month:";
    cell.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/dob.png"];
    cell.textField.placeholder = @"dd/MM";
    cell.textField.text = dobString;
  }

  return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 70;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {

  if (textField.tag == 0) {
    NSString *nameString = textField.text;
    [[TDPrefsManager sharedInstance] setObject:nameString forKey:@"profileName"];

  } else if (textField.tag == 1) {
    NSString *dobString = textField.text;
    [[TDPrefsManager sharedInstance] setObject:dobString forKey:@"profileDOB"];
  }

}


-(void)showTipsTapped:(UIButton *)sender {

  invokeHapticFeedback();

  NSString *titleString = @"FAQ";
  NSString *messageString = @"Q: Why is it asking me for my name? \nA: It's asking you for your name because on the main page banner will display a greeting message with your name E.G Good Morning, TitanD3v. You won't need to enter your real name, you can use a nickname or any name you want it to display. \n\nQ: Why is it asking me for my birthday? \nA: It's asking you for your birthday so when your birthday come's it will display a Happy Birthday message on the banner and you can test it out by entering today's date. It will display other holidays messages E.G Merry Christmas, Happy New Year and Happy Halloween et cetera.";


  TDAlertViewControllerConfiguration *configuration = [TDAlertViewControllerConfiguration new];
  configuration.alertViewBackgroundColor = self.containerColour;
  configuration.titleTextColor = self.labelColour;
  configuration.messageTextColor = self.labelColour;
  configuration.transitionStyle = TDAlertViewControllerTransitionStyleSlideFromTop;
  configuration.backgroundTapDismissalGestureEnabled = YES;
  configuration.swipeDismissalGestureEnabled = YES;
  configuration.alwaysArrangesActionButtonsVertically = YES;
  configuration.buttonConfiguration.titleColor = self.tintColour;
  configuration.cancelButtonConfiguration.titleColor = self.tintColour;
  configuration.cancelButtonConfiguration.titleFont = [UIFont systemFontOfSize:16];
  configuration.alertViewCornerRadius = 20;
  configuration.showsSeparators = NO;


  TDAlertAction *okAction = [[TDAlertAction alloc] initWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];

  TDAlertViewController *alertViewController = [[TDAlertViewController alloc] initWithOptions:configuration title:titleString message:messageString actions:@[okAction]];

  [self presentViewController:alertViewController animated:YES completion:nil];

}

-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

@end
