#import "TabViewController.h"


@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EditorViewController *editorVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditorViewController"];
    
    //AccessoriesViewController *accessoriesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccessoriesViewController"];
    //UINavigationController *accessoriesNavigationController = [[UINavigationController alloc] initWithRootViewController:accessoriesVC];
    
    ThemesViewController *themesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ThemesViewController"];
    UINavigationController *themesNavigationController = [[UINavigationController alloc] initWithRootViewController:themesVC];
    
    //LibraryViewController *libraryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LibraryViewController"];
    //UINavigationController *libraryNavigationController = [[UINavigationController alloc] initWithRootViewController:libraryVC];
    //
    //SettingsViewController *settingsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    //UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    
    //NSArray *tabbarArray = @[editorVC, accessoriesNavigationController, themesNavigationController, libraryNavigationController, settingsNavigationController];
    NSArray *tabbarArray = @[editorVC, themesNavigationController];
    [self setViewControllers:tabbarArray];
    
    editorVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Editor" image:[UIImage systemImageNamed:@"scribble.variable"] tag:0];
    //accessoriesVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Accessories" image:[UIImage systemImageNamed:@"apps.iphone"] tag:1];
    themesVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Themes" image:[UIImage systemImageNamed:@"folder.fill"] tag:2];
    //libraryVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Templates" image:[UIImage systemImageNamed:@"square.fill"] tag:3];
    //settingsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage systemImageNamed:@"gear"] tag:4];
}


@end
