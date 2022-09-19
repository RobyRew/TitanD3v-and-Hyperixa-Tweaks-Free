#import "AnimojiPickerCell.h"


@implementation AnimojiPickerCell

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    [self layoutImageView];
}


- (void)layoutImageView {
    
    if (self.puppetImageView) return;
    
    self.puppetImageView = [UIImageView new];
    self.puppetImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.puppetImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.puppetImageView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.puppetImageView];
    
    [self updateImage];
}


- (void)setPuppetName:(NSString *)puppetName {
    _puppetName = [puppetName copy];
    [self updateImage];
}


- (void)updateImage {
    if (!_puppetName.length) return;
    self.puppetImageView.image = [ASAnimoji thumbnailForAnimojiNamed:_puppetName options:nil];
}

@end
