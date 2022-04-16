#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "GlobalPrefernces.h"

@interface ActiveCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *remainingLabel;
@property (nonatomic, retain) UIImageView *avatarImage;
@property (nonatomic, retain) UILabel *recipientLabel;
@property (nonatomic, retain) UITextView *messageLabel;
@property (nonatomic, retain) UILabel *scheduleLabel;
@property (nonatomic, retain) UIView *splitView;
@property (nonatomic, retain) UIView *remainingView;

@end

