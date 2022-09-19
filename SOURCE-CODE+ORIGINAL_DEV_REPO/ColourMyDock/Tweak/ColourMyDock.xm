#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Headers.h"

static NSString *BID = @"com.TitanD3v.ColourMyDockPrefs";
static BOOL toggleColourMyDock;

SBFloatingDockPlatterView *floatingDockView;
SBDockView *stockDockView;
UIView *dockView;
UIImageView *backgroundImage;
NSInteger colourPickerIndex = 0;
NSInteger dockGesture;
CGFloat dockBorderWidth;


%group DockHooks
%hook SBDockView

- (void)traitCollectionDidChange:(UITraitCollection *)old {
    %orig(old);
    [self performSelector:@selector(removeBlurView) withObject:nil afterDelay:0.0];
}


%new 
-(void)removeBlurView {

  UIView *backgroundView = [self valueForKey:@"backgroundView"];
  if([backgroundView respondsToSelector:@selector(_materialLayer)]) {
    ((MTMaterialView *)backgroundView).weighting = 0;
  }
  if([backgroundView respondsToSelector:@selector(blurView)]) {
    ((SBWallpaperEffectView *)backgroundView).blurView.hidden = YES;
  }

}


-(id)initWithDockListView:(id)arg1 forSnapshot:(BOOL)arg2 {
    
  if (dockGesture == 0) {  
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
  tapGesture.numberOfTapsRequired = 2;
  [self addGestureRecognizer:tapGesture];
  } else if (dockGesture == 1) {
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
  tapGesture.numberOfTapsRequired = 3;
  [self addGestureRecognizer:tapGesture]; 
  } else if (dockGesture == 2) {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
  } else if (dockGesture == 3) {
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGestureFired)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
  }

  return stockDockView = %orig;
}


-(void)didMoveToWindow {
  %orig;

  if(!dockView) {
    UIView *backgroundView = [self valueForKey:@"backgroundView"];

    dockView = [[UIView alloc] init];
    dockView.clipsToBounds = true;
    NSData *decodedData = [[TDTweakManager sharedInstance] objectForKey:@"dockBackgroundColour" ID:BID];
    UIColor *dockBGColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    NSData *decodedData2 = [[TDTweakManager sharedInstance] objectForKey:@"dockBorderColour" ID:BID];
    UIColor *dockBorderColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData2];

    if (decodedData) {
      dockView.backgroundColor = dockBGColour;
    } else {
      dockView.backgroundColor = UIColor.whiteColor;
    }

    dockView.layer.borderWidth = dockBorderWidth;

    if (decodedData2) {
    
    dockView.layer.borderColor = dockBorderColour.CGColor;
    } else {
     UIColor *defaultColour = UIColor.clearColor;
     NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:defaultColour];
     [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBorderColour" ID:BID];
    dockView.layer.borderColor = UIColor.clearColor.CGColor;
    }

    [backgroundView addSubview:dockView];

    NSData *dockBackgroundImage = [[TDTweakManager sharedInstance] objectForKey:@"dockBackgroundImage" ID:BID];
    backgroundImage = [[UIImageView alloc] init];
    if (dockBackgroundImage != nil) {
    backgroundImage.image = [UIImage imageWithData:dockBackgroundImage];
    }
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [dockView addSubview:backgroundImage];



  }

}


-(void)layoutSubviews {
  %orig;

  UIView *backgroundView = [self valueForKey:@"backgroundView"];
  if([backgroundView respondsToSelector:@selector(_materialLayer)]) {
    ((MTMaterialView *)backgroundView).weighting = 0;
    dockView.layer.cornerRadius = ((MTMaterialView *)backgroundView).materialLayer.cornerRadius;
  }
  if([backgroundView respondsToSelector:@selector(blurView)]) {
    ((SBWallpaperEffectView *)backgroundView).blurView.hidden = YES;
  }

  dockView.frame = backgroundView.bounds;
  backgroundImage.frame = dockView.bounds;

}


