#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    [self.window setTintColor:[UIColor colorNamed:@"Accent"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewCollectionNotification" object:self];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewCollectionNotification" object:self];
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewCollectionNotification" object:self];
}


- (void)sceneWillResignActive:(UIScene *)scene {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewCollectionNotification" object:self];
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewCollectionNotification" object:self];
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewCollectionNotification" object:self];
}


@end
