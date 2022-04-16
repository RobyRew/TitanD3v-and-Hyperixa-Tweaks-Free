#import "LibraryDataSource.h"

@implementation LibraryDataSource

+(instancetype)sharedInstance {
    static LibraryDataSource*sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LibraryDataSource alloc] init];
    });
    return sharedInstance;
}


-(id)init {
    return self;
}


-(NSMutableArray*)thumbnailData {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *thumbnailPath = [documentsDirectory stringByAppendingPathComponent:@"/Thumbnails/"];
    
    NSMutableArray *folders = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:thumbnailPath error:nil] mutableCopy];
    
    for (int i = 0; i < folders.count; i++) {
        
        NSString *path = [folders objectAtIndex:i];
        if ([path hasSuffix:@".png"]){
            [array addObject:path];
        }
    }
    
    [array sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return array;
}


@end





















