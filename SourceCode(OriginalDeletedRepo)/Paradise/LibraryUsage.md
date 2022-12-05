# Import header

This is all you need to import in each class header
```objc
#import <TitanD3vUniversal/TitanD3vUniversal.h> 
```
  
# Object for key, boolean, integer and float value and set default too (can use either TDTweakManager or TDPrefsManager as long as you have same bundle ID for prefs)
```objc
bool value = [[TDTweakManager sharedInstance] boolForKey:@"exampleBoolean" defaultValue:NO];
long long value = [[TDTweakManager sharedInstance] floatForKey:@"exampleFloat" defaultValue:20];
int value = [[TDTweakManager sharedInstance] intForKey:@"exampleInteger" defaultValue:1];
NSString *value = [[TDTweakManager sharedInstance] objectForKey:@"exampleString" defaultValue:@"Hello"];
```

# Object for key, boolean, integer and float value without default (can use either TDTweakManager or TDPrefsManager as long as you have same bundle ID for prefs)
```objc
bool value = [[TDTweakManager sharedInstance] boolForKey:@"exampleBoolean"];
long long value = [[TDTweakManager sharedInstance] floatForKey:@"exampleFloat"];
int value = [[TDTweakManager sharedInstance] intForKey:@"exampleInt"];
NSString *value = [[TDTweakManager sharedInstance] objectForKey:@"exampleString"];
```

# Set object, boolean, integer and float value (can use either TDTweakManager or TDPrefsManager as long as you have same bundle ID for prefs)
```objc
[[TDTweakManager sharedInstance] setBool:YES forKey:@"testKey"];
[[TDTweakManager sharedInstance] setFloat:10101010 forKey:@"testKeyFloat"];
[[TDTweakManager sharedInstance] setInt:10 forKey:@"testKeyInt"];
[[TDTweakManager sharedInstance] setObject:10 forKey:@"testKeyInt"];
```

# Set the background colour from HEX string
```objc
NSString *colourString = @"FA682C";
UIColor *exampleColour = colorFromHexString(colourString);
exampleView.backgroundColor = exampleColour;
```

# Set the background colour from the colour picker in prefs
```objc
exampleView.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"exampleColour" defaultValue:@"FA682C"];
```

# Set the font from font picker
```objc
NSData *data = [[TDTweakManager sharedInstance] objectForKey:@"exampleFont"];
UIFontDescriptor *descriptor = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIFontDescriptor class] fromData:data error:nil];
self.exampleLabel.font = [UIFont fontWithDescriptor:descriptor size:18];
```

# Set the date from date picker
```objc
NSDate *existingDate = [[TDTweakManager sharedInstance] objectForKey:@"exampleDate"];
NSDateFormatter *pickedDateFormat = [[NSDateFormatter alloc] init];
[pickedDateFormat setDateFormat:@"dd/MM/YYYY"];
NSString *pickedDateString = [pickedDateFormat stringFromDate:existingDate];
self.exampleLabel.text = pickedDateString;
```

# Get the weather information
```objc
[[TDWeather sharedInstance] refreshWeatherData];
NSDictionary *weatherData = [[TDWeather sharedInstance] weatherData];

NSString *temperature = [weatherData objectForKey:@"temperature"];
NSString *condition = [weatherData objectForKey:@"conditions"];
NSString *location = [weatherData objectForKey:@"location"];
NSDate *sunrise = [weatherData objectForKey:@"sunrise"];
NSDate *sunset = [weatherData objectForKey:@"sunset"];

NSLog(@"temp:%@, condition:%@, location:%@, sunrise%@, sunset%@", temperature, condition, location, sunrise, sunset);

UIImage *conditionsImage = [weatherData objectForKey:@"conditionsImage"];
self.exampleImage.image = conditionsImage;
```

# Add blur effect view with style
```objc
TDBlurView *exampleBlur = [[TDBlurView alloc] initWithFrame:self.view.bounds style:Light]; // Light, Dark & Dynamic
[self.view addSubview:exampleBlur];
```

# Add UILabel with text, font colour, text alignment, set the font size and bold
```objc
TDLabel *exampleLabel = [[TDLabel alloc] initWithText:@"Hello" colour:nil alignment:center size:40 bold:NO];
[self.view addSubview:exampleLabel];
```

# Add UIView with backgroun colour, corner radius, curve and clip to bounds
```objc
TDView *exampleView = [[TDView alloc] initWithColour:UIColor.redColor corner:25 curve:YES clip:YES];
[self.view addSubview:exampleView];
```

