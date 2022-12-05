#import "RecipientCell.h"

@implementation RecipientCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {

    loadPrefs();


    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = [UIColor clearColor];
    self.baseView.layer.cornerRadius = 15;
    self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    self.baseView.clipsToBounds = true;
    [self addSubview:self.baseView];

    [self.baseView top:self.topAnchor padding:5];
    [self.baseView leading:self.leadingAnchor padding:5];
    [self.baseView trailing:self.trailingAnchor padding:-5];
    [self.baseView bottom:self.bottomAnchor padding:-5];


    self.avatarImage = [[UIImageView alloc] init];
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImage.layer.cornerRadius = 20;
    self.avatarImage.clipsToBounds = true;
    [self.baseView addSubview:self.avatarImage];

    [self.avatarImage size:CGSizeMake(40, 40)];
    [self.avatarImage top:self.baseView.topAnchor padding:5];
    [self.avatarImage leading:self.baseView.leadingAnchor padding:15];


    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor fontColour];
    self.nameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    [self.baseView addSubview:self.nameLabel];

    [self.nameLabel top:self.avatarImage.topAnchor padding:5];
    [self.nameLabel leading:self.avatarImage.trailingAnchor padding:10];


    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];

    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = [UIColor fontColour];
    self.timeLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.timeLabel.text = [outputFormatter stringFromDate:now];
    [self.baseView addSubview:self.timeLabel];

    [self.timeLabel bottom:self.avatarImage.bottomAnchor padding:-5];
    [self.timeLabel leading:self.avatarImage.trailingAnchor padding:10];


    self.bubbleView = [[UIView alloc] init];
    self.bubbleView.layer.cornerRadius = 20;
    self.bubbleView.layer.maskedCorners = 14;
    [self.baseView addSubview:self.bubbleView];

    [self.bubbleView size:CGSizeMake(200, 90)];
    [self.bubbleView top:self.avatarImage.bottomAnchor padding:10];
    [self.bubbleView leading:self.baseView.leadingAnchor padding:15];


    self.bubbleLabel = [[UILabel alloc] init];
    self.bubbleLabel.textAlignment = NSTextAlignmentLeft;
    self.bubbleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    self.bubbleLabel.numberOfLines = 3;
    self.bubbleLabel.text = @"Write something that \nyou would like to \nsay to me.";
    [self.bubbleView addSubview:self.bubbleLabel];

    [self.bubbleLabel top:self.bubbleView.topAnchor padding:5];
    [self.bubbleLabel leading:self.bubbleView.leadingAnchor padding:10];
    [self.bubbleLabel trailing:self.bubbleView.trailingAnchor padding:-5];
    [self.bubbleLabel bottom:self.bubbleView.bottomAnchor padding:-5];


    if (!toggleCustomColour) {

      if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
        self.bubbleView.backgroundColor = [UIColor colorWithRed: 0.15 green: 0.15 blue: 0.16 alpha: 1.00];
        self.bubbleLabel.textColor = UIColor.whiteColor;
      } else {
        self.bubbleView.backgroundColor = [UIColor colorWithRed: 0.91 green: 0.91 blue: 0.92 alpha: 1.00];
        self.bubbleLabel.textColor = UIColor.blackColor;
      }

    } else {
      self.bubbleView.backgroundColor = [UIColor recipientBubbleColour];
      self.bubbleLabel.textColor = [UIColor recipientBubbleFontColour];
    }

  }

  return self;
}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {

  if (!toggleCustomColour) {

    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
      self.bubbleView.backgroundColor = [UIColor colorWithRed: 0.15 green: 0.15 blue: 0.16 alpha: 1.00];
      self.bubbleLabel.textColor = UIColor.whiteColor;
    } else {
      self.bubbleView.backgroundColor = [UIColor colorWithRed: 0.91 green: 0.91 blue: 0.92 alpha: 1.00];
      self.bubbleLabel.textColor = UIColor.blackColor;
    }

  } else {
    self.bubbleView.backgroundColor = [UIColor recipientBubbleColour];
    self.bubbleLabel.textColor = [UIColor recipientBubbleFontColour];
  }

}

@end
