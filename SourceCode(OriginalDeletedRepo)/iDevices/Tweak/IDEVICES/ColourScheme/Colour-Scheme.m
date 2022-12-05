#import "Colour-Scheme.h"

@implementation UIColor (Cloudy)

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


+ (UIColor *)grabberColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"grabberColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.tertiarySystemFillColor;
    }

    return customColour;
}


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


+ (UIColor *)secondaryFontColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"secondaryFontColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.secondaryLabelColor;
    }

    return customColour;
}


+ (UIColor *)titleColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"titleColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.labelColor;
    }

    return customColour;
}


+ (UIColor *)subtitleColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"subtitleColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.tertiaryLabelColor;
    }

    return customColour;
}


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


+ (UIColor *)navBarButtonColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"navBarButtonColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.secondarySystemBackgroundColor;
    }

    return customColour;
}


+ (UIColor *)batteryRingColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"batteryRingColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.tertiarySystemFillColor;
    }

    return customColour;
}


+ (UIColor *)batteryLowColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"batteryLowColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemRedColor;
    }

    return customColour;
}


+ (UIColor *)batteryNormalColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"batteryNormalColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemGreenColor;
    }

    return customColour;
}


+ (UIColor *)redColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"redColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemRedColor;
    }

    return customColour;
}


+ (UIColor *)orangeColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"orangeColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemOrangeColor;
    }

    return customColour;
}


+ (UIColor *)yellowColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"yellowColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemYellowColor;
    }

    return customColour;
}


+ (UIColor *)greenColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"greenColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemGreenColor;
    }

    return customColour;
}


+ (UIColor *)tealColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"tealColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemTealColor;
    }

    return customColour;
}


+ (UIColor *)indigoColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"indigoColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemIndigoColor;
    }

    return customColour;
}


+ (UIColor *)pinkColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"pinkColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemPinkColor;
    }

    return customColour;
}


+ (UIColor *)totalRamColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"totalRamColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemPinkColor;
    }

    return customColour;
}


+ (UIColor *)freeRamColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"freeRamColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemGreenColor;
    }

    return customColour;
}


+ (UIColor *)usedRamColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"usedRamColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemTealColor;
    }

    return customColour;
}


+ (UIColor *)coverIconColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"coverIconColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.whiteColor;
    }

    return customColour;
}


+ (UIColor *)coverTitleColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"coverTitleColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.whiteColor;
    }

    return customColour;
}


+ (UIColor *)backupStartButtonColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"backupStartButtonColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemTealColor;
    }

    return customColour;
}


+ (UIColor *)backupCancelButtonColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"backupCancelButtonColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemRedColor;
    }

    return customColour;
}


+ (UIColor *)backupProgressColour {
    static UIColor *customColour;

    loadPrefs();

    if (toggleCustomColour) {
        customColour = [[TDTweakManager sharedInstance] colourForKey:@"backupProgressColour" defaultValue:@"FFFFFF" ID:BID];
    } else {
        customColour = UIColor.systemTealColor;
    }

    return customColour;
}


@end

