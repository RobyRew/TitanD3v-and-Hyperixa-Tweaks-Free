#import "LibraryCell.h"

@implementation LibraryCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 15;
        self.layer.cornerCurve = kCACornerCurveContinuous;
        self.clipsToBounds = true;
        
        
        self.baseView = [[UIView alloc] init];
        self.baseView.layer.cornerRadius = 15;
        self.baseView.backgroundColor = [UIColor colorNamed:@"Secondary"];
        self.baseView.clipsToBounds = true;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        [self.contentView addSubview:self.baseView];
        
        [self.baseView fill];
        
        
        self.thumbnailImage = [[UIImageView alloc] init];
        self.thumbnailImage.layer.cornerRadius = 15;
        self.thumbnailImage.layer.cornerCurve = kCACornerCurveContinuous;
        self.thumbnailImage.clipsToBounds = YES;
        self.thumbnailImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.baseView addSubview:self.thumbnailImage];
        
        [self.thumbnailImage size:CGSizeMake(100, 70)];
        [self.thumbnailImage y:self.baseView.centerYAnchor];
        [self.thumbnailImage leading:self.baseView.leadingAnchor padding:15];
        
        
        self.iconImage = [[UIImageView alloc] init];
        self.iconImage.tintColor = UIColor.systemBlueColor;
        self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImage.image = [UIImage systemImageNamed:@"play.rectangle.fill"];
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(40, 40)];
        [self.iconImage y:self.baseView.centerYAnchor];
        [self.iconImage trailing:self.baseView.trailingAnchor padding:-15];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = UIColor.labelColor;
        [self.baseView addSubview:self.titleLabel];
        
        [self.titleLabel y:self.baseView.centerYAnchor];
        [self.titleLabel leading:self.thumbnailImage.trailingAnchor padding:10];
        [self.titleLabel trailing:self.iconImage.leadingAnchor padding:-8];
        
    }
    return self;
}


-(void)prepareForReuse {
    [super prepareForReuse];
    self.thumbnailImage.image = nil;
    self.titleLabel.text = nil;
}


- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
}

@end
