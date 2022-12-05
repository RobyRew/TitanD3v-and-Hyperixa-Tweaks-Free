//#import "LibraryCell.h"
//
//@implementation LibraryCell
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        self.layer.cornerRadius = 20;
//        
//        self.clipsToBounds = true;
//        self.layer.cornerRadius = 20;
//        
//        self.baseView = [[UIView alloc] init];
//        self.baseView.layer.cornerRadius = 20;
//        self.baseView.backgroundColor = [UIColor colorNamed:@"Cell Background"];
//        self.baseView.clipsToBounds = true;
//        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
//        [self.contentView addSubview:self.baseView];
//        
//        [self.baseView fill];
//        
//        
//        self.previewImage = [[UIImageView alloc] init];
//        self.previewImage.contentMode = UIViewContentModeScaleAspectFill;
//        [self.baseView addSubview:self.previewImage];
//        
//        [self.previewImage fill];
//        
//        
//        self.deleteButton = [[UIButton alloc] init];
//        [self.deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        UIImage *btnImage = [UIImage systemImageNamed:@"trash.fill"];
//        [self.deleteButton setImage:btnImage forState:UIControlStateNormal];
//        self.deleteButton.tintColor = UIColor.systemRedColor;
//        [self.baseView addSubview:self.deleteButton];
//        
//        [self.deleteButton top:self.baseView.topAnchor padding:10];
//        [self.deleteButton trailing:self.baseView.trailingAnchor padding:-10];
//        [self.deleteButton size:CGSizeMake(30, 30)];
//        
//        
//        self.titleLabel = [[UILabel alloc] init];
//        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.titleLabel.textColor = UIColor.whiteColor;
//        [self.baseView addSubview:self.titleLabel];
//        
//        [self.titleLabel bottom:self.baseView.bottomAnchor padding: -10];
//        [self.titleLabel x:self.baseView.centerXAnchor];
//        [self.titleLabel leading:self.baseView.leadingAnchor padding:5];
//        [self.titleLabel trailing:self.baseView.trailingAnchor padding:-5];
//        
//    }
//    return self;
//}
//
//
//- (void)deleteButtonPressed:(id)sender {
//  [self.libraryDelegate deleteLibraryForCell:self];  
//}
//
//@end
