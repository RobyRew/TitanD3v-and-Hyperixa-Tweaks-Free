#import <UIKit/UIKit.h>

@interface NSFileManager (ParadiseFileManager)
- (BOOL)nr_getAllocatedSize:(unsigned long long *)size ofDirectoryAtURL:(NSURL *)url error:(NSError * __autoreleasing *)error;
@end