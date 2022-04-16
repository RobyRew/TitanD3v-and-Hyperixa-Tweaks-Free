#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TDAvatarIdentityPickerEmojiDataModel : NSObject
-(id)initWithEmoji:(NSString *)emoji colour:(NSString *)colour;
@property (nonatomic, retain) NSString *emoji;
@property (nonatomic, retain) NSString *colour;
@end

@interface TDAvatarIdentityPickerDataSource : NSObject
+(instancetype)sharedInstance;
-(id)init;

-(NSMutableArray*)stickersData;
-(NSMutableArray*)emojiData;
@end
