#import <UIKit/UIKit.h>

@interface TDContact : NSObject
@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *emailAddress;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) UIImage *avatarImage;
@property (nonatomic) BOOL isEmailAvailable;
@property (nonatomic) BOOL isAvatarAvailable;
@property (nonatomic) BOOL isPhoneNumberContainPrefix;
@end
