#import <Preferences/Preferences.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIKit/UIKit.h>
#import <Preferences/PSTableCell.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"


@interface UIImage(TD)
+(id)imageAtPath:(id)arg1;
@end


@interface TDImageListCell : PSTableCell <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

  UIImageView* previewImage;
  float inset;
}

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) NSString* key;
@property (nonatomic, retain) NSString* defaults;
@property (nonatomic) BOOL usesJPEG;
@property (nonatomic) BOOL usesGIF;
@property (nonatomic) CGFloat compressionQuality;
@property (nonatomic) BOOL allowsVideos;
@property (nonatomic, retain) NSString* videoPath;
@property (nonatomic, retain) UIColor *containerColour;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *borderColour;

@property (nonatomic) BOOL saveImageToFolder;
@property (nonatomic) BOOL formatterPNG;
@property (nonatomic, retain) NSString* folderPath;
@property (nonatomic, retain) NSString* imageName;

@end

@interface NSUserDefaults (TD)
-(id)objectForKey:(id)arg1 inDomain:(id)arg2;
-(void)setObject:(id)arg1 forKey:(id)arg2 inDomain:(id)arg3;
@end

@interface PHAsset (TD)
@property (nonatomic,readonly) BOOL isVideo;
@end
