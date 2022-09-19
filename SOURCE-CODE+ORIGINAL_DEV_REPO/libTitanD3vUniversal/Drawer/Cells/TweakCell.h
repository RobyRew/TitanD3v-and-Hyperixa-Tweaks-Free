#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@interface TweakCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UIView *nameView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIView *priceView;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UIView *versionView;
@property (nonatomic, retain) UILabel *versionLabel;
@property (nonatomic, retain) UIView *splitView;
@property (nonatomic, retain) UITextView *descriptionLabel;

@end

