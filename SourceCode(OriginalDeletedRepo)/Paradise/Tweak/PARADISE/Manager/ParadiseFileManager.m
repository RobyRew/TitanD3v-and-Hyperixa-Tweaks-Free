#import "ParadiseFileManager.h"

@implementation NSFileManager (ParadiseFileManager)
- (BOOL)nr_getAllocatedSize:(unsigned long long *)size ofDirectoryAtURL:(NSURL *)directoryURL error:(NSError * __autoreleasing *)error
{
  NSParameterAssert(size != NULL);
  NSParameterAssert(directoryURL != nil);

  unsigned long long accumulatedSize = 0;

  NSArray *prefetchedProperties = @[
  NSURLIsRegularFileKey,
  NSURLFileAllocatedSizeKey,
  NSURLTotalFileAllocatedSizeKey,
  ];

  __block BOOL errorDidOccur = NO;
  BOOL (^errorHandler)(NSURL *, NSError *) = ^(NSURL *url, NSError *localError) {
    if (error != NULL)
    *error = localError;
    errorDidOccur = YES;
    return NO;
  };

  NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:directoryURL
  includingPropertiesForKeys:prefetchedProperties
  options:(NSDirectoryEnumerationOptions)0
  errorHandler:errorHandler];

  for (NSURL *contentItemURL in enumerator) {

    if (errorDidOccur)
    return NO;

    NSNumber *isRegularFile;
    if (! [contentItemURL getResourceValue:&isRegularFile forKey:NSURLIsRegularFileKey error:error])
    return NO;
    if (! [isRegularFile boolValue])
    continue;

    NSNumber *fileSize;
    if (! [contentItemURL getResourceValue:&fileSize forKey:NSURLTotalFileAllocatedSizeKey error:error])
    return NO;

    if (fileSize == nil) {
      if (! [contentItemURL getResourceValue:&fileSize forKey:NSURLFileAllocatedSizeKey error:error])
      return NO;

      NSAssert(fileSize != nil, @"huh? NSURLFileAllocatedSizeKey should always return a value");
    }

    accumulatedSize += [fileSize unsignedLongLongValue];
  }

  if (errorDidOccur)
  return NO;

  *size = accumulatedSize;
  return YES;
}

@end
