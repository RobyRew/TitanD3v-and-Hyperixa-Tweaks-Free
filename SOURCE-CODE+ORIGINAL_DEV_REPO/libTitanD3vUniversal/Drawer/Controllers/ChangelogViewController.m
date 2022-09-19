#import "ChangelogViewController.h"

@implementation ChangelogViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.tintColour = [[TDAppearance sharedInstance] tintColour];
	  self.view.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
  self.view.layer.maskedCorners = 12;
  self.view.layer.cornerRadius = 30;
  self.view.layer.cornerCurve = kCACornerCurveContinuous;
  self.view.clipsToBounds = true;
	[self layoutTableView];

}

-(void)layoutTableView {

	NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
	NSString *changelogPlistPath = [[TDPrefsManager sharedInstance] getChangelogPlistPath];
	NSString *changelogString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, changelogPlistPath];

	self.changelogArray = [[NSArray alloc]initWithContentsOfFile:changelogString];
	

	NSString *versionString = [[TDPrefsManager sharedInstance] getCurrentVersion];

	self.bannerView = [[UIView alloc] init];
	self.bannerView.clipsToBounds = true;
	[self.view addSubview:self.bannerView];

	self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.bannerView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
	[self.bannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	[self.bannerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
	[self.bannerView.heightAnchor constraintEqualToConstant:140].active = YES;


	self.iconImage = [[UIImageView alloc] init];
	self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/changelog.png"];
	self.iconImage.userInteractionEnabled = YES;
	self.iconImage.layer.cornerRadius = 15;
	self.iconImage.clipsToBounds = true;
	[self.bannerView addSubview:self.iconImage];

	self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
	[self.iconImage.heightAnchor constraintEqualToConstant:90].active = YES;
	[self.iconImage.widthAnchor constraintEqualToConstant:90].active = YES;
	[self.iconImage.topAnchor constraintEqualToAnchor:self.bannerView.topAnchor constant:10].active = YES;
	[[self.iconImage centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


	self.versionLabel = [[UILabel alloc] init];
	self.versionLabel.textAlignment = NSTextAlignmentCenter;
	self.versionLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
	self.versionLabel.font = [UIFont systemFontOfSize:16];
	self.versionLabel.text = versionString;
	[self.bannerView addSubview:self.versionLabel];

	self.versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.versionLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
	[[self.versionLabel centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.editing = NO;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];

	self.tableView.dataSource = self;
    self.tableView.delegate = self;

	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.tableView.topAnchor constraintEqualToAnchor:self.bannerView.bottomAnchor constant:5].active = YES;
	[self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	[self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
	[self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.changelogArray.count;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.changelogArray objectAtIndex: section] objectForKey: @"ChangelogDescription"] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
    sectionHeaderView.backgroundColor = UIColor.clearColor;
    sectionHeaderView.clipsToBounds = true;
    
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, sectionHeaderView.frame.size.height /2 -7.5, 200, 15)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.font = [UIFont boldSystemFontOfSize:16];
    headerLabel.text = [[self.changelogArray objectAtIndex: section] objectForKey: @"Date"];
    [sectionHeaderView addSubview:headerLabel];
    
    return sectionHeaderView;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ChangelogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        
        cell = [[ChangelogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    
    cell.backgroundColor = UIColor.clearColor;
    
    cell.versionLabel.text = [[self.changelogArray objectAtIndex: indexPath.section] objectForKey: @"Version"];
    cell.messageLabel.text = [[[[self.changelogArray objectAtIndex: indexPath.section] objectForKey: @"ChangelogDescription"] objectAtIndex: indexPath.row] stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
    NSInteger categories = [[[[self.changelogArray objectAtIndex: indexPath.section] objectForKey: @"updateCategories"] objectAtIndex: indexPath.row] intValue];

    if (categories == 0) {
        cell.categoriesLabel.text = @"Initial Release";
        cell.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Changelog/initial-release.png"];
    } else if (categories == 1) {
        cell.categoriesLabel.text = @"Bug Fixes";
        cell.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Changelog/bug-fix.png"];
    } else if (categories == 2) {
        cell.categoriesLabel.text = @"Improvements";
        cell.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Changelog/improvements.png"];
    } else if (categories == 3) {
        cell.categoriesLabel.text = @"New Features";
        cell.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Changelog/new-features.png"];
    }
 
    return cell;
    
}

-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

@end
