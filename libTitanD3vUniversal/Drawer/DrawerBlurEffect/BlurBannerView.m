#import "BlurBannerView.h"

extern CFArrayRef CPBitmapCreateImagesFromData(CFDataRef cpbitmap, void*, int, void*);

@implementation BlurBannerView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {


    NSData *wallpaperData = [NSData dataWithContentsOfFile:@"/User/Library/SpringBoard/OriginalLockBackground.cpbitmap"];
    CFArrayRef wallpaperArrayRef = CPBitmapCreateImagesFromData((__bridge CFDataRef)wallpaperData, NULL, 1, NULL);
    NSArray *wallpaperArray = (__bridge NSArray *)wallpaperArrayRef;
    UIImage *wallpaper = [[UIImage alloc] initWithCGImage:(__bridge CGImageRef)(wallpaperArray[0])];
    CFRelease(wallpaperArrayRef);

    self.backgroundImage = [[UIImageView alloc] init];
    self.backgroundImage.image = wallpaper;
    [self addSubview:self.backgroundImage];

    self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false;
    [self.backgroundImage.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.backgroundImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [self.backgroundImage.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [self.backgroundImage.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;


    self.blurEffectView = [[UIVisualEffectView alloc] init];
    self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    [self addSubview:self.blurEffectView];

    self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    [self.blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;


  }

  return self;

}


@end
