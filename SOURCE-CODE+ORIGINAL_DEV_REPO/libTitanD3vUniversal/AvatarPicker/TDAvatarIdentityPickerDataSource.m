#import "TDAvatarIdentityPickerDataSource.h"

@implementation TDAvatarIdentityPickerEmojiDataModel
-(id)initWithEmoji:(NSString *)emoji colour:(NSString *)colour {
    self = [super init];
    if(self) {
        self.emoji = emoji;
        self.colour = colour;
    }
    return self;
}
@end


@implementation TDAvatarIdentityPickerDataSource

+(instancetype)sharedInstance {
    static TDAvatarIdentityPickerDataSource *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TDAvatarIdentityPickerDataSource alloc] init];
    });
    return sharedInstance;
}


-(id)init {
    return self;
}


-(NSMutableArray*)stickersData {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSString *stickersPath = @"/var/mobile/Library/Avatar/Stickers";
    
    NSMutableArray *folders = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:stickersPath error:nil] mutableCopy];
    
    for (int i = 0; i < folders.count; i++) {
        
        NSString *path = [folders objectAtIndex:i];
        if ([path hasSuffix:@".png"]){
            [array addObject:path];
        }
    }
    
    [array sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return array;
}


-(NSMutableArray*)emojiData {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"😀" colour:@"a8e6cf"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🥶" colour:@"d0e1f9"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"😜" colour:@"a8e6cf"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"😍" colour:@"ffaaa5"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"😘" colour:@"eedbdb"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🥳" colour:@"dddddd"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"😻" colour:@"e4dcf1"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"💋" colour:@"eee3e7"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"💍" colour:@"e7d3d3"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🦄" colour:@"fec8c1"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🍻" colour:@"96ceb4"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🥂" colour:@"ff6f69"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🍿" colour:@"ffdbac"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"⚽️" colour:@"64a1f4"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🏈" colour:@"add6ff"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🏒" colour:@"ffefd7"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🚗" colour:@"a8e6cf"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🛴" colour:@"dcedc1"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"🚀" colour:@"ffcc5c"]];
    [array addObject:[[TDAvatarIdentityPickerEmojiDataModel alloc] initWithEmoji:@"💻" colour:@"b3cde0"]];
    return array;
}

@end





















