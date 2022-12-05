#import "TutorialCell.h"

@implementation TutorialCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        self.contentView.clipsToBounds = true;
        
        self.baseView = [[UIView alloc] initWithFrame:CGRectZero];
        self.baseView.backgroundColor = [UIColor clearColor];
        self.baseView.clipsToBounds = true;
        [self.contentView addSubview:self.baseView];
        
        self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.baseView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
        [self.baseView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10].active = YES;
        [self.baseView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
        [self.baseView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = YES;
        
        
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImage.tintColor = [UIColor colorNamed:@"Accent"];
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(45, 45)];
        [self.iconImage y:self.baseView.centerYAnchor];
        [self.iconImage leading:self.baseView.leadingAnchor padding:5];
        
        
        self.messageLabel = [[UITextView alloc] init];
        self.messageLabel.font = [UIFont systemFontOfSize:18];
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
        self.messageLabel.delegate = self;
        self.messageLabel.textColor = UIColor.labelColor;
        self.messageLabel.scrollEnabled = NO;
        self.messageLabel.editable = NO;
        self.messageLabel.backgroundColor = UIColor.clearColor;
        self.messageLabel.userInteractionEnabled = NO;
        [self.baseView addSubview:self.messageLabel];
        
        [self.messageLabel top:self.baseView.topAnchor padding:0];;
        [self.messageLabel leading:self.iconImage.trailingAnchor padding:10];
        [self.messageLabel trailing:self.baseView.trailingAnchor padding:-10];
        [self.messageLabel bottom:self.baseView.bottomAnchor padding:0];
        
    }
    
    return self;
}

@end
