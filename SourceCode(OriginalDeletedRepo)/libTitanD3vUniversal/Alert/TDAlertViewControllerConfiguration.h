#import <UIKit/UIKit.h>
#import "TDAlertActionConfiguration.h"
#import "TDAlertViewControllerTransitionStyle.h"


@interface TDAlertViewControllerConfiguration : NSObject <NSCopying>

@property (nonatomic) BOOL showsStatusBar;
@property (nonatomic) TDAlertViewControllerTransitionStyle transitionStyle;
@property (nonatomic) BOOL backgroundTapDismissalGestureEnabled;
@property (nonatomic) BOOL swipeDismissalGestureEnabled;
@property (nonatomic) BOOL alwaysArrangesActionButtonsVertically;
@property (nonatomic) UIColor *alertViewBackgroundColor;
@property (nonatomic) CGFloat alertViewCornerRadius;
@property (nonatomic) UIColor *titleTextColor;
@property (nonatomic) UIColor *messageTextColor;
@property (nonatomic) BOOL showsSeparators;
@property (nonatomic) UIColor *separatorColor;
@property (nonatomic) UIEdgeInsets contentViewInset;
@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIFont *messageFont;
@property (nonatomic, strong) TDAlertActionConfiguration *buttonConfiguration;
@property (nonatomic, strong) TDAlertActionConfiguration *destructiveButtonConfiguration;
@property (nonatomic, strong) TDAlertActionConfiguration *cancelButtonConfiguration;

@end

