#import "ActiveCell.h"

@implementation ActiveCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  if (self) {
    
    loadPrefs();
    
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
    
    
    self.avatarImage = [[UIImageView alloc] init];
    self.avatarImage.layer.cornerRadius = 35;
    self.avatarImage.clipsToBounds = true;
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.baseView addSubview:self.avatarImage];
    
    [self.avatarImage size:CGSizeMake(70, 70)];
    [self.avatarImage top:self.baseView.topAnchor padding:10];
    [self.avatarImage leading:self.baseView.leadingAnchor padding:10];
    
    
    self.recipientLabel = [[UILabel alloc] init];
    self.recipientLabel.font = [UIFont boldSystemFontOfSize:20];
    self.recipientLabel.textAlignment = NSTextAlignmentLeft;
    self.recipientLabel.textColor = [UIColor fontColour];
    [self.baseView addSubview:self.recipientLabel];
    
    [self.recipientLabel top:self.avatarImage.topAnchor padding:5];
    [self.recipientLabel leading:self.avatarImage.trailingAnchor padding:10];
    [self.recipientLabel trailing:self.baseView.trailingAnchor padding:-10];
    
    
    self.messageLabel = [[UITextView alloc] init];
    self.messageLabel.font = [UIFont systemFontOfSize:15];
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    self.messageLabel.delegate = self;
    self.messageLabel.backgroundColor = [UIColor bubbleColour];
    self.messageLabel.layer.cornerRadius = 20;
    self.messageLabel.layer.maskedCorners = 14;
    self.messageLabel.textColor = [UIColor bubbleFontColour];
    self.messageLabel.editable = NO;
    [self.contentView addSubview:self.messageLabel];
    
    [self.messageLabel top:self.recipientLabel.bottomAnchor padding:10];
    [self.messageLabel leading:self.avatarImage.trailingAnchor padding:10];
    [self.messageLabel trailing:self.baseView.trailingAnchor padding:-60];
    [self.messageLabel height:70];
    
    
    self.splitView = [[UIView alloc] init];
    self.splitView.backgroundColor = [UIColor yellowColor];
    self.splitView.layer.cornerRadius = 1;
    [self.baseView addSubview:self.splitView];
    
    [self.splitView x:self.baseView.centerXAnchor];
    [self.splitView height:2];
    [self.splitView top:self.messageLabel.bottomAnchor padding:15];
    [self.splitView leading:self.baseView.leadingAnchor padding:20];
    [self.splitView trailing:self.baseView.trailingAnchor padding:-20];
    
    
    self.remainingView = [[UIView alloc] init];
    self.remainingView.layer.cornerRadius = 8;
    self.remainingView.layer.cornerCurve = kCACornerCurveContinuous;
    self.remainingView.clipsToBounds = true;
    [self.baseView addSubview:self.remainingView];
    
    [self.remainingView size:CGSizeMake(120, 35)];
    [self.remainingView top:self.splitView.bottomAnchor padding:12];
    [self.remainingView leading:self.baseView.leadingAnchor padding:20];
    
    
    self.iconImage = [[UIImageView alloc] init];
    [self.baseView addSubview:self.iconImage];
    
    [self.iconImage size:CGSizeMake(25, 25)];
    [self.iconImage y:self.remainingView.centerYAnchor];
    [self.iconImage leading:self.remainingView.leadingAnchor padding:5];
    
    
    self.remainingLabel = [[UILabel alloc] init];
    self.remainingLabel.font = [UIFont boldSystemFontOfSize:12];
    self.remainingLabel.textAlignment = NSTextAlignmentLeft;
    self.remainingLabel.textColor = [UIColor remainingFontColour];
    [self.remainingView addSubview:self.remainingLabel];
    
    [self.remainingLabel y:self.iconImage.centerYAnchor];
    [self.remainingLabel leading:self.iconImage.trailingAnchor padding:5];
    [self.remainingLabel trailing:self.remainingView.trailingAnchor padding:-5];
    
    
    self.scheduleLabel = [[UILabel alloc] init];
    self.scheduleLabel.font = [UIFont systemFontOfSize:13];
    self.scheduleLabel.textAlignment = NSTextAlignmentRight;
    self.scheduleLabel.numberOfLines = 1;
    self.scheduleLabel.textColor = [UIColor fontColour];
    [self.baseView addSubview:self.scheduleLabel];
    
    [self.scheduleLabel y:self.remainingView.centerYAnchor];
    [self.scheduleLabel leading:self.remainingView.trailingAnchor padding:10];
    [self.scheduleLabel trailing:self.baseView.trailingAnchor padding:-20];
    
    
    if (!toggleCustomColour) {
      
      if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
        self.splitView.backgroundColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.1];
      } else {
        self.splitView.backgroundColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 1.0];
      }
      
    } else {
      self.splitView.backgroundColor = [UIColor separatorColour];
    }
    
  }
  
  return self;
}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {
  
  if (!toggleCustomColour) {
    
    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
      self.splitView.backgroundColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.1];
    } else {
      self.splitView.backgroundColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 1.0];
    }
    
  } else {
    self.splitView.backgroundColor = [UIColor separatorColour];
  }
  
}

@end
