#import "BubbleCell.h"

@implementation BubbleCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if (self) {

    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = UIColor.clearColor;
    self.baseView.clipsToBounds = true;
    [self addSubview:self.baseView];

    [self.baseView top:self.topAnchor padding:5];
    [self.baseView leading:self.leadingAnchor padding:10];
    [self.baseView trailing:self.trailingAnchor padding:-10];
    [self.baseView bottom:self.bottomAnchor padding:-5];

  }

  return self;
}

@end
