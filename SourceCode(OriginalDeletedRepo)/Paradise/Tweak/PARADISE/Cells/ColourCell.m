#import "ColourCell.h"

static UIFontDescriptor *descriptor;

@implementation ColourCell

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
    self.accessoriesImage.tintColor = [UIColor appdataIconColor];
    self.accessoriesImage.image = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/colour-picker.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.accessoriesImage.layer.cornerRadius = 15;
    self.accessoriesImage.clipsToBounds = true;
    [self.baseView addSubview:self.accessoriesImage];

    self.accessoriesImage.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.accessoriesImage centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor].active = true;
    [self.accessoriesImage.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor constant:-10].active = YES;
    [self.accessoriesImage.heightAnchor constraintEqualToConstant:30].active = YES;
    [self.accessoriesImage.widthAnchor constraintEqualToConstant:30].active = YES;


    self.colourView = [[UIView alloc] init];
    self.colourView.layer.cornerRadius = 10;
    self.colourView.clipsToBounds = true;
    [self.baseView addSubview:self.colourView];

    [self.colourView size:CGSizeMake(20, 20)];
    [self.colourView x:self.accessoriesImage.centerXAnchor];
    [self.colourView y:self.accessoriesImage.centerYAnchor];


    self.titleLabel = [[UILabel alloc] init];
    if (toggleAppdataCustomFont) {
      self.titleLabel.font = [UIFont fontWithDescriptor:descriptor size:14];
    } else {
      self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor appdataFontColor];
    [self.baseView addSubview:self.titleLabel];

    [self.titleLabel leading:self.baseView.leadingAnchor padding:10];
    [self.titleLabel trailing:self.accessoriesImage.leadingAnchor padding:-10];
    [self.titleLabel y:self.baseView.centerYAnchor];

  }

  return self;
}


@end
