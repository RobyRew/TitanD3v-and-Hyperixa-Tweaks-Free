#import "SceneDelegate.h"
#import "AvatarManager.h"

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    HomeViewController *vc = [[HomeViewController alloc] init];
    HomeNavigationViewController *nvc = [[HomeNavigationViewController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];
    
    
    if (![[NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/AvatarKit.framework"] load]) {
        NSLog(@"Couldn't load avatar framework");
    }
    [AvatarManager prepareMemojiRuntime];
    

}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
//    dispatch_async(dispatch_get_main_queue(), ^{
//    [self checkLicenceStatus];
//    });
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//    dispatch_async(dispatch_get_main_queue(), ^{
//    [self checkLicenceStatus];
//    });
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
//    dispatch_async(dispatch_get_main_queue(), ^{
//    [self checkLicenceStatus];
//    });
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
//    dispatch_async(dispatch_get_main_queue(), ^{
//    [self checkLicenceStatus];
//    });
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
//    dispatch_async(dispatch_get_main_queue(), ^{
//    [self checkLicenceStatus];
//    });
}


@end
