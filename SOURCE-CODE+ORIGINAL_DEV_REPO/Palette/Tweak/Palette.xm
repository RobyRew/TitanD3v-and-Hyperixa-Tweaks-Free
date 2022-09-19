#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "AddCollectionViewController.h"

static NSString *BID = @"com.TitanD3v.PalettePrefs";
static BOOL togglePalette;
NSInteger paletteGesture;

@interface _UIStatusBar : UIView <UIColorPickerViewControllerDelegate>
- (NSString *)hexStringFromColor:(UIColor *)color;
-(void)showActionMenuWithColour:(UIColor *)selectedColour;
-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
-(void)showAddCollectionWithHexCode:(NSString *)colourString;
@end 

UIColorPickerViewController *colourPickerVC;
UIColor *tempColour;


%group Palette
%hook _UIStatusBar

-(void)willMoveToSuperview:(UIView *)newViews {
  %orig(newViews);

  if (paletteGesture == 0) {  
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentColourPicker)];
  tapGesture.numberOfTapsRequired = 2;
  [self addGestureRecognizer:tapGesture];
  } else if (paletteGesture == 1) {
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentColourPicker)];
  tapGesture.numberOfTapsRequired = 3;
  [self addGestureRecognizer:tapGesture]; 
  } else if (paletteGesture == 2) {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(presentColourPicker)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
  } else if (paletteGesture == 3) {
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(presentColourPicker)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
  }

}


%new 
-(void)presentColourPicker {

    colourPickerVC = [[UIColorPickerViewController alloc] init];
    colourPickerVC.delegate = self;
    colourPickerVC.modalInPresentation = YES;
    colourPickerVC.selectedColor = [UIColor colorWithRed: 0.43 green: 0.83 blue: 0.98 alpha: 1.00];
    UIViewController *controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [controller presentViewController:colourPickerVC animated:YES completion:nil];

}


%new 
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{   
    tempColour = viewController.selectedColor;
    [self showActionMenuWithColour:tempColour];
}


%new 
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{   
    tempColour = viewController.selectedColor;
    NSLog(@"Colour picker selected %@", [self hexStringFromColor:tempColour]);
    
}


%new 
- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
}


%new 
-(void)showActionMenuWithColour:(UIColor *)selectedColour {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    const CGFloat *_components = CGColorGetComponents(selectedColour.CGColor);
    CGFloat red = _components[0];
    CGFloat green = _components[1];
    CGFloat blue = _components[2];
    
    NSString *redString = [NSString stringWithFormat:@"%d", (int) (red * 255.0)];
    NSString *greenString = [NSString stringWithFormat:@"%d", (int) (green * 255)];
    NSString *blueString = [NSString stringWithFormat:@"%d", (int) (blue * 255)];
    
    
    UIAlertController *view = [UIAlertController alertControllerWithTitle:@"" message:@"Select which colour code you want to copy to clipboard or add to your collection." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add to Collection" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSString *colourString = [NSString stringWithFormat:@"%@",[self hexStringFromColor:selectedColour]];
        [self showAddCollectionWithHexCode:colourString];
        
    }];
    
    
    UIAlertAction *hexAction = [UIAlertAction actionWithTitle:@"Copy HEX Values" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"#%@",[self hexStringFromColor:selectedColour]];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for HEX was saved to your clipboard"];
    }];
    
    
    UIAlertAction *rgbAction = [UIAlertAction actionWithTitle:@"Copy RGB Values" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"rgb(%@, %@, %@)",redString, greenString, blueString];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for RGB was saved to your clipboard"];
    }];
    
    
    UIAlertAction *swiftAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (Swift)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"UIColor(red: %@.0/255.0, green: %@.0/255.0, blue: %@/255.0, alpha: 1.0)",redString, greenString, blueString];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for Swift was saved to your clipboard"];
    }];
    
    
    UIAlertAction *swiftuiAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (SwiftUI)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"Color(red: %@/255, green: %@/255, blue: %@/255)", redString, greenString, blueString];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for SwiftUI was saved to your clipboard"];
    }];
    
    
    UIAlertAction *objcAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (Objective-C)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"[UIColor colorWithRed:%@/255.0 green: %@/255.0 blue: %@/255.0 alpha: 1.00];", redString, greenString, blueString];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for Objective-C was saved to your clipboard"];
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [view dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [view addAction:addAction];
    [view addAction:hexAction];
    [view addAction:rgbAction];
    [view addAction:swiftAction];
    [view addAction:swiftuiAction];
    [view addAction:objcAction];
    [view addAction:cancelAction];
    view.view.tintColor = [UIColor colorWithRed: 0.43 green: 0.83 blue: 0.98 alpha: 1.00];
    UIViewController *controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [controller presentViewController:view animated:YES completion:nil];
    
    
}


%new 
-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:defaultAction];
    alert.view.tintColor = [UIColor colorWithRed: 0.43 green: 0.83 blue: 0.98 alpha: 1.00];
    UIViewController *controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [controller presentViewController:alert animated:YES completion:nil];
    
}


%new 
-(void)showAddCollectionWithHexCode:(NSString *)colourString {
    
    AddCollectionViewController *collectionVC = [[AddCollectionViewController alloc] init];
    collectionVC.modalInPresentation = YES;
    collectionVC.hexCode = colourString;
    UIViewController *controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [controller presentViewController:collectionVC animated:YES completion:nil];
    
}

%end 
%end 




void SettingsChanged() {

  togglePalette = [[TDTweakManager sharedInstance] boolForKey:@"togglePalette" defaultValue:YES ID:BID];
  paletteGesture = [[TDTweakManager sharedInstance] intForKey:@"paletteGesture" defaultValue:0 ID:BID];

}

%ctor {

  NSString * path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
  if ([path containsString:@"/Application"] || [path containsString:@"SpringBoard.app"]) {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.PalettePrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    SettingsChanged();

    if (togglePalette) {
      %init(Palette);
    }

  }
}
