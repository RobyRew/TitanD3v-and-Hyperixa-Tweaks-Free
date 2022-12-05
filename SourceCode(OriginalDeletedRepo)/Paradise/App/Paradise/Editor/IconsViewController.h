#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "GlyphCell.h"

@protocol senddataProtocol <NSObject>
-(void)sendDataToEditor:(UIImage*)image;
@end


@interface IconsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic,assign) id iconDelegate;
@property (nonatomic, retain) UICollectionView *symbolCollectionView;
@end

