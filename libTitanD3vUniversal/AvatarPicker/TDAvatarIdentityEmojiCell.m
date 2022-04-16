#import "TDAvatarIdentityEmojiCell.h"

@implementation TDAvatarIdentityEmojiCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = self.frame.size.width/2;
        self.clipsToBounds = true;
        
        
        self.baseView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        self.baseView.layer.cornerRadius = self.frame.size.width/2;
        self.baseView.backgroundColor = UIColor.secondarySystemBackgroundColor;
        self.baseView.clipsToBounds = true;
        [self.contentView addSubview:self.baseView];
        
        
        self.emojiLabel = [[UILabel alloc] init];
        self.emojiLabel.textAlignment = NSTextAlignmentCenter;
        self.emojiLabel.font = [UIFont systemFontOfSize:45];
        [self.baseView addSubview:self.emojiLabel];
        
        [self.emojiLabel x:self.baseView.centerXAnchor y:self.baseView.centerYAnchor];
        
        
    }
    return self;
}


-(void)prepareForReuse {
    [super prepareForReuse];
    self.emojiLabel.text = nil;
}


@end
