#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "GlobalPreferences.h"

@interface CalculatorView : UIView

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIButton *keypadOne;
@property (nonatomic, strong) UIButton *keypadTwo;
@property (nonatomic, strong) UIButton *keypadThree;
@property (nonatomic, strong) UIButton *keypadFour;
@property (nonatomic, strong) UIButton *keypadFive;
@property (nonatomic, strong) UIButton *keypadSix;
@property (nonatomic, strong) UIButton *keypadSeven;
@property (nonatomic, strong) UIButton *keypadEight;
@property (nonatomic, strong) UIButton *keypadNine;
@property (nonatomic, strong) UIButton *keypadPunctuation;
@property (nonatomic, strong) UIButton *keypadZero;
@property (nonatomic, strong) UIButton *keypadDelete;
@property (nonatomic, strong) UIButton *keypadPlus;
@property (nonatomic, strong) UIButton *keypadTimes;
@property (nonatomic, strong) UIButton *keypadMinus;
@property (nonatomic, strong) UIButton *keypadDivide;
@property (nonatomic, strong) UIButton *keypadTotal;
@property (nonatomic, strong) UIButton *keypadClearall;
@property (strong, nonatomic) UIView *fieldView;
@property (strong, nonatomic) UILabel *calculatorLabel;
@property (strong, nonatomic) UILabel *resultLabel;

@end

