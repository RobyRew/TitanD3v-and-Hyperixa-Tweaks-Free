#import "TweakViewController.h"
#import "TweakCell.h"


@implementation TweakViewController

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
	self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/tweaks.png"];
	self.iconImage.userInteractionEnabled = YES;
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
	self.titleLabel.text = @"You might like other tweaks";
	[self.bannerView addSubview:self.titleLabel];

	self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
	[[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;

}


-(void)layoutTableView {

	NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
	NSString *tweakPlistPath = [[TDPrefsManager sharedInstance] getTweakPlistPath];
	BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
	if (useAssets) {
		tweakString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Info/Tweak/tweak.plist"];
	} else {
		tweakString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, tweakPlistPath];
	}
	self.tweakArray = [[NSArray alloc]initWithContentsOfFile:tweakString];


	self.tableView = [[UITableView alloc] init];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.editing = NO;
	self.tableView.backgroundColor = UIColor.clearColor;
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return self.tweakArray.count;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

	TweakCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

	if (cell == nil) {

		cell = [[TweakCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	}

	UIView *selectionView = [UIView new];
	selectionView.backgroundColor = UIColor.clearColor;
	[[UITableViewCell appearance] setSelectedBackgroundView:selectionView];


	NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
	NSString *tweakIconPath = [[TDPrefsManager sharedInstance] getTweakIconPath];
	BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
	if (useAssets) {
		tweakString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Info/Tweak/Icons/"];
	} else {
		tweakString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, tweakIconPath];
	}
	NSString *imageString = (NSString*)[[self.tweakArray objectAtIndex:indexPath.row] objectForKey:@"icon"];

	NSString *tweakImageString = [NSString stringWithFormat:@"%@/%@", tweakString, imageString];


	cell.backgroundColor = UIColor.clearColor;
	cell.iconImage.image = [UIImage imageWithContentsOfFile:tweakImageString];
    cell.nameLabel.text = (NSString*)[[self.tweakArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.priceLabel.text = (NSString*)[[self.tweakArray objectAtIndex:indexPath.row] objectForKey:@"price"];
    cell.versionLabel.text = (NSString*)[[self.tweakArray objectAtIndex:indexPath.row] objectForKey:@"compatibility"];
    cell.descriptionLabel.text = (NSString*)[[self.tweakArray objectAtIndex:indexPath.row] objectForKey:@"description"];

	return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	invokeHapticFeedback();

	NSString *urlPath = (NSString*)[[self.tweakArray objectAtIndex:indexPath.row] objectForKey:@"url"];

	UIApplication *application = [UIApplication sharedApplication];
	NSURL *URL = [NSURL URLWithString:urlPath];
	[application openURL:URL options:@{} completionHandler:nil];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"DismissDrawer" object:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ResetDrawer" object:self];

	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
        cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
        cell.alpha = 0.5;
    } completion:nil];
}


- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
        cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
        cell.alpha = 1;
    } completion:nil];
}

-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

@end
