#import "CalculatorView.h"

@implementation CalculatorView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    loadPrefs();
    
    if (toggleCalculatorBackgroundImage) {
      self.backgroundImage = [[UIImageView alloc] initWithFrame:self.bounds];
      self.backgroundImage.image = [UIImage imageWithData:calculatorBackgroundImage];
      self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
      [self addSubview:self.backgroundImage];
    }
    
    
    self.keypadZero = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadZero setTitle:@"0" forState:UIControlStateNormal];
    self.keypadZero.layer.cornerRadius = 20;
    self.keypadZero.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadZero.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadZero addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadZero];
    
    [self.keypadZero size:CGSizeMake(115, 40)];
    [self.keypadZero leading:self.leadingAnchor padding:5];
    [self.keypadZero bottom:self.bottomAnchor padding:-5];
    
    
    self.keypadPunctuation = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadPunctuation setTitle:@"." forState:UIControlStateNormal];
    self.keypadPunctuation.layer.cornerRadius = 20;
    self.keypadPunctuation.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadPunctuation.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.keypadPunctuation addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadPunctuation];
    
    [self.keypadPunctuation size:CGSizeMake(55, 40)];
    [self.keypadPunctuation leading:self.keypadZero.trailingAnchor padding:5];
    [self.keypadPunctuation bottom:self.bottomAnchor padding:-5];
    
    
    self.keypadTotal = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadTotal setTitle:@"=" forState:UIControlStateNormal];
    self.keypadTotal.layer.cornerRadius = 20;
    self.keypadTotal.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadTotal.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadTotal addTarget:self action:@selector(resultPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadTotal];
    
    [self.keypadTotal size:CGSizeMake(55, 40)];
    [self.keypadTotal leading:self.keypadPunctuation.trailingAnchor padding:5];
    [self.keypadTotal bottom:self.bottomAnchor padding:-5];
    
    
    self.keypadOne = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadOne setTitle:@"1" forState:UIControlStateNormal];
    self.keypadOne.layer.cornerRadius = 20;
    self.keypadOne.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadOne.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadOne addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadOne];
    
    [self.keypadOne size:CGSizeMake(55, 40)];
    [self.keypadOne leading:self.leadingAnchor padding:5];
    [self.keypadOne bottom:self.keypadZero.topAnchor padding:-5];
    
    
    self.keypadTwo = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadTwo setTitle:@"2" forState:UIControlStateNormal];
    self.keypadTwo.layer.cornerRadius = 20;
    self.keypadTwo.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadTwo.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadTwo addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadTwo];
    
    [self.keypadTwo size:CGSizeMake(55, 40)];
    [self.keypadTwo leading:self.keypadOne.trailingAnchor padding:5];
    [self.keypadTwo bottom:self.keypadZero.topAnchor padding:-5];
    
    
    self.keypadThree = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadThree setTitle:@"3" forState:UIControlStateNormal];
    self.keypadThree.layer.cornerRadius = 20;
    self.keypadThree.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadThree.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadThree addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadThree];
    
    [self.keypadThree size:CGSizeMake(55, 40)];
    [self.keypadThree leading:self.keypadTwo.trailingAnchor padding:5];
    [self.keypadThree bottom:self.keypadPunctuation.topAnchor padding:-5];
    
    
    self.keypadPlus = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadPlus setTitle:@"+" forState:UIControlStateNormal];
    self.keypadPlus.layer.cornerRadius = 20;
    self.keypadPlus.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadPlus.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadPlus addTarget:self action:@selector(arithmeticPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadPlus];
    
    [self.keypadPlus size:CGSizeMake(55, 40)];
    [self.keypadPlus leading:self.keypadThree.trailingAnchor padding:5];
    [self.keypadPlus bottom:self.keypadTotal.topAnchor padding:-5];
    
    
    self.keypadFour = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadFour setTitle:@"4" forState:UIControlStateNormal];
    self.keypadFour.layer.cornerRadius = 20;
    self.keypadFour.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadFour.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadFour addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadFour];
    
    [self.keypadFour size:CGSizeMake(55, 40)];
    [self.keypadFour leading:self.leadingAnchor padding:5];
    [self.keypadFour bottom:self.keypadOne.topAnchor padding:-5];
    
    
    self.keypadFive = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadFive setTitle:@"5" forState:UIControlStateNormal];
    self.keypadFive.layer.cornerRadius = 20;
    self.keypadFive.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadFive.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadFive addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadFive];
    
    [self.keypadFive size:CGSizeMake(55, 40)];
    [self.keypadFive leading:self.keypadFour.trailingAnchor padding:5];
    [self.keypadFive bottom:self.keypadTwo.topAnchor padding:-5];
    
    // Six button
    self.keypadSix = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadSix setTitle:@"6" forState:UIControlStateNormal];
    self.keypadSix.layer.cornerRadius = 20;
    self.keypadSix.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadSix.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadSix addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadSix];
    
    [self.keypadSix size:CGSizeMake(55, 40)];
    [self.keypadSix leading:self.keypadFive.trailingAnchor padding:5];
    [self.keypadSix bottom:self.keypadThree.topAnchor padding:-5];
    
    
    self.keypadMinus = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadMinus setTitle:@"-" forState:UIControlStateNormal];
    self.keypadMinus.layer.cornerRadius = 20;
    self.keypadMinus.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadMinus.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadMinus addTarget:self action:@selector(arithmeticPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadMinus];
    
    [self.keypadMinus size:CGSizeMake(55, 40)];
    [self.keypadMinus leading:self.keypadSix.trailingAnchor padding:5];
    [self.keypadMinus bottom:self.keypadPlus.topAnchor padding:-5];
    
    
    self.keypadSeven = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadSeven setTitle:@"7" forState:UIControlStateNormal];
    self.keypadSeven.layer.cornerRadius = 20;
    self.keypadSeven.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadSeven.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadSeven addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadSeven];
    
    [self.keypadSeven size:CGSizeMake(55, 40)];
    [self.keypadSeven leading:self.leadingAnchor padding:5];
    [self.keypadSeven bottom:self.keypadFour.topAnchor padding:-5];
    
    
    self.keypadEight = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadEight setTitle:@"8" forState:UIControlStateNormal];
    self.keypadEight.layer.cornerRadius = 20;
    self.keypadEight.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadEight.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadEight addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadEight];
    
    [self.keypadEight size:CGSizeMake(55, 40)];
    [self.keypadEight leading:self.keypadSeven.trailingAnchor padding:5];
    [self.keypadEight bottom:self.keypadFive.topAnchor padding:-5];
    
    
    self.keypadNine = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadNine setTitle:@"9" forState:UIControlStateNormal];
    self.keypadNine.layer.cornerRadius = 20;
    self.keypadNine.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadNine.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadNine addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadNine];
    
    [self.keypadNine size:CGSizeMake(55, 40)];
    [self.keypadNine leading:self.keypadEight.trailingAnchor padding:5];
    [self.keypadNine bottom:self.keypadSix.topAnchor padding:-5];
    
    
    self.keypadTimes = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadTimes setTitle:@"x" forState:UIControlStateNormal];
    self.keypadTimes.layer.cornerRadius = 20;
    self.keypadTimes.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadTimes.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadTimes addTarget:self action:@selector(arithmeticPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadTimes];
    
    [self.keypadTimes size:CGSizeMake(55, 40)];
    [self.keypadTimes leading:self.keypadNine.trailingAnchor padding:5];
    [self.keypadTimes bottom:self.keypadMinus.topAnchor padding:-5];
    
    
    self.keypadClearall = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadClearall setTitle:@"AC" forState:UIControlStateNormal];
    self.keypadClearall.layer.cornerRadius = 20;
    self.keypadClearall.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadClearall.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadClearall addTarget:self action:@selector(clearallPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadClearall];
    
    [self.keypadClearall size:CGSizeMake(115, 40)];
    [self.keypadClearall leading:self.leadingAnchor padding:5];
    [self.keypadClearall bottom:self.keypadSeven.topAnchor padding:-5];
    
    
    self.keypadDelete = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadDelete setTitle:@"<" forState:UIControlStateNormal];
    self.keypadDelete.layer.cornerRadius = 20;
    self.keypadDelete.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadDelete.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [self.keypadDelete addTarget:self action:@selector(deletePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadDelete];
    
    [self.keypadDelete size:CGSizeMake(55, 40)];
    [self.keypadDelete leading:self.keypadClearall.trailingAnchor padding:5];
    [self.keypadDelete bottom:self.keypadEight.topAnchor padding:-5];
    
    
    self.keypadDivide = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadDivide setTitle:@"÷" forState:UIControlStateNormal];
    self.keypadDivide.layer.cornerRadius = 20;
    self.keypadDivide.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadDivide.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadDivide addTarget:self action:@selector(arithmeticPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadDivide];
    
    [self.keypadDivide size:CGSizeMake(55, 40)];
    [self.keypadDivide x:self.keypadTimes.centerXAnchor];
    [self.keypadDivide bottom:self.keypadTimes.topAnchor padding:-5];
    
    
    self.fieldView = [[UIView alloc] init];
    self.fieldView.backgroundColor = UIColor.clearColor;
    [self addSubview:self.fieldView];
    
    [self.fieldView top:self.topAnchor padding:0];
    [self.fieldView leading:self.leadingAnchor padding:0];
    [self.fieldView trailing:self.trailingAnchor padding:0];
    [self.fieldView bottom:self.keypadClearall.topAnchor padding:0];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyResultPressed)];
    tapGesture.numberOfTapsRequired = 2;
    [self.fieldView addGestureRecognizer:tapGesture];
    
    
    self.calculatorLabel = [[UILabel alloc] init];
    self.calculatorLabel.backgroundColor = [UIColor clearColor];
    self.calculatorLabel.userInteractionEnabled = NO;
    self.calculatorLabel.text = @"";
    self.calculatorLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    self.calculatorLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.calculatorLabel];
    
    [self.calculatorLabel top:self.topAnchor padding:10];
    [self.calculatorLabel trailing:self.trailingAnchor padding:-10];
    
    
    self.resultLabel = [[UILabel alloc] init];
    self.resultLabel.backgroundColor = [UIColor clearColor];
    self.resultLabel.userInteractionEnabled = NO;
    self.resultLabel.text = @"";
    self.resultLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.resultLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.resultLabel];
    
    [self.resultLabel bottom:self.keypadDivide.topAnchor padding:-10];
    [self.resultLabel trailing:self.trailingAnchor padding:-10];
    
    
    if (!toggleCalculatorColour) {
      
      self.keypadTotal.backgroundColor = [UIColor systemOrangeColor];
      self.keypadPlus.backgroundColor = [UIColor systemOrangeColor];
      self.keypadMinus.backgroundColor = [UIColor systemOrangeColor];
      self.keypadTimes.backgroundColor = [UIColor systemOrangeColor];
      self.keypadDelete.backgroundColor = [UIColor systemRedColor];
      self.keypadDivide.backgroundColor = [UIColor systemOrangeColor];
      
      
      if ([digitneticAppearance isEqualToString:@"digitneticLight"]) {
        
        self.backgroundColor = UIColor.whiteColor;
        self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadPunctuation.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadClearall.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        
        [self.keypadZero setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadPunctuation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadTotal setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadPlus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadFour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadFive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadSix setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadSeven setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadEight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadNine setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadTimes setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadClearall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadDivide setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.calculatorLabel.textColor = [UIColor blackColor];
        self.resultLabel.textColor = [UIColor blackColor];
        
      } else if ([digitneticAppearance isEqualToString:@"digitneticDark"]) {
        
        self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
        self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadPunctuation.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadClearall.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        
        [self.keypadZero setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadPunctuation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadTotal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadPlus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadFive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadSix setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadMinus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadSeven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadEight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadNine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadTimes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadClearall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadDivide setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.calculatorLabel.textColor = [UIColor whiteColor];
        self.resultLabel.textColor = [UIColor whiteColor];
        
      } else if ([digitneticAppearance isEqualToString:@"digitneticDynamic"]) {
        
        if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
          
          self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
          self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadPunctuation.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadClearall.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          
          [self.keypadZero setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadPunctuation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadTotal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadPlus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadFive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadSix setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadMinus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadSeven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadEight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadNine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadTimes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadClearall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadDivide setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          self.calculatorLabel.textColor = [UIColor whiteColor];
          self.resultLabel.textColor = [UIColor whiteColor];
          
        } else {
          
          self.backgroundColor = UIColor.whiteColor;
          self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadPunctuation.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadClearall.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          
          [self.keypadZero setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadPunctuation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadTotal setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadPlus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadFour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadFive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadSix setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadSeven setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadEight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadNine setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadTimes setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadClearall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadDivide setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          self.calculatorLabel.textColor = [UIColor blackColor];
          self.resultLabel.textColor = [UIColor blackColor];
          
        }
        
      }
      
    } else {
      
      self.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorBackgroundColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadZero.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadPunctuation.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadOne.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadTwo.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadThree.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadFour.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadFive.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadSix.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadSeven.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadEight.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadNine.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadClearall.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadTotal.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorArithmeticColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadPlus.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorArithmeticColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadMinus.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorArithmeticColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadTimes.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorArithmeticColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadDelete.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorDeleteColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadDivide.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorArithmeticColour" defaultValue:@"FFFFFF" ID:BID];
      
      [self.keypadZero setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadPunctuation setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadTotal setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadOne setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadTwo setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadThree setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadPlus setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadFour setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadFive setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadSix setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadMinus setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadSeven setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadEight setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadNine setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadTimes setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadClearall setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadDelete setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadDivide setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      self.calculatorLabel.textColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID];
      self.resultLabel.textColor = [[TDTweakManager sharedInstance] colourForKey:@"calculatorFontColour" defaultValue:@"FFFFFF" ID:BID];
      
    }
    
  }
  return self;
}


- (void)arithmeticPressed:(UIButton *)sender {
  
  [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
    sender.alpha = 0.4;
  }
  completion:^(BOOL finished) {
    sender.alpha = 1.0;
  }];
  
  [self invokeHapticFeedback];
  
  if(self.calculatorLabel.text.length == 0){
    return;
  }
  
  NSString *mul = @"x";
  NSString *div = @"/";
  
  
  if ([sender.titleLabel.text isEqualToString:mul] || [sender.titleLabel.text  isEqualToString:div]) {
    
    NSString *expression = [NSString stringWithFormat:@"(%@)%@",self.calculatorLabel.text,sender.titleLabel.text];
    self.calculatorLabel.text = expression;
    
  } else {
    
    NSString *expression = [NSString stringWithFormat:@"%@%@",self.calculatorLabel.text,sender.titleLabel.text];
    self.calculatorLabel.text = expression;
  }
  
  self.resultLabel.text = @"";
  
}