%new
-(void)tapGestureFired {


UIAlertController *settingsAlert = [UIAlertController alertControllerWithTitle:@"Dock Settings" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

UIAlertAction *backgroundAction = [UIAlertAction actionWithTitle:@"Background Colour" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

backgroundImage.image = nil;
NSString *prefPath = @"/var/mobile/Library/Preferences/com.TitanD3v.ColourMyDockPrefs.plist";
NSMutableDictionary *settings = [NSMutableDictionary dictionary];
[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
[settings removeObjectForKey:@"dockBackgroundImage"];
[settings writeToFile:prefPath atomically:YES];

colourPickerIndex = 0;
[self presentColourPickerVC];
}];

UIAlertAction *borderAction = [UIAlertAction actionWithTitle:@"Border Colour" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
colourPickerIndex = 1;
[self presentColourPickerVC];
}];

UIAlertAction *imageAction = [UIAlertAction actionWithTitle:@"Background Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
[self presentImagePickerVC];
}];

UIAlertAction *resetBackgroundAction = [UIAlertAction actionWithTitle:@"Reset Background Colour" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

  UIColor *resetColour = UIColor.whiteColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:resetColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBackgroundColour" ID:BID];
  dockView.backgroundColor = resetColour;

}];

UIAlertAction *resetBorderAction = [UIAlertAction actionWithTitle:@"Reset Border Colour" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

  UIColor *resetColour = UIColor.clearColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:resetColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBorderColour" ID:BID];
  dockView.layer.borderColor = resetColour.CGColor;

}];

UIAlertAction *resetImageAction = [UIAlertAction actionWithTitle:@"Reset Background Image" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
 
backgroundImage.image = nil;
NSString *prefPath = @"/var/mobile/Library/Preferences/com.TitanD3v.ColourMyDockPrefs.plist";
NSMutableDictionary *settings = [NSMutableDictionary dictionary];
[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
[settings removeObjectForKey:@"dockBackgroundImage"];
[settings writeToFile:prefPath atomically:YES];

}];

UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {

}];

