#import "GradientCell.h"

@implementation GradientCell

- (instancetype)initWithFrame:(CGRect)frame {  
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.baseView = [[UIView alloc] init];
        self.baseView.backgroundColor = [UIColor colorNamed:@"Containers"];
        self.baseView.layer.cornerRadius = 25;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        self.baseView.clipsToBounds = true;
        self.baseView.layer.borderColor = [UIColor colorNamed:@"Border"].CGColor;
        self.baseView.layer.borderWidth = 0.6;
        [self.contentView addSubview:self.baseView];
        
        [self.baseView fill];

        
        self.gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 65)];
        self.gradientView.backgroundColor = UIColor.yellowColor;
        [self.baseView addSubview:self.gradientView];
        
        self.gradient = [CAGradientLayer layer];
        self.gradient.frame = self.gradientView.bounds;
        self.gradient.startPoint = CGPointMake(1, 0);
        self.gradient.endPoint = CGPointMake(0, 1);
        [self.gradientView.layer insertSublayer:self.gradient atIndex:0];
        
        
        self.firstPreview = [[UIView alloc] init];
        self.firstPreview.layer.cornerRadius = 10;
        self.firstPreview.clipsToBounds = true;
        [self.baseView addSubview:self.firstPreview];
        
        [self.firstPreview size:CGSizeMake(20, 20)];
        [self.firstPreview leading:self.baseView.leadingAnchor padding:15];
        [self.firstPreview top:self.gradientView.bottomAnchor padding:10];
        
        
        self.secondPreview = [[UIView alloc] init];
        self.secondPreview.layer.cornerRadius = 10;
        self.secondPreview.clipsToBounds = true;
        [self.baseView addSubview:self.secondPreview];
        
        [self.secondPreview size:CGSizeMake(20, 20)];
        [self.secondPreview leading:self.baseView.leadingAnchor padding:15];
        [self.secondPreview bottom:self.baseView.bottomAnchor padding:-10];
        
        
        self.firstLabel = [[UILabel alloc] init];
        self.firstLabel.font = [UIFont systemFontOfSize:14];
        self.firstLabel.textAlignment = NSTextAlignmentLeft;
        self.firstLabel.textColor = UIColor.labelColor;
        [self.baseView addSubview:self.firstLabel];
        
        [self.firstLabel y:self.firstPreview.centerYAnchor];
        [self.firstLabel leading:self.firstPreview.trailingAnchor padding:10];
        
        
        self.secondLabel = [[UILabel alloc] init];
        self.secondLabel.font = [UIFont systemFontOfSize:14];
        self.secondLabel.textAlignment = NSTextAlignmentLeft;
        self.secondLabel.textColor = UIColor.labelColor;
        [self.baseView addSubview:self.secondLabel];
        
        [self.secondLabel y:self.secondPreview.centerYAnchor];
        [self.secondLabel leading:self.secondPreview.trailingAnchor padding:10];
        
    }
    return self;
}

@end
