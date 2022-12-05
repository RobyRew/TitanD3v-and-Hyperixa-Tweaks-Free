@import Foundation;

@interface AVTAvatarStore: NSObject
- (instancetype)initWithDomainIdentifier:(NSString *)identifier;
@end

#define ASAvatarStore NSClassFromString(@"AVTAvatarStore")
