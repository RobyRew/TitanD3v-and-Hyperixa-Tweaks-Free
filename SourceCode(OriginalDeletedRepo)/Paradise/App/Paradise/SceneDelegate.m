#import "SceneDelegate.h"

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    [self.window setTintColor:[UIColor colorNamed:@"Accent"]];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
//    imageView.image = [UIImage imageNamed:@"splashscreen"];
//    [self.window.rootViewController.view addSubview:imageView];
//    [self.window.rootViewController.view bringSubviewToFront:imageView];
//
//    [UIView transitionWithView:self.window duration:5.0f options:UIViewAnimationOptionTransitionNone animations:^(void){
//        imageView.alpha = 0.0f;
//
//    } completion:^(BOOL finished){
//        [imageView removeFromSuperview];
//
//    }];
    
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    [self refreshAppDetails];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    [self refreshAppDetails];
    
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    [self refreshAppDetails];
    
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    [self refreshAppDetails];
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    [self refreshAppDetails];

    
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    [self refreshAppDetails];
    
}


-(void)refreshAppDetails {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAppDetailsNotification" object:self];
}
  
@end



