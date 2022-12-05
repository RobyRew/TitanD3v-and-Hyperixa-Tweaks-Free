#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CategoriesIconModel : NSObject
-(id)initWithImageName:(NSString *)name;
@property (nonatomic, retain) NSString *imageName;
@end

@interface CategoriesColourModel : NSObject
-(id)initWithColourHex:(NSString *)hex;
@property (nonatomic, retain) NSString *colourHEX;
@end

@interface CreateCategoryDataSource : NSObject
+(instancetype)sharedInstance;
-(id)init;
-(NSMutableArray*)iconData;
-(NSMutableArray *)colourData;
@end