# Add UIButton with title, background colour, title colour, font size and the background corner radius
```objc
TDButton *exampleButton = [[TDButton alloc] initWithTitle:@"Button" colour:nil fontColour:nil fontSize:12 corner:20];
[exampleButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
[self.view addSubview:exampleButton];
```

# Add UIButton with image, inset, background colour, tint colour and corner radius for the background
```objc
UIImage *exampleImage = [[UIImage imageNamed:@"icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
TDButton *exampleButton = [[TDButton alloc] initWithImage:exampleImage inset:UIEdgeInsetsMake(10, 10, 10, 10) colour:nil tint:YES tintColour:UIColor.redColor corner:0];
[exampleButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
[self.view addSubview:exampleButton];
```

# Add UIImageView with tint colour and corner radius if you wanr it to be cirle or whatever
```objc
UIImage *exampleImage = [[UIImage imageNamed:@"icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
TDImage *exampleImageView = [[TDImage alloc] initWithImage:exampleImage tint:NO tintColour:UIColor.yellowColor corner:0];
[self.view addSubview:exampleImageView];
```

# Get the device name, battery or time/date from string
```objc
self.exampleLabel.text = [[TDUtilities sharedInstance] systemVersion];
self.exampleLabel.text = [[TDUtilities sharedInstance] deviceName];
self.exampleLabel.text = [[TDUtilities sharedInstance] deviceModel];
self.exampleLabel.text = [[TDUtilities sharedInstance] timeWithFormat:@"hh:mm"];
self.exampleLabel.text = [[TDUtilities sharedInstance] dateWithFormat:@"E, MMM D"];
self.exampleLabel.text = [[TDUtilities sharedInstance] greeting]; // good morning, good afternoon, good evening, good night
self.exampleLabel.text = [[TDUtilities sharedInstance] battery]; // battery usage
```

# Function to respring, launch apps/url and haptic feedback
```objc
-(void)exampleMethod {

	[[TDUtilities sharedInstance] respring];
	[[TDUtilities sharedInstance] safemode];
	[[TDUtilities sharedInstance] reboot];
	[[TDUtilities sharedInstance] uicache];
	[[TDUtilities sharedInstance] launchURL:@"https://titand3v.com/"]; // Launch URL string
	[[TDUtilities sharedInstance] launchApp:@"com.apple.AppStore"]; // Launch app
	[[TDUtilities sharedInstance] haptic:0]; // 0: light, 1: medium, 2: heavy

}
```

# Constraints helper
```objc
// "Insets": (CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

[exampleView top:self.view.topAnchor leading:self.view.leadingAnchor bottom:nil trailing:nil padding:UIEdgeInsetsMake(10, 20, 0, 0)]; // Set example view all 4 sides with padding
[exampleView top:self.view.topAnchor padding:50]; // Set exampleView top anchor to self view top with padding of 50pts
[exampleView leading:self.view.leadingAnchor padding:50]; // Set exampleView leading (left) anchor to self view leading with padding of 50pts
[exampleView trailing:self.view.trailingAnchor padding:-50]; // Set exampleView trailing (right) anchor to self view trailing with padding of 50pts
[exampleView bottom:self.view.bottomAnchor padding:-50]; // Set exampleView bottom anchor to self view bottom with padding of 50pts

[exampleView size:CGSizeMake(100, 200)]; // Set exampleView width:100 and height:200
[exampleView width:200]; // Set exampleView width: 200
[exampleView height:60]; // Set exampleView height: 60

[exampleView x:self.view.centerXAnchor y:self.view.centerYAnchor]; // Set exampleView center X and Y of self view
[exampleView x:self.view.centerXAnchor]; // Set exampleView center X of self view
[exampleView y:self.view.centerYAnchor]; // Set exampleView center Y of self view

[exampleView fill]; // Set exampleView to fill the frame of self view or wherever subviews you added it to
```

# AppList 
```objc
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
		NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

		NSArray *enabledApps = mutableDict[@"exampleApplistKey"];
		NSLog(@"%@", enabledApps);
		//for(NSString *bid in enabledApps) {

		//}
```

# AppList group hooks to blacklist apps 

```objc
NSString *plistPath = @"/var/mobile/Library/Preferences/com.TitanD3v.TweakNamePrefs.plist";
%ctor {

    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    NSArray *enabledApps = mutableDict[@"exampleApplistKey"];
    for(NSString *bid in enabledApps){

    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* bundleIdentifier = mainBundle.bundleIdentifier;

    if ([bundleIdentifier isEqualToString:bid]) {
    %init(TableHooks);
    }   
   }

	%init(_ungrouped);
}
```