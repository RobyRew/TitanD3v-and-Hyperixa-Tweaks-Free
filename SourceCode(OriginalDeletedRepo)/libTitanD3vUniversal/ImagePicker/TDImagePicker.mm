#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "TDImagePicker.h"

UIImage *TDParseImage(NSData *imageDataFromPrefs)
{
    return [UIImage imageWithData:imageDataFromPrefs];
}
