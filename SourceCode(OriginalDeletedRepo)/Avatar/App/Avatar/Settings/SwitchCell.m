#import "SwitchCell.h"

@implementation SwitchCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        BOOL useDefaultMemoji = [[SettingManager sharedInstance] boolForKey:@"useDefaultMemoji" defaultValue:NO];
        
        self.baseView = [[UIView alloc] init];
        self.baseView.backgroundColor = [UIColor colorNamed:@"Secondary"];
        self.baseView.layer.cornerRadius = 15;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        self.baseView.clipsToBounds = true;
        [self addSubview:self.baseView];
        
        [self.baseView top:self.topAnchor padding:5];
        [self.baseView leading:self.leadingAnchor padding:5];
        [self.baseView trailing:self.trailingAnchor padding:-5];
        [self.baseView bottom:self.bottomAnchor padding:-5];
        
        
        self.iconView = [[UIView alloc] init];
        self.iconView.layer.cornerRadius = 10;
        self.iconView.layer.cornerCurve = kCACornerCurveContinuous;
        self.iconView.clipsToBounds = YES;
        [self.baseView addSubview:self.iconView];
        
        [self.iconView size:CGSizeMake(40, 40)];
        [self.iconView y:self.baseView.centerYAnchor];
        [self.iconView leading:self.baseView.leadingAnchor padding:10];
        
        
        self.iconImage = [[UIImageView alloc] init];
        [self.iconView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(30, 30)];
        [self.iconImage x:self.iconView.centerXAnchor y:self.iconView.centerYAnchor];
        
        
        self.toggleSwitch = [[UISwitch alloc] init];
        [self.toggleSwitch addTarget:self action:@selector(switchChangedState:) forControlEvents:UIControlEventValueChanged];
        [self.toggleSwitch setOn:useDefaultMemoji animated:NO];
        self.toggleSwitch.onTintColor = UIColor.systemIndigoColor;
        self.toggleSwitch.thumbTintColor = [UIColor colorNamed:@"Secondary"];
        [self.contentView addSubview:self.toggleSwitch];
        
        [self.toggleSwitch y:self.baseView.centerYAnchor];
        [self.toggleSwitch trailing:self.baseView.trailingAnchor padding:-10];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = UIColor.labelColor;
        [self.baseView addSubview:self.titleLabel];
        
        [self.titleLabel leading:self.iconView.trailingAnchor padding:10];
        [self.titleLabel top:self.iconView.topAnchor padding:2];
        [self.titleLabel trailing:self.toggleSwitch.leadingAnchor padding:-10];
        
        
        self.subtitleLabel = [[UILabel alloc] init];
        self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
        self.subtitleLabel.font = [UIFont systemFontOfSize:13];
        self.subtitleLabel.textColor = UIColor.tertiaryLabelColor;
        [self.baseView addSubview:self.subtitleLabel];
        
        [self.subtitleLabel leading:self.iconView.trailingAnchor padding:10];
        [self.subtitleLabel bottom:self.iconView.bottomAnchor padding:-2];
        [self.subtitleLabel trailing:self.toggleSwitch.leadingAnchor padding:-10];
        
    }
    
    return self;
}


-(void)prepareForReuse {
    [super prepareForReuse];
    
    self.iconImage.image = nil;
    self.titleLabel.text = nil;
    self.subtitleLabel.text = nil;
}


- (void)switchChangedState:(UISwitch *)sender {
    [[SettingManager sharedInstance] setBool:sender.on forKey:@"useDefaultMemoji"];
//    if ([sender isOn]) {
//    } else {
//    }
}

@end
