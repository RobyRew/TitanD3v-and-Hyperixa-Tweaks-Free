#import "TDEmojiPickerCell.h"

@implementation TDEmojiPickerCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.baseView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.baseView];
        
        self.emojiLabel = [[UILabel alloc] init];
        self.emojiLabel.textAlignment = NSTextAlignmentCenter;
        self.emojiLabel.font = [UIFont systemFontOfSize:30];
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
