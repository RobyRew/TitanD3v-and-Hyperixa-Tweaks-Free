#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "./DIGITNETIC/DraggableWindow.h"
#import "./DIGITNETIC/DigitneticFloatingView.h"
#import "./DIGITNETIC/CalculatorView.h"
#import "./DIGITNETIC/DialerView.h"
#import <libactivator/libactivator.h>

static BOOL toggleCalculatorAsPrimrary = NO;
static float cornerRadius;

@interface SpringBoard : UIView
-(void)layoutWindow;
-(void)showKeypad;
-(void)showCalculator;
-(void)hideDigitnetic;
-(void)showDigitnetic;
-(void)showAlertWithSettings;
@end


@interface ShowDigitnetic : NSObject <LAListener>
@end

@interface HideDigitnetic : NSObject <LAListener>
@end


static DraggableWindow *draggableWindow = nil;
static DigitneticFloatingView *digitneticFloatingView;
static UIViewController *baseVC;
static DialerView *dialerView;
static CalculatorView *calculatorView;

%group Digitnetic
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {

  %orig;
  [self layoutWindow];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDigitneticNotification:) name:@"HideDigitneticNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDigitneticNotification:) name:@"ShowDigitneticNotification" object:nil];
}

%new
- (void)receiveDigitneticNotification:(NSNotification *) notification {

  if ([[notification name] isEqualToString:@"HideDigitneticNotification"]) {
    [self hideDigitnetic];
  }
  if ([[notification name] isEqualToString:@"ShowDigitneticNotification"]) {
    [self showDigitnetic];
  }
}

%new
-(void)layoutWindow {


  if (!draggableWindow) {

    draggableWindow = [[DraggableWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    draggableWindow.hidden = NO;


    digitneticFloatingView = [[DigitneticFloatingView alloc] initWithFrame:CGRectMake(5, 100, 245, 300)];
    digitneticFloatingView.layer.cornerRadius = cornerRadius;
    digitneticFloatingView.layer.cornerCurve = kCACornerCurveContinuous;
    digitneticFloatingView.backgroundColor = UIColor.clearColor;
    digitneticFloatingView.clipsToBounds = true;
    digitneticFloatingView.alpha = 0;
    [digitneticFloatingView setDragEnable:YES];
    [digitneticFloatingView setAdsorbEnable:YES];
    [draggableWindow addSubview:digitneticFloatingView];


    baseVC = [[UIViewController alloc] init];
    baseVC.view.frame = digitneticFloatingView.bounds;
    [digitneticFloatingView addSubview:baseVC.view];


    dialerView = [[DialerView alloc] initWithFrame:baseVC.view.bounds];
    [baseVC.view addSubview:dialerView];


    calculatorView = [[CalculatorView alloc] initWithFrame:baseVC.view.bounds];
    [baseVC.view addSubview:calculatorView];


    if (toggleCalculatorAsPrimrary) {
      calculatorView.alpha = 1;
      dialerView.alpha = 0;
    } else {
      calculatorView.alpha = 0;
      dialerView.alpha = 1;
    }


    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
    gestureRecognizer.minimumPressDuration = 0.5;
    [gestureRecognizer addTarget:self action:@selector(longPressedFired:)];
    [baseVC.view addGestureRecognizer:gestureRecognizer];

  }

}

%new
-(void)longPressedFired:(UILongPressGestureRecognizer*)sender {

  if (sender.state == UIGestureRecognizerStateChanged) {
    [self showAlertWithSettings];
  }

}

%new
-(void)showAlertWithSettings {

  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Digitnetic" message:@"" preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *keypadAction = [UIAlertAction actionWithTitle:@"Keypad" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [self showKeypad];
  }];

  UIAlertAction *calculatorAction = [UIAlertAction actionWithTitle:@"Calculator" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [self showCalculator];
  }];

  UIAlertAction *hideAction = [UIAlertAction actionWithTitle:@"Hide Digitnetic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [self hideDigitnetic];
  }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

  }];


  [alertController addAction:keypadAction];
  [alertController addAction:calculatorAction];
  [alertController addAction:hideAction];
  [alertController addAction:cancelAction];
  [baseVC presentViewController:alertController animated:YES completion:nil];
}

%new
-(void)showKeypad {

  dialerView.alpha = 1;
  calculatorView.alpha = 0;

}


%new
-(void)showCalculator {

  dialerView.alpha = 0;
  calculatorView.alpha = 1;

}


%new
-(void)showDigitnetic {

  [UIView animateWithDuration:0.2 animations:^ {
    digitneticFloatingView.alpha = 1;
  }];
}


%new
-(void)hideDigitnetic {

  [UIView animateWithDuration:0.2 animations:^ {
    digitneticFloatingView.alpha = 0;
  }];
}

%end
%end 


static 	NSBundle *iconPath = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/DigitneticPrefs.bundle/Assets/Cell/"];

@implementation ShowDigitnetic

-(void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)digitnetic1 {

    [UIView animateWithDuration:0.2 animations:^ {
    digitneticFloatingView.alpha = 1;
  }];
	[digitnetic1 setHandled:YES];

}


+(void)load {

	[[LAActivator sharedInstance] registerListener:[self new] forName:@"Toggle Show Digitnetic"];

}


- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
	return [NSArray arrayWithObjects:@"springboard", @"lockscreen", @"application", nil];
}


- (UIImage *)activator:(LAActivator *)activator requiresSmallIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale{
	return [UIImage imageNamed:@"prefs-icon" inBundle:iconPath compatibleWithTraitCollection:nil];

}


@end


@implementation HideDigitnetic

-(void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)digitnetic2 {

    [UIView animateWithDuration:0.2 animations:^ {
    digitneticFloatingView.alpha = 0;
  }];
	[digitnetic2 setHandled:YES];

}


+(void)load {

	[[LAActivator sharedInstance] registerListener:[self new] forName:@"Toggle Hide Digitnetic"];

}


- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
	return [NSArray arrayWithObjects:@"springboard", @"lockscreen", @"application", nil];
}


- (UIImage *)activator:(LAActivator *)activator requiresSmallIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale{
	return [UIImage imageNamed:@"prefs-icon" inBundle:iconPath compatibleWithTraitCollection:nil];

}


@end


void SettingsChanged() {

  toggleDigitnetic = [[TDTweakManager sharedInstance] boolForKey:@"toggleDigitnetic" defaultValue:NO ID:BID];
  toggleCalculatorAsPrimrary = [[TDTweakManager sharedInstance] boolForKey:@"toggleCalculatorAsPrimrary" defaultValue:NO ID:BID];
  cornerRadius = [[TDTweakManager sharedInstance] floatForKey:@"cornerRadius" defaultValue:15 ID:BID];

}


%ctor {

    SettingsChanged();

      if (toggleDigitnetic) {
        %init(Digitnetic);
      }
}
