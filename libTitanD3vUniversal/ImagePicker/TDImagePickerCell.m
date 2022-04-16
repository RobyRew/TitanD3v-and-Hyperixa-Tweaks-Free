#include <notify.h>
#include "TDImagePickerCell.h"

@implementation TDImagePickerCell

-(id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 specifier:(PSSpecifier*)arg3 {

	self = [super initWithStyle:arg1 reuseIdentifier:arg2 specifier:arg3];

	if (self) {

		arg3.properties[@"height"] = [NSNumber numberWithInt:70];

		listController = [arg3 target];
		[arg3 setTarget:self];

		self.key = [[arg3 properties] valueForKey:@"key"];
		self.defaults = [[arg3 properties] valueForKey:@"defaults"];
		self.usesJPEG = [[arg3 properties] valueForKey:@"usesJPEG"] ? [[[arg3 properties] valueForKey:@"usesJPEG"] boolValue] : NO;
		self.usesGIF = [[arg3 properties] valueForKey:@"usesGIF"] ? [[[arg3 properties] valueForKey:@"usesGIF"] boolValue] : NO;
		self.compressionQuality = [[arg3 properties] valueForKey:@"compressionQuality"] ? [[[arg3 properties] valueForKey:@"compressionQuality"] floatValue] : 1.0;
		self.allowsVideos = [[arg3 properties] valueForKey:@"allowsVideos"] ? [[[arg3 properties] valueForKey:@"allowsVideos"] boolValue] : NO;
		self.videoPath = [[arg3 properties] valueForKey:@"videoPath"];


		self.tintColour = [[TDAppearance sharedInstance] tintColour];
		self.containerColour = [[TDAppearance sharedInstance] containerColour];
		self.borderColour = [[TDAppearance sharedInstance] borderColour];

		NSString *customIconPath = [NSString stringWithFormat:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/%@.png", arg3.properties[@"iconName"]];


		self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(13,15,40,40)];
		self.iconImage.image = [[UIImage imageWithContentsOfFile:customIconPath]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		        self.iconImage.layer.cornerRadius = 20;
        self.iconImage.clipsToBounds = true;
		[self addSubview:self.iconImage];


		self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(65,17.5,200,20)];
		self.headerLabel.text = [[arg3 properties] valueForKey:@"title"];
		[self.headerLabel setFont:[self.headerLabel.font fontWithSize:15]];
		[self addSubview:self.headerLabel];

		self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65,35,200,20)];
		self.subtitleLabel.text = [[arg3 properties] valueForKey:@"subtitle"];
		[self.subtitleLabel setFont:[self.subtitleLabel.font fontWithSize:10]];
		[self addSubview:self.subtitleLabel];


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
	[listController presentViewController:picker animated:YES completion:nil];
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


						previewImage.image = image;
					}
				}];
			}

			[listController dismissViewControllerAnimated:YES completion:^{
				[spinner stopAnimating];
			}];
		}
	}
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

	[listController dismissViewControllerAnimated:YES completion:nil];

}


- (void)setFrame:(CGRect)frame {
	inset = 10;
	frame.origin.x += inset;
	frame.size.width -= 2 * inset;
	[super setFrame:frame];
}

@end
