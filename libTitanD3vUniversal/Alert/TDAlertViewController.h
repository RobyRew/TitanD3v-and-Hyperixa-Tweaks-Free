#import <UIKit/UIKit.h>
#import "TDAlertAction.h"
#import "TDAlertViewControllerConfiguration.h"
#import "TDUtilities.h"

@interface TDAlertViewController : UIViewController

- (instancetype)initWithOptions:(nullable TDAlertViewControllerConfiguration *)configuration title:(nullable NSString *)title message:(nullable NSString *)message actions:(NSArray<TDAlertAction *> *)actions;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@property (nonatomic, readonly) TDAlertViewControllerConfiguration *configuration;
@property (nonatomic, nullable) NSString *message;
@property (nonatomic, nullable) UIView *alertViewContentView;
@property (nonatomic) CGFloat maximumWidth;
@property (nonatomic, readonly) NSArray<TDAlertAction *> *actions;
@property (nonatomic, readonly) NSArray<UITextField *> *textFields;

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

@end

