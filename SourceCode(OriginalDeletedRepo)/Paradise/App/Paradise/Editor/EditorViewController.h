#import <UIKit/UIKit.h>
#import "Preferences.h"
#import "ConstraintExtension.h"  
#import "Macros.h"
#import "ParadiseSegmentControl.h"
#import "ToolsCell.h"
#import "EditorCell.h"
#import "ColourCell.h"
#import "IconsViewController.h"
#import "PreviewViewController.h"
#import "TutorialViewController.h"
#import "AppManager.h"

@interface EditorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, ToolsButtonDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIColorPickerViewControllerDelegate, UIGestureRecognizerDelegate> {
    float iconSize;
    CAGradientLayer *gradient;
    NSInteger colourPickerIndex;
    UIPanGestureRecognizer *panGesture;
    UIPinchGestureRecognizer *pinchGesture;
    UIRotationGestureRecognizer *rotateGesture;
    UIImage *tempImage;
    UIColor *tempColour;
}

@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (nonatomic, retain) UIButton *moreButton;
@property (nonatomic, retain) UIButton *saveButton;
@property (nonatomic, retain) UILabel *appLabel;
@property (nonatomic, retain) UIView *iconView;
@property (nonatomic, retain) UIView *toolsView;
@property (nonatomic, retain) UIButton *resetTransformButton;
@property (nonatomic, retain) UIView *segmentView;
@property (nonatomic, retain) ParadiseSegmentControl *segmentControl;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *editorArray;
@property (nonatomic, retain) UIImageView *backgroundImage;
@property (nonatomic, retain) UIView *gradientView;
@property (nonatomic, retain) UIView *iconContainerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UIColor *primraryColour;
@property (nonatomic, retain) UIColor *secondaryColour;
@property (nonatomic, retain) UIImagePickerController *backgroundImagePickerController;
@property (nonatomic, retain) UIImagePickerController *iconImagePickerController;

@end
