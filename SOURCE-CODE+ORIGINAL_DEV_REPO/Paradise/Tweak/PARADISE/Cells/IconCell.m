#import "IconCell.h"

static UIFontDescriptor *descriptor;

@implementation IconCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {

    loadPrefs();
    descriptor = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIFontDescriptor class] fromData:appdataCustomFont error:nil];

    self.baseView = [[UIView alloc] init];
    self.baseView.clipsToBounds = true;
    [self.contentView addSubview:self.baseView];

    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5].active = YES;
    [self.baseView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-5].active = YES;
    [self.baseView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
    [self.baseView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = YES;


    self.accessoriesImage = [[UIImageView alloc] init];
    self.accessoriesImage.layer.cornerRadius = 15;
    self.accessoriesImage.clipsToBounds = true;
    [self.baseView addSubview:self.accessoriesImage];

    self.accessoriesImage.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.accessoriesImage centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
    [self.accessoriesImage.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-10].active = YES;
    [self.accessoriesImage.heightAnchor constraintEqualToConstant:30].active = YES;
    [self.accessoriesImage.widthAnchor constraintEqualToConstant:30].active = YES;


    self.titleLabel = [[UILabel alloc] init];
    if (toggleAppdataCustomFont) {
      self.titleLabel.font = [UIFont fontWithDescriptor:descriptor size:18];
    } else {
      self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor appdataFontColor];
    [self.baseView addSubview:self.titleLabel];

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.titleLabel centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor constant:-10].active = true;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10].active = YES;
    [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.accessoriesImage.leadingAnchor constant:-15].active = YES;
    [self.titleLabel.heightAnchor constraintEqualToConstant:18.0].active = YES;


    self.subtitleLabel = [[TDMarqueeLabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.textColor = [UIColor appdataFontColor];
    if (toggleAppdataCustomFont) {
      self.subtitleLabel.font = [UIFont fontWithDescriptor:descriptor size:14];
    } else {
      self.subtitleLabel.font = [UIFont systemFontOfSize:14];
    }
    self.subtitleLabel.backgroundColor = [UIColor clearColor];
    self.subtitleLabel.labelSpacing = 60;
    self.subtitleLabel.pauseInterval = 0.8;
    self.subtitleLabel.scrollSpeed = 50;
    self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
    self.subtitleLabel.fadeLength = 12.f;
    self.subtitleLabel.scrollDirection = TDMarqueeLabelDirectionLeft;
    [self.baseView addSubview:self.subtitleLabel];

    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.subtitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:10].active = YES;
    [self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor constant:10].active = YES;
    [self.subtitleLabel.trailingAnchor constraintEqualToAnchor:self.accessoriesImage.leadingAnchor constant:-15].active = YES;
    [self.subtitleLabel.heightAnchor constraintEqualToConstant:14].active = YES;


  }

  return self;
}


@end
