#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "SettingManager.h"

@protocol FavouriteActionButtonDelegate <NSObject>
@optional
- (void)callButtonTappedForCell:(UICollectionViewCell *)cell;
- (void)messageButtonTappedForCell:(UICollectionViewCell *)cell;
- (void)emailButtonTappedForCell:(UICollectionViewCell *)cell;
@end

@interface FavouriteCell : UICollectionViewCell
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *avatarImage;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIView *actionView;
@property (nonatomic, retain) UIStackView *favStackView;
@property (nonatomic, retain) UIButton *favCallButton;
@property (nonatomic, retain) UIButton *favMessageButton;
@property (nonatomic, retain) UIButton *favEmailButton;
@property (nonatomic, retain) UIColor *accentColour;
@property (nonatomic, retain) UIView *iconView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, weak) id <FavouriteActionButtonDelegate> favouriteDelegate;
@end
