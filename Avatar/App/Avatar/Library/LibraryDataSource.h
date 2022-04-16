#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LibraryDataSource : NSObject
+(instancetype)sharedInstance;
-(id)init;

-(NSMutableArray*)thumbnailData;
@end
