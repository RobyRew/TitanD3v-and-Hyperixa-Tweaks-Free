#import "DevicesCell.h"

@implementation DevicesCell

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

        
        self.deviceImage = [[UIImageView alloc] init];
        self.deviceImage.contentMode = UIViewContentModeScaleAspectFill;
        self.deviceImage.tintColor = [UIColor accentColour];
        [self.baseView addSubview:self.deviceImage];
        
        [self.deviceImage size:CGSizeMake(50, 50)];
        [self.deviceImage x:self.baseView.centerXAnchor];
        [self.deviceImage top:self.baseView.topAnchor padding:10];
        
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor titleColour];
        self.nameLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.baseView addSubview:self.nameLabel];
        
        [self.nameLabel x:self.baseView.centerXAnchor];
        [self.nameLabel top:self.deviceImage.bottomAnchor padding:5];
        [self.nameLabel leading:self.baseView.leadingAnchor padding:5];
        [self.nameLabel trailing:self.baseView.trailingAnchor padding:-5];
        
        
        self.deviceLabel = [[UILabel alloc] init];
        self.deviceLabel.textColor = [UIColor subtitleColour];
        self.deviceLabel.font = [UIFont systemFontOfSize:12];
        self.deviceLabel.textAlignment = NSTextAlignmentCenter;
        [self.baseView addSubview:self.deviceLabel];
        
        [self.deviceLabel x:self.baseView.centerXAnchor];
        [self.deviceLabel top:self.nameLabel.bottomAnchor padding:5];
        [self.deviceLabel leading:self.baseView.leadingAnchor padding:5];
        [self.deviceLabel trailing:self.baseView.trailingAnchor padding:-5];
        
        
        self.modelLabel = [[UILabel alloc] init];
        self.modelLabel.textColor = [UIColor subtitleColour];
        self.modelLabel.font = [UIFont systemFontOfSize:12];
        self.modelLabel.textAlignment = NSTextAlignmentCenter;
        [self.baseView addSubview:self.modelLabel];
        
        [self.modelLabel x:self.baseView.centerXAnchor];
        [self.modelLabel top:self.deviceLabel.bottomAnchor padding:5];
        [self.modelLabel leading:self.baseView.leadingAnchor padding:5];
        [self.modelLabel trailing:self.baseView.trailingAnchor padding:-5];
        
        
        self.versionLabel = [[UILabel alloc] init];
        self.versionLabel.textColor = [UIColor subtitleColour];
        self.versionLabel.font = [UIFont systemFontOfSize:12];
        self.versionLabel.textAlignment = NSTextAlignmentCenter;
        [self.baseView addSubview:self.versionLabel];
        
        [self.versionLabel x:self.baseView.centerXAnchor];
        [self.versionLabel top:self.modelLabel.bottomAnchor padding:5];
        [self.versionLabel leading:self.baseView.leadingAnchor padding:5];
        [self.versionLabel trailing:self.baseView.trailingAnchor padding:-5];
        
        
    }
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    self.deviceImage.image = nil;
    self.nameLabel.text = nil;
    self.deviceLabel.text = nil;
    self.modelLabel.text = nil;
    self.versionLabel.text = nil;
}


- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? [UIColor cellColour] : [UIColor cellColour];
}

@end
