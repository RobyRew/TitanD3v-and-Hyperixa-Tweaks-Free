#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface EditorCell : UICollectionViewCell
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UIImageView *previewImage;
@property (nonatomic, retain) UILabel *titleLabel;
@end
