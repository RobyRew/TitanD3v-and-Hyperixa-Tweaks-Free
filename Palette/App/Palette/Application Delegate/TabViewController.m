#import "TabViewController.h"

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyCollectionViewController *collectionVC = [[MyCollectionViewController alloc] init];
    UINavigationController *collectionNavigationController = [[UINavigationController alloc] initWithRootViewController:collectionVC];
    
    ColourSectionViewController *colourSectionVC = [[ColourSectionViewController alloc] init];
    UINavigationController *colourSectionNavigationController = [[UINavigationController alloc] initWithRootViewController:colourSectionVC];
    
    GradientsViewController *gradientVC = [[GradientsViewController alloc] init];
    UINavigationController *gradientNavigationController = [[UINavigationController alloc] initWithRootViewController:gradientVC];
    
//    FavouriteViewController *fvc = [[FavouriteViewController alloc] init];
//    UINavigationController *favNavigationController = [[UINavigationController alloc] initWithRootViewController:fvc];
    
    NSArray *tabbarArray = @[collectionNavigationController, colourSectionNavigationController, gradientNavigationController];
    [self setViewControllers:tabbarArray];
    
    collectionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"My Collection" image:[UIImage systemImageNamed:@"heart.fill"] tag:0];
    colourSectionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Colours" image:[UIImage systemImageNamed:@"paintpalette.fill"] tag:1];
    gradientVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Gradients" image:[UIImage systemImageNamed:@"paintbrush.pointed.fill"] tag:2];
    //fvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favourite" image:[UIImage systemImageNamed:@"heart.fill"] tag:3];
    
}


@end
