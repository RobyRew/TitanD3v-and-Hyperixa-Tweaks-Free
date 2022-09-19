#import "DialerView.h"

@implementation DialerView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    loadPrefs();
    
    if (toggleKeypadBackgroundImage) {
      self.backgroundImage = [[UIImageView alloc] initWithFrame:self.bounds];
      self.backgroundImage.image = [UIImage imageWithData:keypadBackgroundImage];
      self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
      [self addSubview:self.backgroundImage];
    }
    
    
    self.keypadCall = [[UIButton alloc] initWithFrame:CGRectZero];
    self.keypadCall.layer.cornerRadius = 20;
    [self.keypadCall addTarget:self action:@selector(callPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadCall];
    
    [self.keypadCall size:CGSizeMake(115, 40)];
    [self.keypadCall x:self.centerXAnchor];
    [self.keypadCall bottom:self.bottomAnchor padding:-5];
    
    
    self.phoneImage = [[UIImageView alloc] init];
    self.phoneImage.userInteractionEnabled = true;
    self.phoneImage.image = [[UIImage systemImageNamed:@"phone.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.phoneImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.keypadCall addSubview:self.phoneImage];
    
    [self.phoneImage size:CGSizeMake(30, 30)];
    [self.phoneImage x:self.keypadCall.centerXAnchor y:self.keypadCall.centerYAnchor];
    
    [self.phoneImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(callPressed)]];
    
    
    self.keypadDelete = [[UIButton alloc] initWithFrame:CGRectZero];
    self.keypadDelete.backgroundColor = [UIColor clearColor];
    [self.keypadDelete addTarget:self action:@selector(deletePressed) forControlEvents:UIControlEventTouchUpInside];
    self.keypadDelete.hidden = YES;
    [self addSubview:self.keypadDelete];
    
    [self.keypadDelete leading:self.keypadCall.trailingAnchor padding:0];
    [self.keypadDelete trailing:self.trailingAnchor padding:0];
    [self.keypadDelete y:self.keypadCall.centerYAnchor];
    [self.keypadDelete height:40];
    
    
    self.deleteImage = [[UIImageView alloc] init];
    self.deleteImage.userInteractionEnabled = true;
    self.deleteImage.image = [[UIImage systemImageNamed:@"delete.left.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.deleteImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.keypadDelete addSubview:self.deleteImage];
    
    [self.deleteImage size:CGSizeMake(30, 30)];
    [self.deleteImage x:self.keypadDelete.centerXAnchor y:self.keypadDelete.centerYAnchor];
    
    [self.deleteImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(deletePressed)]];
    
    
    self.keypadAsterisk = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadAsterisk setTitle:@"*" forState:UIControlStateNormal];
    self.keypadAsterisk.layer.cornerRadius = 22.5;
    self.keypadAsterisk.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadAsterisk.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadAsterisk addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadAsterisk];
    
    [self.keypadAsterisk size:CGSizeMake(45, 45)];
    [self.keypadAsterisk leading:self.leadingAnchor padding:30];
    [self.keypadAsterisk bottom:self.keypadCall.topAnchor padding:-7];
    
    
    self.keypadZero = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadZero setTitle:@"0" forState:UIControlStateNormal];
    self.keypadZero.layer.cornerRadius = 22.5;
    self.keypadZero.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadZero.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadZero addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadZero];
    
    [self.keypadZero size:CGSizeMake(45, 45)];
    [self.keypadZero x:self.centerXAnchor];
    [self.keypadZero bottom:self.keypadCall.topAnchor padding:-7];
    
    
    self.keypadHash = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadHash setTitle:@"#" forState:UIControlStateNormal];
    self.keypadHash.layer.cornerRadius = 22.5;
    self.keypadHash.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadHash.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadHash addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadHash];
    
    [self.keypadHash size:CGSizeMake(45, 45)];
    [self.keypadHash trailing:self.trailingAnchor padding:-30];
    [self.keypadHash bottom:self.keypadCall.topAnchor padding:-7];
    
    
    self.keypadSeven = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadSeven setTitle:@"7" forState:UIControlStateNormal];
    self.keypadSeven.layer.cornerRadius = 22.5;
    self.keypadSeven.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadSeven.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadSeven addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadSeven];
    
    [self.keypadSeven size:CGSizeMake(45, 45)];
    [self.keypadSeven leading:self.leadingAnchor padding:30];
    [self.keypadSeven bottom:self.keypadAsterisk.topAnchor padding:-4];
    
    
    self.keypadEight = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadEight setTitle:@"8" forState:UIControlStateNormal];
    self.keypadEight.layer.cornerRadius = 22.5;
    self.keypadEight.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadEight.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadEight addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadEight];
    
    [self.keypadEight size:CGSizeMake(45, 45)];
    [self.keypadEight x:self.keypadZero.centerXAnchor];
    [self.keypadEight bottom:self.keypadZero.topAnchor padding:-4];
    
    
    self.keypadNine = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadNine setTitle:@"9" forState:UIControlStateNormal];
    self.keypadNine.layer.cornerRadius = 22.5;
    self.keypadNine.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadNine.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadNine addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadNine];
    
    [self.keypadNine size:CGSizeMake(45, 45)];
    [self.keypadNine trailing:self.trailingAnchor padding:-30];
    [self.keypadNine bottom:self.keypadHash.topAnchor padding:-4];
    
    
    self.keypadFour = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadFour setTitle:@"4" forState:UIControlStateNormal];
    self.keypadFour.layer.cornerRadius = 22.5;
    self.keypadFour.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadFour.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadFour addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadFour];
    
    [self.keypadFour size:CGSizeMake(45, 45)];
    [self.keypadFour leading:self.leadingAnchor padding:30];
    [self.keypadFour bottom:self.keypadSeven.topAnchor padding:-4];
    
    
    self.keypadFive = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadFive setTitle:@"5" forState:UIControlStateNormal];
    self.keypadFive.layer.cornerRadius = 22.5;
    self.keypadFive.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadFive.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadFive addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadFive];
    
    [self.keypadFive size:CGSizeMake(45, 45)];
    [self.keypadFive x:self.centerXAnchor];
    [self.keypadFive bottom:self.keypadEight.topAnchor padding:-4];
    
    
    self.keypadSix = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadSix setTitle:@"6" forState:UIControlStateNormal];
    self.keypadSix.layer.cornerRadius = 22.5;
    self.keypadSix.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadSix.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadSix addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadSix];
    
    [self.keypadSix size:CGSizeMake(45, 45)];
    [self.keypadSix trailing:self.trailingAnchor padding:-30];
    [self.keypadSix bottom:self.keypadNine.topAnchor padding:-4];
    
    
    self.keypadOne = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadOne setTitle:@"1" forState:UIControlStateNormal];
    self.keypadOne.layer.cornerRadius = 22.5;
    self.keypadOne.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadOne.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadOne addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadOne];
    
    [self.keypadOne size:CGSizeMake(45, 45)];
    [self.keypadOne leading:self.leadingAnchor padding:30];
    [self.keypadOne bottom:self.keypadFour.topAnchor padding:-4];
    
    
    self.keypadTwo = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadTwo setTitle:@"2" forState:UIControlStateNormal];
    self.keypadTwo.layer.cornerRadius = 22.5;
    self.keypadTwo.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadTwo.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadTwo addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadTwo];
    
    [self.keypadTwo size:CGSizeMake(45, 45)];
    [self.keypadTwo x:self.centerXAnchor];
    [self.keypadTwo bottom:self.keypadFive.topAnchor padding:-4];
    
    
    self.keypadThree = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.keypadThree setTitle:@"3" forState:UIControlStateNormal];
    self.keypadThree.layer.cornerRadius = 22.5;
    self.keypadThree.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.keypadThree.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.keypadThree addTarget:self action:@selector(keypadNumbersPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.keypadThree];
    
    [self.keypadThree size:CGSizeMake(45, 45)];
    [self.keypadThree trailing:self.trailingAnchor padding:-30];
    [self.keypadThree bottom:self.keypadSix.topAnchor padding:-4];
    
    
    self.fieldView = [[UIView alloc] init];
    self.fieldView.backgroundColor = UIColor.clearColor;
    [self addSubview:self.fieldView];
    
    [self.fieldView top:self.topAnchor padding:0];
    [self.fieldView leading:self.leadingAnchor padding:0];
    [self.fieldView trailing:self.trailingAnchor padding:0];
    [self.fieldView bottom:self.keypadOne.topAnchor padding:0];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pastePhoneNumber)];
    tapGesture.numberOfTapsRequired = 2;
    [self.fieldView addGestureRecognizer:tapGesture];
    
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.text = @"";
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    [self addSubview:self.numberLabel];
    
    [self.numberLabel top:self.topAnchor padding:20];
    [self.numberLabel x:self.centerXAnchor];
    
    if (!toggleKeypadColour) {
      
      self.keypadCall.backgroundColor = UIColor.systemGreenColor;
      self.phoneImage.tintColor = UIColor.whiteColor;
      self.deleteImage.tintColor = UIColor.systemRedColor;
      
      if ([digitneticAppearance isEqualToString:@"digitneticLight"]) {
        
        self.backgroundColor = UIColor.whiteColor;
        self.keypadAsterisk.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadHash.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
        
        [self.keypadAsterisk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadZero setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadSix setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadFive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadFour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadNine setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadEight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadHash setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.keypadSeven setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.numberLabel.textColor = UIColor.blackColor;
        
      } else if ([digitneticAppearance isEqualToString:@"digitneticDark"]) {
        
        self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
        self.keypadAsterisk.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadHash.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
        
        [self.keypadAsterisk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadZero setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadSix setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadFive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadNine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadEight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadHash setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.keypadSeven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.numberLabel.textColor = UIColor.whiteColor;
        
      } else if ([digitneticAppearance isEqualToString:@"digitneticDynamic"]) {
        
        if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
          
          self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
          self.keypadAsterisk.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadHash.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
          
          [self.keypadAsterisk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadZero setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadSix setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadFive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadNine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadEight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadHash setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [self.keypadSeven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          self.numberLabel.textColor = UIColor.whiteColor;
          
        } else {
          
          self.backgroundColor = UIColor.whiteColor;
          self.keypadAsterisk.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadHash.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
          
          [self.keypadAsterisk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadZero setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadSix setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadFive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadFour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadNine setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadEight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadHash setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [self.keypadSeven setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          self.numberLabel.textColor = UIColor.blackColor;
          
        }
        
      }
      
    } else {
      
      self.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadBackgroundColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadCall.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadCallButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.phoneImage.tintColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadCallIconColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadAsterisk.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadZero.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadHash.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadSeven.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadEight.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadNine.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadFour.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadFive.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadSix.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadOne.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadTwo.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      self.keypadThree.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadButtonColour" defaultValue:@"FFFFFF" ID:BID];
      
      [self.keypadAsterisk setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadZero setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadThree setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadTwo setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadOne setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadSix setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadFive setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadFour setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadNine setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadEight setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadHash setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      [self.keypadSeven setTitleColor:[[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID] forState:UIControlStateNormal];
      self.numberLabel.textColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadFontColour" defaultValue:@"FFFFFF" ID:BID];
      self.deleteImage.tintColor = [[TDTweakManager sharedInstance] colourForKey:@"keypadDeleteColour" defaultValue:@"FFFFFF" ID:BID];
      
    }
    
    
  }
  return self;
}


- (void)keypadNumbersPressed:(UIButton *)sender {
  
  [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
    sender.alpha = 0.4;
  }
  completion:^(BOOL finished) {
    sender.alpha = 1.0;
  }];
  
  [self invokeHapticFeedback];
  
  NSString *expression = [NSString stringWithFormat:@"%@%@", self.numberLabel.text, sender.titleLabel.text];
  
  self.numberLabel.text = expression;
  
  if (self.numberLabel.text.length > 0) {
    self.keypadDelete.hidden = NO;
  } else {
    self.keypadDelete.hidden = YES;
  }
  
}


- (void)deletePressed {

  [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
    self.keypadDelete.alpha = 0.4;
  }
  completion:^(BOOL finished) {
    self.keypadDelete.alpha = 1.0;
  }];  
  
  [self invokeHapticFeedback];
  
  if (self.numberLabel.text.length == 0) {
    return;
  }
  
  NSString *numericExpression = self.numberLabel.text;
  numericExpression = [numericExpression substringToIndex:[numericExpression length]-1];
  self.numberLabel.text = numericExpression;
  
  if (self.numberLabel.text.length > 0) {
    self.keypadDelete.hidden = NO;
  } else {
    self.keypadDelete.hidden = YES;
  }
}


- (void)callPressed {

  [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
    self.keypadCall.alpha = 0.4;
  }
  completion:^(BOOL finished) {
    self.keypadCall.alpha = 1.0;
  }];
  
  [self invokeHapticFeedback];
  
  NSString *phoneNumber = [NSString stringWithFormat:@"tel:%@", self.numberLabel.text];
  UIApplication *application = [UIApplication sharedApplication];
  [application openURL:[NSURL URLWithString:phoneNumber] options:@{} completionHandler:nil];
  
  //     NSURL *phoneNumber = [NSURL URLWithString:@"telprompt://13232222222"];
  //     [[UIApplication sharedApplication] openURL:phoneNumber];
  
  self.keypadDelete.hidden = YES;
  self.numberLabel.text = @"";
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"HideDigitneticNotification" object:self];
}


-(void)pastePhoneNumber {
  UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
  NSString *pasteNumber = pasteboard.string;
  self.numberLabel.text = pasteNumber;
  
  if (self.numberLabel.text.length > 0) {
    self.keypadDelete.hidden = NO;
  } else {
    self.keypadDelete.hidden = YES;
  }
  [self invokeHapticFeedback];
}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {
  
  if ([digitneticAppearance isEqualToString:@"digitneticDynamic"]) {
    
    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
      
      self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
      self.keypadAsterisk.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadHash.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.17 green: 0.17 blue: 0.18 alpha: 1.00];
      
      [self.keypadAsterisk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadZero setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadSix setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadFive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadNine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadEight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadHash setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [self.keypadSeven setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      self.numberLabel.textColor = UIColor.whiteColor;
      
    } else {
      
      self.backgroundColor = UIColor.whiteColor;
      self.keypadAsterisk.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadZero.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadHash.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadSeven.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadEight.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadNine.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadFour.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadFive.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadSix.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadOne.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadTwo.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      self.keypadThree.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00];
      
      [self.keypadAsterisk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadZero setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadSix setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadFive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadFour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadNine setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadEight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadHash setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.keypadSeven setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      self.numberLabel.textColor = UIColor.blackColor;
      
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

@end
