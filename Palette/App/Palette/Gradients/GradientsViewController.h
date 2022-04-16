#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "GradientCell.h"
#import "FCAlertView.h"

@interface GradientsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *colourArray;
@end

