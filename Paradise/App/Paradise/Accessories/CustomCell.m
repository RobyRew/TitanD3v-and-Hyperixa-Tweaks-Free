//#import "CustomCell.h"
//
//@implementation CustomCell
//
//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    if (self) {
//        
//        self.baseView = [[UIView alloc] init];
//        self.baseView.backgroundColor = [UIColor redColor];
//        self.baseView.layer.cornerRadius = 15;
//        self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
//        self.baseView.clipsToBounds = true;
//        [self.contentView addSubview:self.baseView];
//        
//        [self.baseView top:self.topAnchor padding:5];
//        [self.baseView leading:self.leadingAnchor padding:0];
//        [self.baseView trailing:self.trailingAnchor padding:0];
//        [self.baseView bottom:self.bottomAnchor padding:0];
//        
//    }
//    
//    return self;
//}
//
//@end
