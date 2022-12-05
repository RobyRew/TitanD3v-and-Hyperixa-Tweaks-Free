#import "DateCell.h"

@implementation DateCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {

    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = [UIColor cellColour];
    self.baseView.layer.cornerRadius = 15;
    self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    self.baseView.clipsToBounds = true;
    [self addSubview:self.baseView];

    [self.baseView top:self.topAnchor padding:5];
    [self.baseView leading:self.leadingAnchor padding:10];
    [self.baseView trailing:self.trailingAnchor padding:-10];
    [self.baseView bottom:self.bottomAnchor padding:-5];


    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor fontColour];
    self.titleLabel.text = @"Set date & time";
    [self.baseView addSubview:self.titleLabel];

    [self.titleLabel leading:self.baseView.leadingAnchor padding:10];
    [self.titleLabel y:self.baseView.centerYAnchor];
  }

  return self;
}

@end
