#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "GlobalPreferences.h"

@interface IconCell : UITableViewCell 

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) TDMarqueeLabel *subtitleLabel;
@property (nonatomic, retain) UIImageView *accessoriesImage;
@end
