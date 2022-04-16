#import "ThemesCell.h"

@implementation ThemesCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
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
        
        
        self.folderImage = [[UIImageView alloc] init];
        self.folderImage.image = [UIImage systemImageNamed:@"folder.fill"];
        self.folderImage.contentMode = UIViewContentModeScaleAspectFill;
        self.folderImage.tintColor = UIColor.whiteColor;
        [self.baseView addSubview:self.folderImage];
        
        [self.folderImage size:CGSizeMake(30, 30)];
        [self.folderImage top:self.baseView.topAnchor padding:10];
        [self.folderImage leading:self.baseView.leadingAnchor padding:10];
        
        
        self.checkedImage = [[UIImageView alloc] init];
        self.checkedImage.contentMode = UIViewContentModeScaleAspectFill;
        self.checkedImage.tintColor = UIColor.whiteColor;
        [self.baseView addSubview:self.checkedImage];
        
        [self.checkedImage size:CGSizeMake(25, 25)];
        [self.checkedImage top:self.baseView.topAnchor padding:7];
        [self.checkedImage trailing:self.baseView.trailingAnchor padding:-7];
        
        
        self.themeLabel = [[UILabel alloc] init];
        self.themeLabel.font = [UIFont boldSystemFontOfSize:16];
        self.themeLabel.textAlignment = NSTextAlignmentCenter;
        self.themeLabel.textColor = UIColor.whiteColor;
        [self.baseView addSubview:self.themeLabel];
        
        [self.themeLabel x:self.baseView.centerXAnchor];
        [self.themeLabel y:self.baseView.centerYAnchor];
        [self.themeLabel leading:self.baseView.leadingAnchor padding:5];
        [self.themeLabel trailing:self.baseView.trailingAnchor padding:-5];
        
        
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.font = [UIFont systemFontOfSize:12];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.textColor = UIColor.whiteColor;
        [self.baseView addSubview:self.countLabel];
        
        [self.countLabel top:self.themeLabel.bottomAnchor padding:5];
        [self.countLabel x:self.baseView.centerXAnchor];
        [self.countLabel leading:self.baseView.leadingAnchor padding:5];
        [self.countLabel trailing:self.baseView.trailingAnchor padding:-5];
        
    }
    return self;
}

@end
