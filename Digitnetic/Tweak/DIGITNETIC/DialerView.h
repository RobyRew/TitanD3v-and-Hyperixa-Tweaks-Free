#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "GlobalPreferences.h"

@interface DialerView : UIView

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIButton *keypadCall;
@property (nonatomic, strong) UIImageView *phoneImage;
@property (nonatomic, strong) UIButton *keypadAsterisk;
@property (nonatomic, strong) UIButton *keypadZero;
@property (nonatomic, strong) UIButton *keypadHash;
@property (nonatomic, strong) UIButton *keypadDelete;
@property (nonatomic, strong) UIImageView *deleteImage;
@property (nonatomic, strong) UIButton *keypadOne;
@property (nonatomic, strong) UIButton *keypadTwo;
@property (nonatomic, strong) UIButton *keypadThree;
@property (nonatomic, strong) UIButton *keypadFour;
@property (nonatomic, strong) UIButton *keypadFive;
@property (nonatomic, strong) UIButton *keypadSix;
@property (nonatomic, strong) UIButton *keypadSeven;
@property (nonatomic, strong) UIButton *keypadEight;
@property (nonatomic, strong) UIButton *keypadNine;
@property (strong, nonatomic) UIView *fieldView;
@property (nonatomic, retain) UILabel *numberLabel;

@end

