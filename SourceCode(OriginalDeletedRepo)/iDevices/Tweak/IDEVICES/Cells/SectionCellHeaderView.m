#import "SectionCellHeaderView.h"

@implementation SectionCellHeaderView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.baseView = [[UIView alloc] initWithFrame:self.bounds];
        self.baseView.clipsToBounds = YES;
        [self addSubview:self.baseView];
        
        
        self.headerLabel = [[UILabel alloc] init];
        self.headerLabel.textColor = [UIColor subtitleColour];
        self.headerLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.baseView addSubview:self.headerLabel];
        
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [[self.headerLabel centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = YES;
        [self.headerLabel.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:20].active = YES;
        
    }
    return self;
}

@end
