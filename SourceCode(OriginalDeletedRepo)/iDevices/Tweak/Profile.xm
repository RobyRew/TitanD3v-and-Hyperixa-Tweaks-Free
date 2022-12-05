#import <TitanD3vUniversal/TitanD3vUniversal.h>

@interface AAAccount : NSObject
@property (nonatomic,readonly) NSString * lastName;
@property (nonatomic,readonly) NSString * firstName;
@property (nonatomic,readonly) NSString * primaryEmail;
@property (nonatomic,readonly) BOOL primaryEmailVerified;
@end

@interface AAAccountManager : NSObject
+(id)sharedManager;
-(id)primaryAccount;
@end

static NSString *fullName = @"Username";
static UIImage *appleIdAvatar = nil;


%hook PSUIPrefsListController

-(void)viewDidLoad {
	%orig;

	static dispatch_once_t dataToken;

	dispatch_once(&dataToken, ^{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

			appleIdAvatar = MSHookIvar<UIImage *>(self, "_appleAccountSpecifierCachedIcon");
			NSData *imageData;
			if (appleIdAvatar != nil) {
				imageData = UIImagePNGRepresentation(appleIdAvatar);
			} else {
				UIImage *defaultImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/iDevices.bundle/Assets/Default/default-avatar.png"];
				imageData = UIImagePNGRepresentation(defaultImage);
			}
			[[TDTweakManager sharedInstance] setObject:imageData forKey:@"icloudAvatar" ID:@"com.TitanD3v.iDevicesPrefs"];


			AAAccount *account  = [[%c(AAAccountManager) sharedManager] primaryAccount];
			if (account.firstName != nil) {
				fullName = [NSString stringWithFormat:@"%@ %@", account.firstName, account.lastName];
			} else {
				fullName = @"Username";
			}
			[[TDTweakManager sharedInstance] setObject:fullName forKey:@"icloudName" ID:@"com.TitanD3v.iDevicesPrefs"];
		});
	});

}
%end


%ctor{
	NSBundle *appleAccountBundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/AppleAccount.framework/"];
	[appleAccountBundle load];
}
