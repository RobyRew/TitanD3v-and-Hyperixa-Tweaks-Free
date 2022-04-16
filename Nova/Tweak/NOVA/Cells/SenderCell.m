#import "SenderCell.h"

@implementation SenderCell

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
    if (senderAvatarImage != nil) {
    self.avatarImage.image = [UIImage imageWithData:senderAvatarImage];
    } else {
    self.avatarImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Nova.bundle/Assets/avatar.png"];
    }
    self.avatarImage.layer.cornerRadius = 20;
    self.avatarImage.clipsToBounds = true;
    [self.baseView addSubview:self.avatarImage];

    [self.avatarImage size:CGSizeMake(40, 40)];
    [self.avatarImage top:self.baseView.topAnchor padding:5];
    [self.avatarImage trailing:self.baseView.trailingAnchor padding:-15];


    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor fontColour];
    self.nameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    self.nameLabel.text = senderName;
    [self.baseView addSubview:self.nameLabel];

    [self.nameLabel top:self.avatarImage.topAnchor padding:5];
    [self.nameLabel trailing:self.avatarImage.leadingAnchor padding:-10];


    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = [UIColor fontColour];
    self.timeLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.timeLabel.text = @"Just now";
    [self.baseView addSubview:self.timeLabel];

    [self.timeLabel bottom:self.avatarImage.bottomAnchor padding:-5];
    [self.timeLabel trailing:self.avatarImage.leadingAnchor padding:-10];


  }

  return self;
}

@end
