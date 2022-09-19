#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"

@protocol ToolsButtonDelegate <NSObject>
@optional
- (void)resetToolsForCell:(UITableViewCell *)cell;
@end

@interface ToolsCell : UITableViewCell
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *resetButton;
@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, weak) id <ToolsButtonDelegate> toolsDelegate;
@end

