#import <TitanD3vUniversal/TitanD3vUniversal.h>

@interface FavouriteCategoriesCell : UICollectionViewCell {
    CGFloat iconSize;
    CGFloat iconTopPadding;
    CGFloat fontSize;
    CGFloat fontBottomPadding;
}
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@end