- (void)resultPressed:(UIButton *)sender {
  
  [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
    sender.alpha = 0.4;
  }
  completion:^(BOOL finished) {
    sender.alpha = 1.0;
  }];
  
  [self invokeHapticFeedback];
  
  if(self.calculatorLabel.text.length == 0){
    return;
  }
  
  @try {
    
    NSString *numericExpression = [NSString stringWithFormat:@"%@", self.calculatorLabel.text];
    
    numericExpression = [numericExpression stringByReplacingOccurrencesOfString:@"x" withString:@"*"];
    
    numericExpression = [numericExpression stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    
    NSExpression *expression = [NSExpression expressionWithFormat:numericExpression];
    
    NSNumber *result = [expression expressionValueWithObject:nil context:nil];
    
    NSLog(@"Total result = %@", [NSString stringWithFormat:@"%@", result]);
    
    self.resultLabel.text = [NSString stringWithFormat:@"= %@", result];
    
  } @catch (NSException *exception) {
    NSLog(@"%@", exception.reason);
  } @finally {
    
  }
  
  
}


- (void)deletePressed:(UIButton *)sender {
  
  [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
    sender.alpha = 0.4;
  }
  completion:^(BOOL finished) {
    sender.alpha = 1.0;
  }];
  
  [self invokeHapticFeedback];
  
  if (self.calculatorLabel.text.length == 0) {
    return;
  }
  
  NSString *numericExpression = self.calculatorLabel.text;
  
  NSString *lastChar = [numericExpression substringFromIndex:[numericExpression length] - 1];
  
  if([lastChar isEqualToString:@")"]){
    
    NSString *Prefix = @"(";
    NSString *Suffix = @")";
    NSRange needleRange = NSMakeRange(Prefix.length, numericExpression.length - Prefix.length - Suffix.length);
    numericExpression = [numericExpression substringWithRange:needleRange];
    
  } else {
    numericExpression = [numericExpression substringToIndex:[numericExpression length]-1];
  }
  
  self.calculatorLabel.text = numericExpression;
  self.resultLabel.text = @"";
}


