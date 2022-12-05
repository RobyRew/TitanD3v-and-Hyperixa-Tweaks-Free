#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define iPhone_SE ([[UIScreen mainScreen] bounds].size.height == 568) // iPhone SE
#define iPhone_6_8 ([[UIScreen mainScreen] bounds].size.height == 667) // iPhone 6, 6s, 7 and 8
#define iPhone_6_8_Plus ([[UIScreen mainScreen] bounds].size.height == 736) // iPhone 6, 6s, 7 and 8 Plus
#define iPhone_X_XS_11Pro ([[UIScreen mainScreen] bounds].size.height == 812) // iPhone X, XS, 11 Pro
#define iPhone_XR_XS_11Pro ([[UIScreen mainScreen] bounds].size.height == 896) // iPhone XR, XS Max, 11 Pro Max
#define iPhone_12_Pro ([[UIScreen mainScreen] bounds].size.height == 844) // iPhone 12 & 12 Pro
#define iPhone_12_mini ([[UIScreen mainScreen] bounds].size.height == 780) // iPhone 12 mini
#define iPhone_12_Pro_Max ([[UIScreen mainScreen] bounds].size.height == 926) // iPhone 12 Pro Max