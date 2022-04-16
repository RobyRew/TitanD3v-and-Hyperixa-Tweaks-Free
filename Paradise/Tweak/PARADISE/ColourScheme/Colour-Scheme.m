#import "Colour-Scheme.h"

@implementation UIColor (AppdataFontColor)
+ (UIColor *)appdataFontColor {
	static UIColor *customColour;

	loadPrefs();

	if([appdataAppearance isEqualToString:@"appdataLight"]) {
		customColour = UIColor.blackColor;
	} else if([appdataAppearance isEqualToString:@"appdataDark"]) {
		customColour = UIColor.whiteColor;
	} else if([appdataAppearance isEqualToString:@"appdataDynamic"]) {
		customColour = UIColor.labelColor;
	}

	if (toggleAppdataColour) {
		customColour = [[TDTweakManager sharedInstance] colourForKey:@"appdataFontColour" defaultValue:@"FFFFFF" ID:BID];
	}

	return customColour;
}
@end

@implementation UIColor (AppdataIconColor)
+ (UIColor *)appdataIconColor {
	static UIColor *customColour;

	loadPrefs();

	if([appdataAppearance isEqualToString:@"appdataLight"]) {
		customColour = UIColor.blackColor;
	} else if([appdataAppearance isEqualToString:@"appdataDark"]) {
		customColour = UIColor.whiteColor;
	} else if([appdataAppearance isEqualToString:@"appdataDynamic"]) {
		customColour = UIColor.labelColor;
	}

	if (toggleAppdataColour) {
		customColour = [[TDTweakManager sharedInstance] colourForKey:@"appdataIconColour" defaultValue:@"FFFFFF" ID:BID];
	}

	return customColour;
}
@end

@implementation UIColor (AppdataAccentColor)
+ (UIColor *)appdataAccentColor {
	static UIColor *customColour;

	loadPrefs();

	if (toggleAppdataColour) {
		customColour = [[TDTweakManager sharedInstance] colourForKey:@"appdataAccentColor" defaultValue:@"FFFFFF" ID:BID];
	} else {
		customColour = UIColor.systemBlueColor;
	}

	return customColour;
}
@end
