#import "SettingViewController.h"
#import <spawn.h>

@interface NSBundle(priv)
- (instancetype)initWithURL:(NSURL *)url;
@end

@implementation SettingViewController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NovaPrefs.bundle/Assets/ExtSettings/"];
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self bundle:bundle];
	}

	return _specifiers;
}


- (void)viewDidLoad {
  [super viewDidLoad];

  loadPrefs();

  self.title = @"Settings";

    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
	self.navigationItem.leftBarButtonItem = closeButton;

  	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(killMessageApp)];
	self.navigationItem.rightBarButtonItem = applyButton;

  [[TDPrefsManager sharedInstance] enableExternalCellInset:YES];

UITableView *tableView = self.view.subviews[0];

	UIView *header = [[UIView alloc] init];
	header.frame = CGRectMake(0, 0, tableView.bounds.size.width, 175);
  header.backgroundColor = UIColor.clearColor;
	tableView.tableHeaderView = header;


  self.iconImage = [[UIImageView alloc] init];
  self.iconImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Nova.bundle/Settings/banner-icon.png"];
  self.iconImage.layer.cornerRadius = 15;
	self.iconImage.clipsToBounds = true;
  [header addSubview:self.iconImage];

  self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.iconImage.heightAnchor constraintEqualToConstant:70].active = YES;
  [self.iconImage.widthAnchor constraintEqualToConstant:70].active = YES;
  [self.iconImage.topAnchor constraintEqualToAnchor:header.topAnchor constant:20].active = YES;
  [[self.iconImage centerXAnchor] constraintEqualToAnchor:header.centerXAnchor].active = true;


  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.textColor = UIColor.whiteColor;
  self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
  self.titleLabel.text = @"NOVA";
  [header addSubview:self.titleLabel];

  [self.titleLabel x:header.centerXAnchor];
  [self.titleLabel top:self.iconImage.bottomAnchor padding:15];

    [tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}


-(void)killMessageApp {
  [self invokeHapticFeedback];
  [self dismissViewControllerAnimated:YES completion:nil];
  [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/DismissSetting" object:nil userInfo:nil deliverImmediately:YES];
  [self performSelector:@selector(killProcess) withObject:nil afterDelay:0.3];
}


-(void)killProcess {

  pid_t pid;
  int status;
  const char* args[] = {"killall", "MobileSMS", NULL};
  posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
  waitpid(pid, &status, WEXITED);
}


-(void)dismissVC {
    [self invokeHapticFeedback];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/DismissSetting" object:nil userInfo:nil deliverImmediately:YES];
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


@implementation NOVExtComposeListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NovaPrefs.bundle/Assets/ExtSettings/"];
		_specifiers = [self loadSpecifiersFromPlistName:@"Compose" target:self bundle:bundle];
	}

	return _specifiers;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Compose Settings";

  [[TDPrefsManager sharedInstance] enableExternalCellInset:YES];

  	UITableView *tableView = self.view.subviews[0];
    [tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}

@end


@implementation NOVExtColourListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NovaPrefs.bundle/Assets/ExtSettings/"];
		_specifiers = [self loadSpecifiersFromPlistName:@"Colour" target:self bundle:bundle];
	}

	return _specifiers;
}


- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Colour";

  [[TDPrefsManager sharedInstance] enableExternalCellInset:YES];

  	UITableView *tableView = self.view.subviews[0];
    [tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}

@end


@implementation NOVExtMiscellaneousListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NovaPrefs.bundle/Assets/ExtSettings/"];
		_specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self bundle:bundle];
	}

	return _specifiers;
}


- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Miscellaneous";

  [[TDPrefsManager sharedInstance] enableExternalCellInset:YES];

  	UITableView *tableView = self.view.subviews[0];
    [tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}

@end