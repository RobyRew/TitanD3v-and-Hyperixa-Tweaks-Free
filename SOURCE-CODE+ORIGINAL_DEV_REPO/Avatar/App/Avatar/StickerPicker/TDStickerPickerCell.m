#import "TDStickerPickerCell.h"

@implementation TDStickerPickerCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.baseView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.baseView];
        
        
        self.iconImage = [[UIImageView alloc] init];
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(self.frame.size.width, self.frame.size.width)];
        [self.iconImage x:self.baseView.centerXAnchor y:self.baseView.centerYAnchor];
        
    }
    return self;
}


-(void)prepareForReuse {
    [super prepareForReuse];
    self.iconImage.image = nil;
}


@end
