#import "BatteryCell.h"

@implementation BatteryCell

- (instancetype)initWithFrame:(CGRect)frame {  
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.baseView = [[UIView alloc] init];
        self.baseView.backgroundColor = [UIColor cellColour];
        self.baseView.layer.cornerRadius = 20;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        self.baseView.clipsToBounds = true;
        [self.contentView addSubview:self.baseView];
        
        [self.baseView fill];
        
        
        self.usageView = [[DeviceUsageView alloc] initWithFrame:CGRectZero];
        self.usageView.backgroundColor = UIColor.clearColor;
        self.usageView.progressColor = UIColor.systemGreenColor;
        self.usageView.progressStrokeColor = UIColor.systemGreenColor;
        self.usageView.emptyLineStrokeColor = UIColor.clearColor;
        self.usageView.emptyLineColor = [UIColor batteryRingColour];
        self.usageView.fontColor = UIColor.clearColor;
        self.usageView.progressLineWidth = 3;
        self.usageView.valueFontSize = 10;
        self.usageView.unitFontSize = 8;
        self.usageView.emptyLineWidth = 3;
        self.usageView.emptyCapType = kCGLineCapRound;
        self.usageView.progressAngle = 100;
        self.usageView.progressRotationAngle = 50;
        [self.baseView addSubview:self.usageView];
        
        
        [self.usageView size:CGSizeMake(55, 55)];
        [self.usageView top:self.baseView.topAnchor padding:10];
        [self.usageView leading:self.baseView.leadingAnchor padding:10];
        
        
        self.deviceImage = [[UIImageView alloc] init];
        self.deviceImage.image = [UIImage systemImageNamed:@"gear"];
        self.deviceImage.contentMode = UIViewContentModeScaleAspectFit;
        self.deviceImage.tintColor = [UIColor accentColour];
        [self.baseView addSubview:self.deviceImage];
        
        [self.deviceImage size:CGSizeMake(30, 30)];
        [self.deviceImage x:self.usageView.centerXAnchor y:self.usageView.centerYAnchor];
        
        
        self.deviceLabel = [[UILabel alloc] init];
        self.deviceLabel.textColor = [UIColor fontColour];
        self.deviceLabel.font = [UIFont boldSystemFontOfSize:14];
        self.deviceLabel.textAlignment = NSTextAlignmentLeft;
        [self.baseView addSubview:self.deviceLabel];
        
        [self.deviceLabel top:self.usageView.topAnchor padding:10];
        [self.deviceLabel leading:self.usageView.trailingAnchor padding:10];
        [self.deviceLabel trailing:self.baseView.trailingAnchor padding:-10];
        
        
        self.batteryLabel = [[UILabel alloc] init];
        self.batteryLabel.textColor = UIColor.systemGreenColor;
        self.batteryLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
        self.batteryLabel.textAlignment = NSTextAlignmentLeft;
        [self.baseView addSubview:self.batteryLabel];
        
        [self.batteryLabel bottom:self.usageView.bottomAnchor padding:-10];
        [self.batteryLabel leading:self.usageView.trailingAnchor padding:10];
        [self.batteryLabel trailing:self.baseView.trailingAnchor padding:-10];
        
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor subtitleColour];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.baseView addSubview:self.nameLabel];
        
        [self.nameLabel bottom:self.baseView.bottomAnchor padding:-5];
        [self.nameLabel leading:self.baseView.leadingAnchor padding:10];
        [self.nameLabel trailing:self.baseView.trailingAnchor padding:-10];
        [self.nameLabel x:self.baseView.centerXAnchor];
        
    }
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    self.deviceImage.image = nil;
    self.nameLabel.text = nil;
    self.deviceLabel.text = nil;
    self.batteryLabel.text = nil;
}

@end
