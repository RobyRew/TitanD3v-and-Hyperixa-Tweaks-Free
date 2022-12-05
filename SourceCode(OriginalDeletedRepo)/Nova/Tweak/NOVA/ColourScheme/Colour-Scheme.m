#import "Colour-Scheme.h"

@implementation UIColor (BackgroundColour)
+ (UIColor *)backgroundColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"backgroundColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.systemBackgroundColor;
  }

  return customColour;
}
@end


@implementation UIColor (CellColour)
+ (UIColor *)cellColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"cellColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.secondarySystemBackgroundColor;
  }

  return customColour;
}
@end


@implementation UIColor (FontColour)
+ (UIColor *)fontColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"fontColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.labelColor;
  }

  return customColour;
}
@end


@implementation UIColor (AccentColour)
+ (UIColor *)accentColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"accentColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.systemBlueColor;
  }

  return customColour;
}
@end


@implementation UIColor (ClockColour)
+ (UIColor *)clockColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"clockColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.whiteColor;
  }

  return customColour;
}
@end


@implementation UIColor (CheckmarkColour)
+ (UIColor *)checkmarkColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"checkmarkColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.whiteColor;
  }

  return customColour;
}
@end


@implementation UIColor (ButtonColour)
+ (UIColor *)buttonColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"floatingButtonColour" defaultValue:@"FFFFFF" ID:BID];
  }

  return customColour;
}
@end


@implementation UIColor (IconColour)
+ (UIColor *)iconColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"floatingIconColour" defaultValue:@"FFFFFF" ID:BID];
  }

  return customColour;
}
@end


@implementation UIColor (BubbleFontColour)
+ (UIColor *)bubbleFontColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"bubbleFontColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.whiteColor;
  }

  return customColour;
}
@end


@implementation UIColor (BubbleColour)
+ (UIColor *)bubbleColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"bubbleColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.systemBlueColor;
  }

  return customColour;
}
@end


@implementation UIColor (RemainingFontColour)
+ (UIColor *)remainingFontColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"remainingFontColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.whiteColor;
  }

  return customColour;
}
@end


@implementation UIColor (SeparatorColour)
+ (UIColor *)separatorColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"separatorColour" defaultValue:@"FFFFFF" ID:BID];
  }

  return customColour;
}
@end


@implementation UIColor (RemainingBackgroundColour)
+ (UIColor *)remainingBackgroundColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"remainingBackgroundColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = [UIColor colorWithRed: 1.00 green: 0.58 blue: 0.00 alpha: 0.8];
  }

  return customColour;
}
@end


@implementation UIColor (SentBackgroundColour)
+ (UIColor *)sentBackgroundColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"remainingBackgroundColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = [UIColor colorWithRed: 0.20 green: 0.78 blue: 0.35 alpha: 0.8];
  }

  return customColour;
}
@end


@implementation UIColor (IconTintColour)
+ (UIColor *)iconTintColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"iconColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.labelColor;
  }

  return customColour;
}
@end


@implementation UIColor (RecipientBubbleFontColour)
+ (UIColor *)recipientBubbleFontColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"recipientBubbleFontColour" defaultValue:@"FFFFFF" ID:BID];
  }

  return customColour;
}
@end


@implementation UIColor (RecipientBubbleColour)
+ (UIColor *)recipientBubbleColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"recipientBubbleColour" defaultValue:@"FFFFFF" ID:BID];
  }

  return customColour;
}
@end


@implementation UIColor (PhotoButtonColour)
+ (UIColor *)photoButtonColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"photoButtonColour" defaultValue:@"FFFFFF" ID:BID];
  }

  return customColour;
}
@end


@implementation UIColor (ToolbarColour)
+ (UIColor *)toolbarColour {
  static UIColor *customColour;

  loadPrefs();

  if (toggleCustomColour) {
    customColour = [[TDTweakManager sharedInstance] colourForKey:@"toolbarColour" defaultValue:@"FFFFFF" ID:BID];
  } else {
    customColour = UIColor.systemBackgroundColor;
  }

  return customColour;
}
@end
