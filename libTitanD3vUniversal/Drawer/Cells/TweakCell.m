#import "TweakCell.h"

@implementation TweakCell

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
        self.iconImage.layer.cornerRadius = 15;
        self.iconImage.layer.cornerCurve = kCACornerCurveContinuous;
        self.iconImage.clipsToBounds = true;
        [self.baseView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(55, 55)];
        [self.iconImage top:self.baseView.topAnchor padding:15];
        [self.iconImage leading:self.baseView.leadingAnchor padding:15];
        
        
        self.nameView = [[UIView alloc] init];
        self.nameView.backgroundColor = UIColor.clearColor;
        [self.baseView addSubview:self.nameView];
        
        [self.nameView height:25];
        [self.nameView top:self.iconImage.topAnchor padding:0];
        [self.nameView leading:self.iconImage.trailingAnchor padding:10];
        [self.nameView trailing:self.baseView.trailingAnchor padding:-10];
        
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.8];
        [self.nameView addSubview:self.nameLabel];
        
        [self.nameLabel y:self.nameView.centerYAnchor];
        [self.nameLabel leading:self.nameView.leadingAnchor padding:0];
        
        
        self.priceView = [[UIView alloc] init];
        self.priceView.backgroundColor = [UIColor colorWithRed: 0.94 green: 0.27 blue: 0.18 alpha: 0.5];
        self.priceView.layer.cornerRadius = 5;
        self.priceView.layer.cornerCurve = kCACornerCurveContinuous;
        [self.baseView addSubview:self.priceView];
        
        [self.priceView height:20];
        [self.priceView width:70];
        [self.priceView bottom:self.iconImage.bottomAnchor padding:0];
        [self.priceView leading:self.iconImage.trailingAnchor padding:10];
        
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.font = [UIFont systemFontOfSize:12];
        self.priceLabel.textColor = UIColor.whiteColor;
        [self.priceView addSubview:self.priceLabel];
        
        [self.priceLabel x:self.priceView.centerXAnchor y:self.priceView.centerYAnchor];
        
        
        self.versionView = [[UIView alloc] init];
        self.versionView.backgroundColor = [UIColor colorWithRed: 0.94 green: 0.27 blue: 0.18 alpha: 0.5];
        self.versionView.layer.cornerRadius = 5;
        self.versionView.layer.cornerCurve = kCACornerCurveContinuous;
        [self.baseView addSubview:self.versionView];
        
        [self.versionView height:20];
        [self.versionView width:70];
        [self.versionView y:self.priceView.centerYAnchor];
        [self.versionView leading:self.priceView.trailingAnchor padding:10];
        
        
        self.versionLabel = [[UILabel alloc] init];
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
        
        
        self.descriptionLabel = [[UITextView alloc] init];
        self.descriptionLabel.font = [UIFont systemFontOfSize:18];
        self.descriptionLabel.textAlignment = NSTextAlignmentLeft;
        self.descriptionLabel.delegate = self;
        self.descriptionLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.8];
        self.descriptionLabel.scrollEnabled = NO;
        self.descriptionLabel.editable = NO;
        self.descriptionLabel.backgroundColor = UIColor.clearColor;
        self.descriptionLabel.userInteractionEnabled = NO;
        [self.baseView addSubview:self.descriptionLabel];
        
        [self.descriptionLabel top:self.splitView.bottomAnchor padding:5];;
        [self.descriptionLabel leading:self.baseView.leadingAnchor padding:15];
        [self.descriptionLabel trailing:self.baseView.trailingAnchor padding:-15];
        [self.descriptionLabel bottom:self.baseView.bottomAnchor padding:-10];
        
        
    }
    
    return self;
}

@end
