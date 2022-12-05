#include <notify.h>
#include "TDImageListCell.h"

@implementation TDImageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	specifier.properties[@"height"] = [NSNumber numberWithInt:70];

	if (self) {


		self.key = [[specifier properties] valueForKey:@"key"];
		self.defaults = [[specifier properties] valueForKey:@"defaults"];
		self.usesJPEG = [[specifier properties] valueForKey:@"usesJPEG"] ? [[[specifier properties] valueForKey:@"usesJPEG"] boolValue] : NO;
		self.usesGIF = [[specifier properties] valueForKey:@"usesGIF"] ? [[[specifier properties] valueForKey:@"usesGIF"] boolValue] : NO;
		self.compressionQuality = [[specifier properties] valueForKey:@"compressionQuality"] ? [[[specifier properties] valueForKey:@"compressionQuality"] floatValue] : 1.0;
		self.allowsVideos = [[specifier properties] valueForKey:@"allowsVideos"] ? [[[specifier properties] valueForKey:@"allowsVideos"] boolValue] : NO;
		self.videoPath = [[specifier properties] valueForKey:@"videoPath"];
        self.saveImageToFolder = [[specifier properties] valueForKey:@"saveImageToFolder"] ? [[[specifier properties] valueForKey:@"saveImageToFolder"] boolValue] : NO;
		self.formatterPNG = [[specifier properties] valueForKey:@"formatterPNG"] ? [[[specifier properties] valueForKey:@"formatterPNG"] boolValue] : NO;
self.imageName = [[specifier properties] valueForKey:@"imageName"];
self.folderPath = [[specifier properties] valueForKey:@"folderPath"];

		self.tintColour = [[TDAppearance sharedInstance] tintColour];
		self.containerColour = [[TDAppearance sharedInstance] containerColour];
		self.borderColour = [[TDAppearance sharedInstance] borderColour];

self.baseView = [[UIView alloc] initWithFrame:self.bounds];
self.baseView.backgroundColor = [[TDAppearance sharedInstance] cellColour];
[self addSubview:self.baseView];


		self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(13,15,40,40)];
		self.iconImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/photo.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		self.iconImage.tintColor = self.tintColour;
		[self addSubview:self.iconImage];


		self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(65,25,200,20)];
		self.headerLabel.text = [[specifier properties] valueForKey:@"title"];
		[self.headerLabel setFont:[self.headerLabel.font fontWithSize:15]];
		[self addSubview:self.headerLabel];

	}

	return self;
}


- (id)target {
	return self;
}


- (id)cellTarget {
	return self;
}


- (SEL)action {
	return @selector(chooseImage);
}


- (SEL)cellAction {
	return @selector(chooseImage);
}


-(void)didMoveToWindow {
	[super didMoveToWindow];

	[self.specifier setTarget:self];
	[self.specifier setButtonAction:@selector(chooseImage)];


	if (!previewImage) {

		previewImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 50, 50)];
		[previewImage setContentMode:UIViewContentModeScaleAspectFill];
		[previewImage setClipsToBounds:YES];
		previewImage.layer.cornerRadius = 12;
		[self setAccessoryView:previewImage];


		NSString *bundleID = self.defaults;
		NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
		NSMutableDictionary *settings = [NSMutableDictionary dictionary];
		[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];


		NSData* data = [settings objectForKey:self.key];
		UIImage* img = [UIImage imageWithData:data];
		if (img) {

			previewImage.image = img;


		} else if (self.videoPath) {

			NSURL* fileURL = [NSURL fileURLWithPath:self.videoPath];
			//get image from video
			AVURLAsset* asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
			AVAssetImageGenerator* imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
			UIImage* image = [UIImage imageWithCGImage:[imageGenerator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:nil error:nil]];
			previewImage.image = image;
		}

		if (img) {

			previewImage.layer.borderWidth = 1;
			previewImage.layer.borderColor = self.borderColour.CGColor;

		}

	}
}


-(void)chooseImage {

	UIImagePickerController* picker = [[UIImagePickerController alloc] init];
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

	if (self.allowsVideos) {

		picker.mediaTypes = @[(NSString*)kUTTypeImage, (NSString*)kUTTypeMovie];
	}

	picker.delegate = self;
	UIViewController *prefsController = [self _viewControllerForAncestor];
	[prefsController presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	spinner.frame = picker.view.frame;
	spinner.hidesWhenStopped = YES;
	[picker.view addSubview:spinner];
	[spinner startAnimating];

	NSURL* refURL = [info objectForKey:UIImagePickerControllerReferenceURL];
	if (refURL) {

		PHAsset* asset = [[PHAsset fetchAssetsWithALAssetURLs:@[refURL] options:nil] lastObject];

		if (asset) {

			if (asset.isVideo) {

				//user chose a video
				[[PHImageManager defaultManager] requestExportSessionForVideo:asset options:nil exportPreset:AVAssetExportPresetHighestQuality resultHandler:^(AVAssetExportSession* exportSession, NSDictionary* info) {
					NSURL* fileURL = [NSURL fileURLWithPath:self.videoPath];
					exportSession.outputURL = fileURL;

					if ([[self.videoPath lowercaseString] hasSuffix:@".mov"]) {

						exportSession.outputFileType = AVFileTypeQuickTimeMovie;

					} else {

						exportSession.outputFileType = AVFileTypeMPEG4;
					}

					[exportSession exportAsynchronouslyWithCompletionHandler:^{
						//get image from video
						AVURLAsset* asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
						AVAssetImageGenerator* imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
						UIImage* image = [UIImage imageWithCGImage:[imageGenerator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:nil error:nil]];
						previewImage.image = image;
					}];
				}];


			} else {

				//delete video
				if (self.videoPath) {

					[[NSFileManager defaultManager] removeItemAtPath:self.videoPath error:nil];
				}

				//user chose an image
				[[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable data, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {

					if (data) {

						UIImage* image = [UIImage imageWithData:data];

						if (self.usesJPEG) {

							data = UIImageJPEGRepresentation(image, self.compressionQuality);

						} else if (!self.usesGIF) {

							data = UIImagePNGRepresentation(image);
						}

						NSString *bundleID = self.defaults;
						NSString *prefsPath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", bundleID];
						NSMutableDictionary *settings = [NSMutableDictionary dictionary];
						[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];

						[settings setObject:data forKey:self.key];
						[settings writeToFile:prefsPath atomically:YES];

if (self.saveImageToFolder) {

	if (self.formatterPNG) {
	NSString *imageNameString = [NSString stringWithFormat:@"%@.png", self.imageName];
    NSString *imageString = [self.folderPath stringByAppendingPathComponent:imageNameString];
    NSData *imageData = UIImagePNGRepresentation(image); 
    [imageData writeToFile:imageString atomically:YES];
	} else {
	NSString *imageNameString = [NSString stringWithFormat:@"%@.jpg", self.imageName];
    NSString *imageString = [self.folderPath stringByAppendingPathComponent:imageNameString];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    [imageData writeToFile:imageString atomically:YES];	
	}
	
}

						previewImage.image = image;
					}
				}];
			}

UIViewController *prefsController = [self _viewControllerForAncestor];
			[prefsController dismissViewControllerAnimated:YES completion:^{
				[spinner stopAnimating];
			}];
		}
	}
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    UIViewController *prefsController = [self _viewControllerForAncestor];
	[prefsController dismissViewControllerAnimated:YES completion:nil];

}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}


- (void)layoutSubviews {
	[super layoutSubviews];
	self.baseView.frame = self.bounds;
}

@end
