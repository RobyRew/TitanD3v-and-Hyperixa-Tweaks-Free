#import "ChangelogCell.h"

@implementation ChangelogCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.layer.cornerRadius = 30;
        self.contentView.layer.cornerCurve = kCACornerCurveContinuous;
        self.contentView.clipsToBounds = true;
        
        
        self.baseView = [[UIView alloc] initWithFrame:CGRectZero];
        self.baseView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
        self.baseView.layer.cornerRadius = 30;
        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
        self.baseView.clipsToBounds = true;
        self.baseView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
        self.baseView.layer.borderWidth = 0.5;
        [self.contentView addSubview:self.baseView];
        
        self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.baseView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
        [self.baseView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10].active = YES;
        [self.baseView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
        [self.baseView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = YES;
        
        
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.iconImage.layer.cornerRadius = 27.5;
        self.iconImage.clipsToBounds = true;
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(55, 55)];
        [self.iconImage top:self.baseView.topAnchor padding:15];
        [self.iconImage leading:self.baseView.leadingAnchor padding:15];
        
        
        self.categoriesView = [[UIView alloc] init];
        self.categoriesView.backgroundColor = [UIColor colorWithRed: 0.94 green: 0.27 blue: 0.18 alpha: 0.5];
        self.categoriesView.layer.cornerRadius = 5;
        self.categoriesView.layer.cornerCurve = kCACornerCurveContinuous;
        [self.baseView addSubview:self.categoriesView];
        
        [self.categoriesView height:25];
        [self.categoriesView width:100];
        [self.categoriesView top:self.iconImage.topAnchor padding:0];
        [self.categoriesView leading:self.iconImage.trailingAnchor padding:10];
        
        
        self.categoriesLabel = [[UILabel alloc] init];
        self.categoriesLabel.font = [UIFont boldSystemFontOfSize:14];
        self.categoriesLabel.textColor = UIColor.whiteColor;
        [self.categoriesView addSubview:self.categoriesLabel];
        
        [self.categoriesLabel x:self.categoriesView.centerXAnchor y:self.categoriesView.centerYAnchor];
        
        
        self.versionView = [[UIView alloc] init];
        self.versionView.backgroundColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 1.0];
        self.versionView.layer.cornerRadius = 5;
        self.versionView.layer.cornerCurve = kCACornerCurveContinuous;
        [self.baseView addSubview:self.versionView];
        
        [self.versionView height:20];
        [self.versionView width:70];
        [self.versionView bottom:self.iconImage.bottomAnchor padding:0];
        [self.versionView leading:self.iconImage.trailingAnchor padding:10];
        
        
        self.versionLabel = [[UILabel alloc] init];
        self.versionLabel.text = @"v1.1";
        self.versionLabel.font = [UIFont systemFontOfSize:12];
        self.versionLabel.textColor = UIColor.whiteColor;
        [self.versionView addSubview:self.versionLabel];
        
        [self.versionLabel x:self.versionView.centerXAnchor y:self.versionView.centerYAnchor];
        
        
        self.splitView = [[UIView alloc] init];
        self.splitView.backgroundColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5];
        self.splitView.layer.cornerRadius = 1;
        [self.baseView addSubview:self.splitView];
        
        [self.splitView height:2];
        [self.splitView x:self.baseView.centerXAnchor];
        [self.splitView top:self.iconImage.bottomAnchor padding:15];
        [self.splitView leading:self.baseView.leadingAnchor padding:20];
        [self.splitView trailing:self.baseView.trailingAnchor padding:-20];
        
        
        self.messageLabel = [[UITextView alloc] init];
        self.messageLabel.font = [UIFont systemFontOfSize:18];
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
        self.messageLabel.delegate = self;
        self.messageLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.8];
        self.messageLabel.scrollEnabled = NO;
        self.messageLabel.editable = NO;
        self.messageLabel.backgroundColor = UIColor.clearColor;
        self.messageLabel.userInteractionEnabled = NO;
        [self.baseView addSubview:self.messageLabel];
        
        [self.messageLabel top:self.splitView.bottomAnchor padding:5];;
        [self.messageLabel leading:self.baseView.leadingAnchor padding:15];
        [self.messageLabel trailing:self.baseView.trailingAnchor padding:-15];
        [self.messageLabel bottom:self.baseView.bottomAnchor padding:-10];
        
        
    }
    
    return self;
}

@end
