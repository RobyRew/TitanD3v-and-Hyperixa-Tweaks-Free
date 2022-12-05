#import <UIKit/UIKit.h>
#import "AVTAnimoji.h"
#import "AnimojiPickerCell.h"  


@protocol AnimojiPickerDelegate <NSObject>
- (void)didSelectAnimojiWithName:(NSString *)animojiName;
@end


@interface AnimojiPickerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) id<AnimojiPickerDelegate> delegate;
@property (nonatomic, assign) CGFloat referenceHeight;
-(void)selectPuppetWithName:(NSString *)puppetName;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
