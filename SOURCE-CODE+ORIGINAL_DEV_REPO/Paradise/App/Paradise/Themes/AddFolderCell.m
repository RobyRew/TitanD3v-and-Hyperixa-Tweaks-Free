#import "AddFolderCell.h"

@implementation AddFolderCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 20;
        
        self.clipsToBounds = true;
        self.layer.cornerRadius = 20;
        
        self.baseView = [[UIView alloc] init];
        self.baseView.layer.cornerRadius = 20;
        self.baseView.backgroundColor = [UIColor colorNamed:@"Cell Background"];
        self.baseView.clipsToBounds = true;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        [self.contentView addSubview:self.baseView];
        
        [self.baseView fill];
        
        
        self.gradientImage = [[UIImageView alloc] init];
        self.gradientImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.baseView addSubview:self.gradientImage];
        
        [self.gradientImage fill];
        
        
        self.iconImage = [[UIImageView alloc] init];
        self.iconImage.image = [UIImage systemImageNamed:@"folder.fill.badge.plus"];
        self.iconImage.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImage.tintColor = UIColor.whiteColor;
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(55, 55)];
        [self.iconImage top:self.baseView.topAnchor padding:20];
        [self.iconImage x:self.baseView.centerXAnchor];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"Create New Folder";
        self.titleLabel.textColor = UIColor.whiteColor;
        [self.baseView addSubview:self.titleLabel];
        
        [self.titleLabel top:self.iconImage.bottomAnchor padding:10];
        [self.titleLabel x:self.baseView.centerXAnchor];
        [self.titleLabel leading:self.baseView.leadingAnchor padding:5];
        [self.titleLabel trailing:self.baseView.trailingAnchor padding:-5];
        
    }
    return self;
}

@end
