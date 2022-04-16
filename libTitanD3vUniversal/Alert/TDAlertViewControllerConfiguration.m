#import "TDAlertViewControllerConfiguration.h"

@implementation TDAlertViewControllerConfiguration

- (instancetype)init {
  self = [super init];

  if (self) {
    _showsStatusBar = YES;
    _transitionStyle = TDAlertViewControllerTransitionStyleSlideFromTop;

    _backgroundTapDismissalGestureEnabled = NO;
    _swipeDismissalGestureEnabled = NO;
    _alwaysArrangesActionButtonsVertically = NO;

    _titleTextColor = [UIColor darkGrayColor];
    _messageTextColor = [UIColor darkGrayColor];

    _alertViewBackgroundColor = [UIColor whiteColor];
    _alertViewCornerRadius = 6.0f;

    _showsSeparators = YES;
    _separatorColor = [UIColor lightGrayColor];

    _contentViewInset = UIEdgeInsetsZero;

    _titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _messageFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];

    _buttonConfiguration = [TDAlertActionConfiguration new];

    _destructiveButtonConfiguration = [TDAlertActionConfiguration new];
    _destructiveButtonConfiguration.titleColor = [UIColor colorWithRed:1.0f green:0.23f blue:0.21f alpha:1.0f];

    _cancelButtonConfiguration = [TDAlertActionConfiguration new];
    _cancelButtonConfiguration.titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
  }

  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone {
  return self;
}

@end