- (void)clearallPressed:(UIButton *)sender {
  
  [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
    sender.alpha = 0.4;
  }
  completion:^(BOOL finished) {
    sender.alpha = 1.0;
  }];
  
  [self invokeHapticFeedback];
  self.resultLabel.text = @"";
  self.calculatorLabel.text = @"";
}


- (void)keypadNumbersPressed:(UIButton *)sender {
  
  [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
    sender.alpha = 0.4;
  }
  completion:^(BOOL finished) {
    sender.alpha = 1.0;
  }];
  
  [self invokeHapticFeedback];
  
  // if (self.calculatorLabel.text.length != 0) {
  
  //   NSString *lastChar = [self.calculatorLabel.text substringFromIndex:[self.calculatorLabel.text length] - 1];
  
  //   if ([lastChar isEqualToString:@"."] && [sender.titleLabel.text isEqualToString:@"."]) {
  //     return;
  //   }
  // }
  
  NSString *expression = [NSString stringWithFormat:@"%@%@", self.calculatorLabel.text, sender.titleLabel.text];
  
  self.calculatorLabel.text = expression;
  self.resultLabel.text = @"";
  
}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {
  
  if ([digitneticAppearance isEqualToString:@"digitneticDynamic"]) {
    
    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
      
      self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
      self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadPunctuation.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadClearall.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      
      [self.keypadZero setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadPunctuation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadTotal setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadPlus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadFive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadSix setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadMinus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadSeven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadEight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadNine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadTimes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadClearall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadDivide setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      self.calculatorLabel.textColor = [UIColor whiteColor];
      self.resultLabel.textColor = [UIColor whiteColor];
      
    } else {
      
      self.backgroundColor = UIColor.whiteColor;
      self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadPunctuation.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadClearall.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      
      [self.keypadZero setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadPunctuation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadTotal setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadPlus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadFour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadFive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadSix setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadSeven setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadEight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadNine setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadTimes setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadClearall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadDivide setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      self.calculatorLabel.textColor = [UIColor blackColor];
      self.resultLabel.textColor = [UIColor blackColor];
      
    }
    
  }
  
}


-(void)invokeHapticFeedback {
  if (toggleHaptic) {
    
    if (hapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (hapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (hapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }
    
  }
}


-(void)copyResultPressed {
  UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
  pasteboard.string = self.resultLabel.text;
}

@end
