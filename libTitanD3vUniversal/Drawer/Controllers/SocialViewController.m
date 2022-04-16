#import "SocialViewController.h"
#import "DrawerCell.h"

@implementation SocialViewController

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

	NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
	NSString *avatarPath = [[TDPrefsManager sharedInstance] getTwitterAvatarPath];
	BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
	if (useAssets) {
		avatarImageString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Info/Social/Icons/avatar.png"];
		twitterName = @"TitanD3v";
	} else {
		avatarImageString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, avatarPath];
		twitterName = [[TDPrefsManager sharedInstance] getTwitterName];
	}

	self.bannerView = [[UIView alloc] init];
	self.bannerView.clipsToBounds = true;
	[self.view addSubview:self.bannerView];

	self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.bannerView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
	[self.bannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	[self.bannerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
	[self.bannerView.heightAnchor constraintEqualToConstant:140].active = YES;


	self.iconImage = [[UIImageView alloc] init];
	self.iconImage.image = [UIImage imageWithContentsOfFile:avatarImageString];
	self.iconImage.layer.cornerRadius = 45;
	self.iconImage.clipsToBounds = true;
	self.iconImage.userInteractionEnabled = YES;
	[self.bannerView addSubview:self.iconImage];

	self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
	[self.iconImage.heightAnchor constraintEqualToConstant:90].active = YES;
	[self.iconImage.widthAnchor constraintEqualToConstant:90].active = YES;
	[self.iconImage.topAnchor constraintEqualToAnchor:self.bannerView.topAnchor constant:10].active = YES;
	[[self.iconImage centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


	self.twitterView = [[UIView alloc] init];
	self.twitterView.backgroundColor = [UIColor colorWithRed: 0.20 green: 0.20 blue: 0.20 alpha: 0.5];;
	self.twitterView.layer.cornerRadius = 15;
	self.twitterView.layer.borderWidth = 1;
	UIColor *twitterBorder = [self.tintColour colorWithAlphaComponent:0.3];
	self.twitterView.layer.borderColor = twitterBorder.CGColor;
	self.twitterView.clipsToBounds = true;
	[self.bannerView addSubview:self.twitterView];

	self.twitterView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.twitterView.heightAnchor constraintEqualToConstant:30].active = YES;
	[self.twitterView.widthAnchor constraintEqualToConstant:30].active = YES;
	[self.twitterView.trailingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:0].active = YES;
	[self.twitterView.bottomAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:0].active = YES;


	self.twitterImage = [[UIImageView alloc] init];
	self.twitterImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/twitter.png"];
	[self.twitterView addSubview:self.twitterImage];

	self.twitterImage.translatesAutoresizingMaskIntoConstraints = NO;
	[self.twitterImage.heightAnchor constraintEqualToConstant:20].active = YES;
	[self.twitterImage.widthAnchor constraintEqualToConstant:20].active = YES;
	[[self.twitterImage centerXAnchor] constraintEqualToAnchor:self.twitterView.centerXAnchor].active = true;
	[[self.twitterImage centerYAnchor] constraintEqualToAnchor:self.twitterView.centerYAnchor].active = true;


	self.twitterLabel = [[UILabel alloc] init];
	self.twitterLabel.textAlignment = NSTextAlignmentCenter;
	self.twitterLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
	self.twitterLabel.font = [UIFont systemFontOfSize:16];
	self.twitterLabel.text = twitterName;
	[self.bannerView addSubview:self.twitterLabel];

	self.twitterLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.twitterLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
	[[self.twitterLabel centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


	[self.iconImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(launchTwitter)]];
}


-(void)layoutTableView {


	NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
	NSString *socialPlistPath = [[TDPrefsManager sharedInstance] getSocialPlistPath];
	BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
	if (useAssets) {
		socialString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Info/Social/social.plist"];
	} else {
		socialString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, socialPlistPath];
	}
	self.socialArray = [[NSArray alloc]initWithContentsOfFile:socialString];


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
	return self.socialArray.count;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

	DrawerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

	if (cell == nil) {

		cell = [[DrawerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SocialCell"];
	}


	UIView *selectionView = [UIView new];
	selectionView.backgroundColor = UIColor.clearColor;
	[[UITableViewCell appearance] setSelectedBackgroundView:selectionView];

	cell.backgroundColor = UIColor.clearColor;
	cell.titleLabel.text = (NSString*)[[self.socialArray objectAtIndex:indexPath.row] objectForKey:@"title"];
	cell.subtitleLabel.text = (NSString*)[[self.socialArray objectAtIndex:indexPath.row] objectForKey:@"subtitle"];


	NSString *prefsBundle = [[TDPrefsManager sharedInstance] getPrefsBundle];
	NSString *socialIconPath = [[TDPrefsManager sharedInstance] getSocialIconPath];
	BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
	if (useAssets) {
		socialString = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Info/Social/Icons/"];
	} else {
		socialString = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@/%@", prefsBundle, socialIconPath];
	}
	NSString *imageString = (NSString*)[[self.socialArray objectAtIndex:indexPath.row] objectForKey:@"icon"];

	NSString *socialImageString = [NSString stringWithFormat:@"%@/%@", socialString, imageString];

	cell.iconImage.image = [UIImage imageWithContentsOfFile:socialImageString];

	UIImageView *linkImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	linkImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/link.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIColor *linkTint = [self.tintColour colorWithAlphaComponent:0.3];
	linkImage.tintColor = linkTint;
	cell.accessoryView = linkImage;

	return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	invokeHapticFeedback();

	NSString *urlPath = (NSString*)[[self.socialArray objectAtIndex:indexPath.row] objectForKey:@"url"];

	UIApplication *application = [UIApplication sharedApplication];
	NSURL *URL = [NSURL URLWithString:urlPath];
	[application openURL:URL options:@{} completionHandler:nil];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"DismissDrawer" object:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ResetDrawer" object:self];

	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}


-(void)launchTwitter {

	invokeHapticFeedback();

	BOOL useAssets = [[TDPrefsManager sharedInstance] populateAssetsFromLibrary];
	if (useAssets) {
		twitterURL = @"https://twitter.com/D3vTitan";
	} else {
		twitterURL = [[TDPrefsManager sharedInstance] getTwitterURL];
	}

	UIApplication *application = [UIApplication sharedApplication];
	NSURL *URL = [NSURL URLWithString:twitterURL];
	[application openURL:URL options:@{} completionHandler:nil];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"DismissDrawer" object:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ResetDrawer" object:self];
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
