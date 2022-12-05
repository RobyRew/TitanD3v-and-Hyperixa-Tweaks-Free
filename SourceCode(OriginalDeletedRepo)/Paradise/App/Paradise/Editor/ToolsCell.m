#import "ToolsCell.h"

@implementation ToolsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.baseView = [[UIView alloc] init];
        self.baseView.backgroundColor = [UIColor colorNamed:@"Main Background"];
        self.baseView.layer.cornerRadius = 15;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        self.baseView.clipsToBounds = true;
        [self.contentView addSubview:self.baseView];
        
        [self.baseView top:self.topAnchor padding:5];
        [self.baseView leading:self.leadingAnchor padding:5];
        [self.baseView trailing:self.trailingAnchor padding:-5];
        [self.baseView bottom:self.bottomAnchor padding:-5];
        
        
        self.iconImage = [[UIImageView alloc] init];
        self.iconImage.tintColor = UIColor.labelColor;
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(15, 15)];
        [self.iconImage top:self.baseView.topAnchor padding:10];
        [self.iconImage leading:self.baseView.leadingAnchor padding:10];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.baseView addSubview:self.titleLabel];
        
        [self.titleLabel y:self.iconImage.centerYAnchor];
        [self.titleLabel leading:self.iconImage.trailingAnchor padding:8];
        
        
        self.resetButton = [[UIButton alloc] init];
        [self.resetButton addTarget:self action:@selector(resetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *btnImage = [UIImage imageNamed:@"reset"];
        [self.resetButton setImage:btnImage forState:UIControlStateNormal];
        self.resetButton.tintColor = UIColor.systemRedColor;
        [self.baseView addSubview:self.resetButton];
        
        [self.resetButton size:CGSizeMake(20, 20)];
        [self.resetButton top:self.baseView.topAnchor padding:10];
        [self.resetButton trailing:self.baseView.trailingAnchor padding:-10];
        
        
        self.slider = [[UISlider alloc] init];
        [self.baseView addSubview:self.slider];
        
        [self.slider leading:self.baseView.leadingAnchor padding:10];
        [self.slider trailing:self.baseView.trailingAnchor padding:-10];
        [self.slider bottom:self.baseView.bottomAnchor padding:-10];
        
    }
    
    return self;
}


- (void)resetButtonPressed:(id)sender {
    [self.toolsDelegate resetToolsForCell:self];
}

@end
