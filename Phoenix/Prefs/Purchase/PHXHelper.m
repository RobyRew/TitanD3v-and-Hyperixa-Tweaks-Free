#import <TitanD3vUniversal/TitanD3vUniversal.h>

//Black : This is the purchase and trial prefs file which will save data for trail and purchase.
static NSString *plistPath = @"/var/mobile/Library/Preferences/com.applle.storeKit.Phoenix.plist";

//Black : this is the main Jarvis prefs file where enable/disable tweak will be saved changed with your own
static NSString *prefsPlistPath = @"/var/mobile/Library/Preferences/com.TitanD3v.PhoenixPrefs.plist";

static NSString* encryptString(NSString* plaintext) {
	NSError *error = nil;
	NSString *UDID = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
	NSString *key = [NSString stringWithFormat:@"UDID%@meblackhat", UDID];
	NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
	NSData *encryptedData = [RNEncryptor encryptData:data withSettings:kRNCryptorAES256Settings password:key error:&error];
	return [encryptedData base64EncodedStringWithOptions:0];
}

static NSString* decryptString(NSString* encryptedString) {
	if(!encryptedString)
	return nil;
	NSError *error = nil;
	NSString *UDID = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
	NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:encryptedString options:0];
	NSString *key = [NSString stringWithFormat:@"UDID%@meblackhat", UDID];

	NSData *decryptedData = [RNDecryptor decryptData:decodedData withPassword:key error:&error];
	return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];;
}

// Black this will write values to purchase file
static void writeToPlist(NSString *key, NSString *value){
	NSString *valueE = encryptString(value);
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	[mutableDict setValue:valueE forKey:key];
	[mutableDict writeToFile:plistPath atomically:YES];
}

// Black this will write values to tweaksMain prefs file
static void writeToPrefsPlist(NSString *key, NSString *value){
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefsPlistPath];
	NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	[mutableDict setValue:value forKey:key];
	[mutableDict writeToFile:prefsPlistPath atomically:YES];
}

// Black this will read values from purchase plist
static NSString *readPlist(NSString *key){
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
	return decryptString([dict objectForKey:key]);
}

// Black this will read values from main tweak prefs plist
static BOOL readPrefsPlist(NSString *key){
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:prefsPlistPath];
	return [[dict objectForKey:key] boolValue];
}

static NSString *timeStamp(){
	long long mn = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
	return [NSString stringWithFormat:@"%lld", mn];
}
