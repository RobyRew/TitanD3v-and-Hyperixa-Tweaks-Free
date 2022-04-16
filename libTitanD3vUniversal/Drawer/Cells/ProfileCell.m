#import "ProfileCell.h"

@implementation ProfileCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {


    self.baseView = [[UIView alloc] initWithFrame:CGRectZero];
    self.baseView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
    self.baseView.layer.cornerRadius = 10;
    if(@available(iOS 13.0, *)) {
      self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    }
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
        self.iconImage.layer.cornerRadius = 22.5;
    self.iconImage.clipsToBounds = true;
    [self.baseView addSubview:self.iconImage];

    self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.iconImage.widthAnchor constraintEqualToConstant:45].active = YES;
    [self.iconImage.heightAnchor constraintEqualToConstant:45].active = YES;
    [[self.iconImage centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
    [self.iconImage.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10.0].active = YES;


    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.7];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.baseView addSubview:self.titleLabel];

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleLabel.widthAnchor constraintEqualToConstant:170.0].active = YES;
    [[self.titleLabel centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.iconImage.trailingAnchor constant:10.0].active = YES;


    self.textField = [[UITextField alloc] init];
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.delegate = self;
    self.textField.backgroundColor = UIColor.clearColor;
    self.textField.textColor = UIColor.whiteColor;
    [self.baseView addSubview:self.textField];

    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textField.leadingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:10].active = YES;
    [self.textField.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-10].active = YES;
    [self.textField.topAnchor constraintEqualToAnchor:self.baseView.topAnchor constant:10].active = YES;
    [self.textField.bottomAnchor constraintEqualToAnchor:self.baseView.bottomAnchor constant:-10].active = YES;
  }

  return self;
}

@end
