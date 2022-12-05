#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <PhotosUI/PhotosUI.h>
#import <AVKit/AVKit.h>
#import "ConstraintExtension.h"
#import "LibraryCell.h"
#import "TDHeaderView.h"
#import "LibraryDataSource.h"

@interface LibraryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *videoArray;
@property (nonatomic, retain) UILabel *messageLabel;
@end
