#import "ColourCell.h"

@implementation ColourCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.baseView = [[UIView alloc] init];
        self.baseView.backgroundColor = [UIColor colorNamed:@"Containers"];
        self.baseView.layer.cornerRadius = 25;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        self.baseView.clipsToBounds = true;
        self.baseView.layer.borderColor = [UIColor colorNamed:@"Border"].CGColor;
        self.baseView.layer.borderWidth = 0.6;
        [self addSubview:self.baseView];
        
        [self.baseView top:self.topAnchor padding:5];
        [self.baseView leading:self.leadingAnchor padding:10];
        [self.baseView trailing:self.trailingAnchor padding:-10];
        [self.baseView bottom:self.bottomAnchor padding:-5];
        
        
        self.colourView = [[UIView alloc] init];
        self.colourView.backgroundColor = UIColor.systemPinkColor;
        [self.baseView addSubview:self.colourView];
        
        [self.colourView top:self.baseView.topAnchor padding:0];
        [self.colourView leading:self.baseView.leadingAnchor padding:0];
        [self.colourView trailing:self.baseView.trailingAnchor padding:0];
        [self.colourView height:80];
        
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = UIColor.whiteColor;
        self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.colourView addSubview:self.nameLabel];
        
        [self.nameLabel top:self.colourView.topAnchor padding:10];
        [self.nameLabel x:self.colourView.centerXAnchor];
        
        
        self.hexLabel = [[UILabel alloc] init];
        self.hexLabel.font = [UIFont systemFontOfSize:15];
        self.hexLabel.textAlignment = NSTextAlignmentLeft;
        self.hexLabel.numberOfLines = 1;
        [self.baseView addSubview:self.hexLabel];
        
        [self.hexLabel leading:self.baseView.leadingAnchor padding:15];
        [self.hexLabel top:self.colourView.bottomAnchor padding:10];
        
        
        self.rgbLabel = [[UILabel alloc] init];
        self.rgbLabel.font = [UIFont systemFontOfSize:15];
        self.rgbLabel.textAlignment = NSTextAlignmentLeft;
        self.rgbLabel.numberOfLines = 1;
        [self.baseView addSubview:self.rgbLabel];
        
        [self.rgbLabel leading:self.baseView.leadingAnchor padding:15];
        [self.rgbLabel bottom:self.baseView.bottomAnchor padding:-10];
        
    }
    
    return self;
}

@end
