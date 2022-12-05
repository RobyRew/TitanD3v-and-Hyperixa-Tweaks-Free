#import <UIKit/UIKit.h>
#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import <SafariServices/SafariServices.h>
#import "PHXHelper.m"
#import "PHXPurchaseCell.h"

@interface PHXPurchaseViewController : UIViewController <SFSafariViewControllerDelegate, TDCyclePagerViewDataSource, TDCyclePagerViewDelegate>
@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UILabel *tweaknameLabel;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UIButton *purchaseButton;
@property (nonatomic, retain) UIButton *trialButton;
@property (nonatomic, retain) UIButton *cancelButton;
@property (nonatomic, retain) TDConfettiView *confettiView;
@property (nonatomic, retain) UIImageView *bannerImage;
@property (nonatomic, retain) UIImageView *helpImage;
@property (nonatomic, retain) UIImageView *paypalImage;
@property (nonatomic, retain) UIImageView *stripeImage;
@property (nonatomic, strong) TDCyclePagerView *collectionView;
@property (nonatomic, strong) NSArray *screenshotArray;
@end
