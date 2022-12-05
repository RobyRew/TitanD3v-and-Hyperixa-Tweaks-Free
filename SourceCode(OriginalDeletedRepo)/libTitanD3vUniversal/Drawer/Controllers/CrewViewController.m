#import "CrewViewController.h"


@implementation CrewViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tintColour = [[TDAppearance sharedInstance] tintColour];
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
  self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/crew.png"];
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
  BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
  if (useAssets) {
    self.titleLabel.text = @"Crew";
  } else {
    self.titleLabel.text = [[TDPrefsManager sharedInstance] getCrewTitle];
  }
  [self.bannerView addSubview:self.titleLabel];

  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
  [[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;

}


-(void)layoutTableView {

  NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
  NSString *crewPlistPath = [[TDPrefsManager sharedInstance] getCrewPlistPath];
  BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
  if (useAssets) {
    crewString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Info/Crew/crew.plist"];
  } else {
    crewString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, crewPlistPath];
  }

  self.crewArray = [[NSArray alloc]initWithContentsOfFile:crewString];

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
  return self.crewArray.count;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  CrewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

  if (cell == nil) {

    cell = [[CrewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  }


  UIView *selectionView = [UIView new];
  selectionView.backgroundColor = UIColor.clearColor;
  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];


  NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
  NSString *crewImagePath = [[TDPrefsManager sharedInstance] getCrewImagePath];
  BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
  if (useAssets) {
    crewString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Info/Crew/Images/"];
  } else {
    crewString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, crewImagePath];
  }
  NSString *bannerString = (NSString*)[[self.crewArray objectAtIndex:indexPath.row] objectForKey:@"banner"];
  NSString *avatarString = (NSString*)[[self.crewArray objectAtIndex:indexPath.row] objectForKey:@"avatar"];

  NSString *bannerImageString = [NSString stringWithFormat:@"%@/%@", crewString, bannerString];
  NSString *avatarImageString = [NSString stringWithFormat:@"%@/%@", crewString, avatarString];


  cell.backgroundColor = UIColor.clearColor;
  cell.bannerImage.image = [UIImage imageWithContentsOfFile:bannerImageString];
  cell.iconImage.image = [UIImage imageWithContentsOfFile:avatarImageString];
  cell.nameLabel.text = (NSString*)[[self.crewArray objectAtIndex:indexPath.row] objectForKey:@"name"];
  cell.roleLabel.text = (NSString*)[[self.crewArray objectAtIndex:indexPath.row] objectForKey:@"role"];

  return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 300;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  invokeHapticFeedback();

  NSString *urlPath = (NSString*)[[self.crewArray objectAtIndex:indexPath.row] objectForKey:@"url"];

  UIApplication *application = [UIApplication sharedApplication];
  NSURL *URL = [NSURL URLWithString:urlPath];
  [application openURL:URL options:@{} completionHandler:nil];

  [[NSNotificationCenter defaultCenter] postNotificationName:@"DismissDrawer" object:self];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetDrawer" object:self];

  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

@end
