#import "FloatingView.h"
#import <objc/runtime.h>
#define PADDING     5
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

static void *DragEnableKey = &DragEnableKey;
static void *AdsorbEnableKey = &AdsorbEnableKey;


@implementation FloatingView

-(void)setDragEnable:(BOOL)dragEnable
{
  objc_setAssociatedObject(self, DragEnableKey,@(dragEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isDragEnable
{
  return [objc_getAssociatedObject(self, DragEnableKey) boolValue];
}

-(void)setAdsorbEnable:(BOOL)adsorbEnable
{
  objc_setAssociatedObject(self, AdsorbEnableKey,@(adsorbEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isAdsorbEnable
{
  return [objc_getAssociatedObject(self, AdsorbEnableKey) boolValue];
}

CGPoint beginPoint;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  //self.highlighted = YES;
  if (![objc_getAssociatedObject(self, DragEnableKey) boolValue]) {
    return;
  }

  UITouch *touch = [touches anyObject];

  beginPoint = [touch locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  //self.highlighted = NO;
  if (![objc_getAssociatedObject(self, DragEnableKey) boolValue]) {
    return;
  }

  UITouch *touch = [touches anyObject];

  CGPoint nowPoint = [touch locationInView:self];

  float offsetX = nowPoint.x - beginPoint.x;
  float offsetY = nowPoint.y - beginPoint.y;

  CGFloat btnCenterX = self.center.x + offsetX;
  CGFloat btnCenterY = self.center.y + offsetY;

  if (btnCenterX < 0) {
    btnCenterX = 0;
  }else if(btnCenterX > KScreenWidth){
    btnCenterX = KScreenWidth;
  }

  if (btnCenterY < 0) {
    btnCenterY = 0;
  }else if (btnCenterY > KScreenHeight){
    btnCenterY = KScreenHeight;
  }

  self.center = CGPointMake(btnCenterX, btnCenterY);

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

  if (self.superview && [objc_getAssociatedObject(self,AdsorbEnableKey) boolValue] ) {
    float marginLeft = self.frame.origin.x;
    float marginRight = self.superview.frame.size.width - self.frame.origin.x - self.frame.size.width;
    float marginTop = self.frame.origin.y;
    float marginBottom = self.superview.frame.size.height - self.frame.origin.y - self.frame.size.height;
    [UIView animateWithDuration:0.125 animations:^(void){
      if (marginTop<60) {
        self.frame = CGRectMake(marginLeft<marginRight?marginLeft<PADDING?PADDING:self.frame.origin.x:marginRight<PADDING?self.superview.frame.size.width -self.frame.size.width-PADDING:self.frame.origin.x,
          PADDING,
          self.frame.size.width,
          self.frame.size.height);
        }
        else if (marginBottom<60) {
          self.frame = CGRectMake(marginLeft<marginRight?marginLeft<PADDING?PADDING:self.frame.origin.x:marginRight<PADDING?self.superview.frame.size.width -self.frame.size.width-PADDING:self.frame.origin.x,
            self.superview.frame.size.height - self.frame.size.height-PADDING,
            self.frame.size.width,
            self.frame.size.height);

          }
          else {
            self.frame = CGRectMake(marginLeft<marginRight?PADDING:self.superview.frame.size.width - self.frame.size.width-PADDING,
              self.frame.origin.y,
              self.frame.size.width,
              self.frame.size.height);
            }
          }];

        }
      }

      @end
