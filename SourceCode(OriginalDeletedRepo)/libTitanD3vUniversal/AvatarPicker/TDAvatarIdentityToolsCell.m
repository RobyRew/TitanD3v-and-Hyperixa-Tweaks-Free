#import "TDAvatarIdentityToolsCell.h"

@implementation TDAvatarIdentityToolsCell

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
        
        
        self.iconImage = [[UIImageView alloc] init];
        self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(self.frame.size.width/2, self.frame.size.width/2)];
        [self.iconImage x:self.baseView.centerXAnchor y:self.baseView.centerYAnchor];
        
    }
    return self;
}


-(void)prepareForReuse {
    [super prepareForReuse];
    self.iconImage.image = nil;
}


@end
