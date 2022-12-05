#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "SettingManager.h"

@interface ContactCell : UITableViewCell
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *avatar;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UILabel *emailLabel;
@property (nonatomic) BOOL hideContactsDetails;
@end

