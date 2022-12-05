#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ContactsData : NSObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) UIImage *avatar;
@end

