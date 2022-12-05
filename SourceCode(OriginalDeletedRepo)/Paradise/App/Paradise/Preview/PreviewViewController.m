#import "PreviewViewController.h"

static float iconSize;
static float iconTop;
static float iconLeading;

@implementation PreviewViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;

  [self layoutWallpaper];
  [self layoutDeviceSize];
  [self layoutPreviewIcon];
  [self layoutDismissButton];

}


-(void)layoutDeviceSize {

  if (iPhone_6_8) {

    self.wallpaperImage.image = [UIImage imageNamed:@"preview-wallpaper-8"];
    iconSize = 62;
    iconTop = 268;
    iconLeading = 22;

  } else if (iPhone_6_8_Plus) {

    self.wallpaperImage.image = [UIImage imageNamed:@"preview-wallpaper-8-Plus"];
    iconSize = 68;
    iconTop = 297;
    iconLeading = 25;

  } else if (iPhone_X_XS_11Pro) {

    self.wallpaperImage.image = [UIImage imageNamed:@"preview-wallpaper"];
    iconSize = 62;
    iconTop = 268;
    iconLeading = 22;

  } else if (iPhone_XR_XS_11Pro) {

    self.wallpaperImage.image = [UIImage imageNamed:@"preview-wallpaper"];
    iconSize = 68;
    iconTop = 297;
    iconLeading = 25;

  } else if (iPhone_12_Pro) {

    self.wallpaperImage.image = [UIImage imageNamed:@"preview-wallpaper"];
    iconSize = 62;
    iconTop = 268;
    iconLeading = 22;

  } else if (iPhone_12_mini) {

    self.wallpaperImage.image = [UIImage imageNamed:@"preview-wallpaper-8-Plus"];
    iconSize = 68;
    iconTop = 297;
    iconLeading = 25;

  } else if (iPhone_12_Pro_Max) {

    self.wallpaperImage.image = [UIImage imageNamed:@"preview-wallpaper"];
    iconSize = 68;
    iconTop = 297;
    iconLeading = 25;

  }

}


-(void)layoutWallpaper {

  self.wallpaperImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:self.wallpaperImage];

}


-(void)layoutPreviewIcon {

  self.previewImage = [[UIImageView alloc] init];
  self.previewImage.layer.cornerRadius = 14;
  self.previewImage.clipsToBounds = true;
  [self.view addSubview:self.previewImage];

  self.previewImage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.previewImage.widthAnchor constraintEqualToConstant:iconSize].active = YES;
  [self.previewImage.heightAnchor constraintEqualToConstant:iconSize].active = YES;
  [self.previewImage.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:iconTop].active = YES;
  [self.previewImage.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:iconLeading].active = YES;


  self.appLabel = [[UILabel alloc] init];
  self.appLabel.textAlignment = NSTextAlignmentCenter;
  self.appLabel.textColor = UIColor.whiteColor;
  self.appLabel.font = [UIFont systemFontOfSize:13];
  self.appLabel.text = @"Your App";
  [self.view addSubview:self.appLabel];

  self.appLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.appLabel.topAnchor constraintEqualToAnchor:self.previewImage.bottomAnchor constant:7].active = YES;
  [self.appLabel.centerXAnchor constraintEqualToAnchor:self.previewImage.centerXAnchor].active = true;

}


-(void)layoutDismissButton {

  self.dismissButton = [[UIButton alloc] init];
    self.dismissButton.backgroundColor = [UIColor colorNamed:@"Accent"];
  self.dismissButton.layer.cornerRadius = 25;
  [self.dismissButton setTitle:@"Close" forState:UIControlStateNormal];
  self.dismissButton.titleLabel.font = [UIFont systemFontOfSize:15];
  [self.dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.dismissButton addTarget:self action:@selector(dismissPreviewVC) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.dismissButton];

  self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.dismissButton.widthAnchor constraintEqualToConstant:150].active = YES;
  [self.dismissButton.heightAnchor constraintEqualToConstant:50].active = YES;
  [self.dismissButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;
  [[self.dismissButton centerXAnchor] constraintEqualToAnchor:self.view.centerXAnchor].active = true;
}


-(void)dismissPreviewVC {
  [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  if (touches.anyObject.view == self.view) {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"IconEditorDismissed" object:self];
  }
}


@end
