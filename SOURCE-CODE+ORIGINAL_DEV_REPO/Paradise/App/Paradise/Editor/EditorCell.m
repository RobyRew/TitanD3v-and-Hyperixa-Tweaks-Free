#import "EditorCell.h"

@implementation EditorCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 20;
        
        self.clipsToBounds = true;
        self.layer.cornerRadius = 20;
        
        self.baseView = [[UIView alloc] init];
        self.baseView.layer.cornerRadius = 20;
        self.baseView.backgroundColor = [UIColor colorNamed:@"Main Background"];
        self.baseView.clipsToBounds = true;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        [self.contentView addSubview:self.baseView];
        
        [self.baseView fill];
        
        
        self.iconImage = [[UIImageView alloc] init];
        self.iconImage.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImage.clipsToBounds = true;
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(30, 30)];
        [self.iconImage top:self.baseView.topAnchor padding:10];
        [self.iconImage leading:self.baseView.leadingAnchor padding:10];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 2;
        [self.baseView addSubview:self.titleLabel];
        
        [self.titleLabel x:self.baseView.centerXAnchor];
        [self.titleLabel leading:self.baseView.leadingAnchor padding:5];
        [self.titleLabel trailing:self.baseView.trailingAnchor padding:-5];
        [self.titleLabel bottom:self.baseView.bottomAnchor padding:-10];
        
        
        self.previewImage = [[UIImageView alloc] init];
        self.previewImage.layer.cornerRadius = 5;
        self.previewImage.layer.cornerCurve = kCACornerCurveContinuous;
        self.previewImage.clipsToBounds = true;
        self.previewImage.tintColor = UIColor.labelColor;
        [self.baseView addSubview:self.previewImage];
        
        [self.previewImage size:CGSizeMake(40, 40)];
        [self.previewImage x:self.baseView.centerXAnchor];
        [self.previewImage bottom:self.titleLabel.topAnchor padding:-15];
        
    }
    return self;
}

@end
