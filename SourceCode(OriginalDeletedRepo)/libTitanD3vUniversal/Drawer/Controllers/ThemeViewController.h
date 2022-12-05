#import <UIKit/UIKit.h>
#import "TDColorPickerViewController.h"
#import "TDPrefsManager.h"
#import "GlobalPrefs.h"
#import "TDAppearance.h"
#import "HEXColour.h"
#import "ThemeCell.h"
#import "BlurBannerView.h"

@interface ThemeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, TDColorPickerDelegate> {
  NSInteger colourPickerIndex;
}

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *themeArray;
@property (nonatomic, retain) BlurBannerView *bannerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIColor *tintColour;
@end
