#import <TitanD3vUniversal/TitanD3vUniversal.h>

@interface BSUIScrollView : UIScrollView
@end 

%group Flowing
%hook BSUIScrollView
-(void)layoutSubviews {
  %orig;
  self.pagingEnabled = NO;
}
%end 
%end 

%ctor {

  NSString * path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
  if ([path containsString:@"/Application"] || [path containsString:@"SpringBoard.app"]) {
  %init(Flowing);
  }
}
