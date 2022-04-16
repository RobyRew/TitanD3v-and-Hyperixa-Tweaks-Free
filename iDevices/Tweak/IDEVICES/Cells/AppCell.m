#import "AppCell.h"

@implementation AppCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 20;
        self.layer.cornerCurve = kCACornerCurveContinuous;
        self.clipsToBounds = true;
        
        
        self.baseView = [[UIView alloc] init];
        self.baseView.backgroundColor = [UIColor cellColour];
        self.baseView.layer.cornerRadius = 20;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        self.baseView.clipsToBounds = true;
        [self.contentView addSubview:self.baseView];
        
        [self.baseView fill];
        
        
        self.iconImage = [[UIImageView alloc] init];
        self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImage.layer.cornerRadius = 10;
        self.iconImage.layer.cornerCurve = kCACornerCurveContinuous;
        self.iconImage.clipsToBounds = YES;
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(40, 40)];
        [self.iconImage y:self.baseView.centerYAnchor];
        [self.iconImage leading:self.baseView.leadingAnchor padding:20];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [UIColor titleColour];
        [self.baseView addSubview:self.titleLabel];
        
        [self.titleLabel leading:self.iconImage.trailingAnchor padding:10];
        [self.titleLabel top:self.iconImage.topAnchor padding:2];
        [self.titleLabel trailing:self.baseView.trailingAnchor padding:-10];
        
        
        self.subtitleLabel = [[UILabel alloc] init];
        self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
        self.subtitleLabel.font = [UIFont systemFontOfSize:13];
        self.subtitleLabel.textColor = [UIColor subtitleColour];
        [self.baseView addSubview:self.subtitleLabel];
        
        [self.subtitleLabel leading:self.iconImage.trailingAnchor padding:10];
        [self.subtitleLabel bottom:self.iconImage.bottomAnchor padding:-2];
        [self.subtitleLabel trailing:self.baseView.trailingAnchor padding:-10];
        
        
    }
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    self.iconImage.image = nil;
    self.titleLabel.text = nil;
    self.subtitleLabel.text = nil;
}


- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? [UIColor cellColour] : [UIColor cellColour];
}

@end
