@import UIKit;

@class AVTAvatarStore;

@interface AVTAvatarLibraryViewController: UIViewController
- (instancetype)initWithAvatarStore:(AVTAvatarStore *)store;
@end

#define ASAvatarLibraryViewController NSClassFromString(@"AVTAvatarLibraryViewController")
