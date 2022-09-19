#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TDAlertViewButtonType) {
  TDAlertViewButtonTypeDefault,
  TDAlertViewButtonTypeRoundRect,
  TDAlertViewButtonTypeBordered
};

@interface TDAlertViewButton : UIButton

@property (nonatomic) TDAlertViewButtonType type;
@property (nonatomic) CGFloat cornerRadius;

@end
