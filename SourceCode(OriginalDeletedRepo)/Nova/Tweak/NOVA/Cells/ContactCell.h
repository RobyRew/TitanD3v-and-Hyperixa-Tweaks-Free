#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"

@protocol ContactButtonDelegate <NSObject>
@optional
- (void)contactButtonTappedForCell:(UITableViewCell *)cell;
@end

@interface ContactCell : UITableViewCell
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIButton *menuButton;
@property (nonatomic, retain) UIImageView *avatarImage;
@property (nonatomic, retain) UIButton *contactButton;
@property (nonatomic, retain) UIImageView *personImage;
@property (nonatomic, retain) UILabel *nameTitleLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *phoneImage;
@property (nonatomic, retain) UILabel *phoneTitleLabel;
@property (nonatomic, retain) UILabel *phoneLabel;
@property (nonatomic, retain) UIView *splitView;
@property (nonatomic, weak) id <ContactButtonDelegate> contactDelegate;

@end

