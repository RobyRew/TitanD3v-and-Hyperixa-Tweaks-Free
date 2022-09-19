#import "MessageView.h"

@implementation MessageView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {


    self.icon = [[UIImageView alloc] init];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.icon];

    [self.icon size:CGSizeMake(70, 70)];
    [self.icon x:self.centerXAnchor];
    [self.icon top:self.topAnchor padding:10];


    self.title = [[UILabel alloc] init];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = UIColor.tertiaryLabelColor;
    self.title.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    self.title.numberOfLines = 2;
    [self addSubview:self.title];

    [self.title x:self.centerXAnchor];
    [self.title top:self.icon.bottomAnchor padding:15];
    [self.title leading:self.leadingAnchor padding:15];
    [self.title trailing:self.trailingAnchor padding:-15];

  }

  return self;

}

@end
