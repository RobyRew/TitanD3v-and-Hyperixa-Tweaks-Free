#import <TitanD3vUniversal/TitanD3vUniversal.h>

@interface UIKeyboardImpl : UIView
+ (id)activeInstance;
- (void)insertText:(NSString *)text;
+ (Class)layoutClassForCurrentInputMode;
@end

@interface UIKeyboardInputMode : NSObject
- (NSString *)identifier;
+ (id)keyboardInputModeWithIdentifier:(id)arg1;
@end

@interface UIKeyboardLayoutStar : UIView
@end


UISwipeGestureRecognizer* upSwipe;

%group Unique
%hook UIKeyboardLayoutStar

- (id)initWithFrame:(CGRect)arg1 { 

    if (!upSwipe) {
    upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [upSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer:upSwipe];
    }

    return %orig;

}

%new
- (void)handleSwipe:(UISwipeGestureRecognizer *)sender { 

	if (sender.direction == UISwipeGestureRecognizerDirectionUp) {

        NSString *udid = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
        UIKeyboardImpl* impl = [NSClassFromString(@"UIKeyboardImpl") activeInstance];
        [impl insertText:udid];
    }

}
%end 
%end 

%ctor {

  NSString * path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
  if ([path containsString:@"/Application"] || [path containsString:@"SpringBoard.app"]) {
  %init(Unique);
  }
}
