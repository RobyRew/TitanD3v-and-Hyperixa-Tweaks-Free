#import "Colour-Scheme.h"

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Background color
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


@implementation UIColor (BackgroundColor)
+ (UIColor *)surgeBackgroundColor {
	static UIColor* backgroundColor;

loadPrefs();

	backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"backgroundChroma" defaultValue:@"FFFFFF" ID:BID];

	return backgroundColor;
}
@end


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Font color
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


@implementation UIColor (FontColor)
+ (UIColor *)surgeFontColor {
	static UIColor* backgroundColor;

	loadPrefs();

	if([surgeInterfaceAppearance isEqualToString:@"surgeLight"]) {

		backgroundColor = UIColor.blackColor;

	} else if([surgeInterfaceAppearance isEqualToString:@"surgeDark"]) {

		backgroundColor = UIColor.whiteColor;
	}

	if (toggleColourScheme) {
		backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"fontChroma" defaultValue:@"FFFFFF" ID:BID];
	}

	return backgroundColor;
}
@end


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Icon color
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


@implementation UIColor (IconColor)
+ (UIColor *)surgeIconColor {
	static UIColor* backgroundColor;

	loadPrefs();

	backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"iconChroma" defaultValue:@"FFFFFF" ID:BID];

	return backgroundColor;
}
@end


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Disable color
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


@implementation UIColor (DisableColor)
+ (UIColor *)surgeDisableColor {
	static UIColor* backgroundColor;

	loadPrefs();

	backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"disableChroma" defaultValue:@"FFFFFF" ID:BID];

	return backgroundColor;
}
@end


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Enable color
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


@implementation UIColor (EnableColor)
+ (UIColor *)surgeEnableColor {
	static UIColor* backgroundColor;

	loadPrefs();

	backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"enableChroma" defaultValue:@"FFFFFF" ID:BID];

	return backgroundColor;
}
@end


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Body color
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


@implementation UIColor (BodyColor)
+ (UIColor *)surgeBodyColor {
	static UIColor* backgroundColor;

	loadPrefs();

	backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"bodyChroma" defaultValue:@"FFFFFF" ID:BID];

	return backgroundColor;
}
@end


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Pin color
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


@implementation UIColor (PinColor)
+ (UIColor *)surgePinColor {
	static UIColor* backgroundColor;

	loadPrefs();

	backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"pinChroma" defaultValue:@"FFFFFF" ID:BID];

	return backgroundColor;
}
@end


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Container color
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


@implementation UIColor (ContainerColor)
+ (UIColor *)surgeContainerColor {
	static UIColor* backgroundColor;

	loadPrefs();

	backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"containerChroma" defaultValue:@"FFFFFF" ID:BID];

	return backgroundColor;
}
@end