[backgroundAction setValue:[[UIImage systemImageNamed:@"drop.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[borderAction setValue:[[UIImage systemImageNamed:@"drop.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[imageAction setValue:[[UIImage systemImageNamed:@"photo.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[resetBackgroundAction setValue:[[UIImage systemImageNamed:@"arrow.uturn.backward.circle.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[resetBorderAction setValue:[[UIImage systemImageNamed:@"arrow.uturn.backward.circle.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[resetImageAction setValue:[[UIImage systemImageNamed:@"arrow.uturn.backward.circle.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];


[settingsAlert addAction:backgroundAction];
[settingsAlert addAction:borderAction];
[settingsAlert addAction:imageAction];
[settingsAlert addAction:resetBackgroundAction];
[settingsAlert addAction:resetBorderAction];
[settingsAlert addAction:resetImageAction];
[settingsAlert addAction:cancelAction];
[[%c(SBIconController) sharedInstance] presentViewController:settingsAlert animated:YES completion:nil];

}


%new 
-(void)presentColourPickerVC {

    UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
    colourPickerVC.delegate = self;
    if (colourPickerIndex == 0) {
    colourPickerVC.selectedColor = dockView.backgroundColor;
    } else if (colourPickerIndex == 1) {
    NSData *decodedData = [[TDTweakManager sharedInstance] objectForKey:@"dockBorderColour" ID:BID];
    UIColor *dockBorderColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
     colourPickerVC.selectedColor = dockBorderColour;
    }
    [[%c(SBIconController) sharedInstance] presentViewController:colourPickerVC animated:YES completion:nil];
}


%new
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{

  UIColor *dockSelectedColour = viewController.selectedColor;

if (colourPickerIndex == 0) {
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockSelectedColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBackgroundColour" ID:BID];
  dockView.backgroundColor = dockSelectedColour;
} else if (colourPickerIndex == 1) {
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockSelectedColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBorderColour" ID:BID];
  dockView.layer.borderColor = dockSelectedColour.CGColor;
}

  
}


%new
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{

  UIColor *dockSelectedColour = viewController.selectedColor;

if (colourPickerIndex == 0) {
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockSelectedColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBackgroundColour" ID:BID];
  dockView.backgroundColor = dockSelectedColour;
} else if (colourPickerIndex == 1) {
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockSelectedColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBorderColour" ID:BID];
  dockView.layer.borderColor = dockSelectedColour.CGColor;
}

}


%new 
-(void)presentImagePickerVC {

  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  picker.allowsEditing = YES;
  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

  [[%c(SBIconController) sharedInstance] presentViewController:picker animated:YES completion:nil];

}


%new 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

  UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
  NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
  [[TDTweakManager sharedInstance] setObject:imageData forKey:@"dockBackgroundImage" ID:BID];
  backgroundImage.image = chosenImage;
  [picker dismissViewControllerAnimated:YES completion:nil];
}

%end


%hook SBFloatingDockPlatterView

- (void)traitCollectionDidChange:(UITraitCollection *)old {
    %orig(old);
    [self performSelector:@selector(removeBlurView) withObject:nil afterDelay:0.0];
}


%new 
-(void)removeBlurView {

  UIView *backgroundView = [self valueForKey:@"backgroundView"];
  if([backgroundView respondsToSelector:@selector(_materialLayer)]) {
    ((MTMaterialView *)backgroundView).weighting = 0;
  }
  if([backgroundView respondsToSelector:@selector(blurView)]) {
    ((SBWallpaperEffectView *)backgroundView).blurView.hidden = YES;
  }

}


-(id)initWithFrame:(CGRect)arg1 {

  if (dockGesture == 0) {  
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
  tapGesture.numberOfTapsRequired = 2;
  [self addGestureRecognizer:tapGesture];
  } else if (dockGesture == 1) {
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
  tapGesture.numberOfTapsRequired = 3;
  [self addGestureRecognizer:tapGesture]; 
  } else if (dockGesture == 2) {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
  } else if (dockGesture == 3) {
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGestureFired)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
  }

  return floatingDockView = %orig;
}


-(void)layoutSubviews {
  %orig;

  _UIBackdropView *backgroundView = [self valueForKey:@"_backgroundView"];
  if(![[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){13, 0, 0}]) {
    backgroundView.backdropEffectView.hidden = YES;
  }

  if(!dockView) {

    dockView = [[UIView alloc] init];
    dockView.clipsToBounds = true;
    NSData *decodedData = [[TDTweakManager sharedInstance] objectForKey:@"dockBackgroundColour" ID:BID];
    UIColor *dockBGColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    NSData *decodedData2 = [[TDTweakManager sharedInstance] objectForKey:@"dockBorderColour" ID:BID];
    UIColor *dockBorderColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData2];

    if (decodedData) {
      dockView.backgroundColor = dockBGColour;
    } else {
      dockView.backgroundColor = UIColor.whiteColor;
    }

    dockView.layer.borderWidth = dockBorderWidth;

    if (decodedData2) {
    
    dockView.layer.borderColor = dockBorderColour.CGColor;
    } else {
     UIColor *defaultColour = UIColor.clearColor;
     NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:defaultColour];
     [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBorderColour" ID:BID];
    dockView.layer.borderColor = UIColor.clearColor.CGColor;
    }

    [backgroundView addSubview:dockView];

    NSData *dockBackgroundImage = [[TDTweakManager sharedInstance] objectForKey:@"dockBackgroundImage" ID:BID];
    backgroundImage = [[UIImageView alloc] init];
    if (dockBackgroundImage != nil) {
    backgroundImage.image = [UIImage imageWithData:dockBackgroundImage];
    }
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [dockView addSubview:backgroundImage];

  }

  dockView.frame = backgroundView.bounds;
  backgroundImage.frame = dockView.bounds;

}


%new
-(void)tapGestureFired {


UIAlertController *settingsAlert = [UIAlertController alertControllerWithTitle:@"Dock Settings" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

UIAlertAction *backgroundAction = [UIAlertAction actionWithTitle:@"Background Colour" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

backgroundImage.image = nil;
NSString *prefPath = @"/var/mobile/Library/Preferences/com.TitanD3v.ColourMyDockPrefs.plist";
NSMutableDictionary *settings = [NSMutableDictionary dictionary];
[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
[settings removeObjectForKey:@"dockBackgroundImage"];
[settings writeToFile:prefPath atomically:YES];

colourPickerIndex = 0;
[self presentColourPickerVC];
}];

UIAlertAction *borderAction = [UIAlertAction actionWithTitle:@"Border Colour" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
colourPickerIndex = 1;
[self presentColourPickerVC];
}];

UIAlertAction *imageAction = [UIAlertAction actionWithTitle:@"Background Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
[self presentImagePickerVC];
}];

UIAlertAction *resetBackgroundAction = [UIAlertAction actionWithTitle:@"Reset Background Colour" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

  UIColor *resetColour = UIColor.whiteColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:resetColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBackgroundColour" ID:BID];
  dockView.backgroundColor = resetColour;

}];

UIAlertAction *resetBorderAction = [UIAlertAction actionWithTitle:@"Reset Border Colour" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

  UIColor *resetColour = UIColor.clearColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:resetColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBorderColour" ID:BID];
  dockView.layer.borderColor = resetColour.CGColor;

}];

UIAlertAction *resetImageAction = [UIAlertAction actionWithTitle:@"Reset Background Image" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
 
backgroundImage.image = nil;
NSString *prefPath = @"/var/mobile/Library/Preferences/com.TitanD3v.ColourMyDockPrefs.plist";
NSMutableDictionary *settings = [NSMutableDictionary dictionary];
[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefPath]];
[settings removeObjectForKey:@"dockBackgroundImage"];
[settings writeToFile:prefPath atomically:YES];

}];

UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {

}];

[backgroundAction setValue:[[UIImage systemImageNamed:@"drop.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[borderAction setValue:[[UIImage systemImageNamed:@"drop.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[imageAction setValue:[[UIImage systemImageNamed:@"photo.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[resetBackgroundAction setValue:[[UIImage systemImageNamed:@"arrow.uturn.backward.circle.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[resetBorderAction setValue:[[UIImage systemImageNamed:@"arrow.uturn.backward.circle.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];
[resetImageAction setValue:[[UIImage systemImageNamed:@"arrow.uturn.backward.circle.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forKey:@"image"];


[settingsAlert addAction:backgroundAction];
[settingsAlert addAction:borderAction];
[settingsAlert addAction:imageAction];
[settingsAlert addAction:resetBackgroundAction];
[settingsAlert addAction:resetBorderAction];
[settingsAlert addAction:resetImageAction];
[settingsAlert addAction:cancelAction];
[[%c(SBIconController) sharedInstance] presentViewController:settingsAlert animated:YES completion:nil];

}


%new 
-(void)presentColourPickerVC {

    UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
    colourPickerVC.delegate = self;
    if (colourPickerIndex == 0) {
    colourPickerVC.selectedColor = dockView.backgroundColor;
    } else if (colourPickerIndex == 1) {
    NSData *decodedData = [[TDTweakManager sharedInstance] objectForKey:@"dockBorderColour" ID:BID];
    UIColor *dockBorderColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
     colourPickerVC.selectedColor = dockBorderColour;
    }
    [[%c(SBIconController) sharedInstance] presentViewController:colourPickerVC animated:YES completion:nil];
}


%new
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{

  UIColor *dockSelectedColour = viewController.selectedColor;

if (colourPickerIndex == 0) {
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockSelectedColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBackgroundColour" ID:BID];
  dockView.backgroundColor = dockSelectedColour;
} else if (colourPickerIndex == 1) {
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockSelectedColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBorderColour" ID:BID];
  dockView.layer.borderColor = dockSelectedColour.CGColor;
}

  
}


%new
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{

  UIColor *dockSelectedColour = viewController.selectedColor;

if (colourPickerIndex == 0) {
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockSelectedColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBackgroundColour" ID:BID];
  dockView.backgroundColor = dockSelectedColour;
} else if (colourPickerIndex == 1) {
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockSelectedColour];
  [[TDTweakManager sharedInstance] setObject:encodedData forKey:@"dockBorderColour" ID:BID];
  dockView.layer.borderColor = dockSelectedColour.CGColor;
}

}


%new 
-(void)presentImagePickerVC {

  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  picker.allowsEditing = YES;
  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

  [[%c(SBIconController) sharedInstance] presentViewController:picker animated:YES completion:nil];

}


%new 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

  UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
  NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
  [[TDTweakManager sharedInstance] setObject:imageData forKey:@"dockBackgroundImage" ID:BID];
  backgroundImage.image = chosenImage;
  [picker dismissViewControllerAnimated:YES completion:nil];
}

%end
%end 



void SettingsChanged() {

  toggleColourMyDock = [[TDTweakManager sharedInstance] boolForKey:@"toggleColourMyDock" defaultValue:NO ID:BID];
  dockBorderWidth = [[TDTweakManager sharedInstance] floatForKey:@"dockBorderWidth" defaultValue:1 ID:BID];
  dockGesture = [[TDTweakManager sharedInstance] intForKey:@"dockGesture" defaultValue:0 ID:BID];

}

%ctor {

  NSString * path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
  if ([path containsString:@"/Application"] || [path containsString:@"SpringBoard.app"]) {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.ColourMyDockPrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    SettingsChanged();

    if (toggleColourMyDock) {
      %init(DockHooks);
    }

  }
}
