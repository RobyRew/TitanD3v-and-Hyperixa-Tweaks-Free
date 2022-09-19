//#import "SettingsViewController.h"
//
//@implementation SettingsViewController
//
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    self.navigationItem.title = @"Settings";
//    self.navigationController.navigationBar.prefersLargeTitles = YES;
//
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
//    
//    
//    //UIButton *test = [[UIButton alloc] init];
//    //[test addTarget:self action:@selector(pageManagementMenu) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.testBtn.menu = [self pageManagementMenu];
//    self.testBtn.showsMenuAsPrimaryAction = true;
//    //test.menu = [self pageManagementMenu];
//    //test.showsMenuAsPrimaryAction = true;
//    
//}
//
//- (IBAction)menuAction:(id)sender {
//    
//    
//   
//    
//}
//
//
//-(UIMenu *)pageManagementMenu {
//  UIAction *addPageAction = [UIAction actionWithTitle:@"Add Note" image:[UIImage systemImageNamed:@"rectangle.stack.fill.badge.plus"] identifier:nil handler:^(UIAction *action) {
//    [self addPage];
//  }];
//
//  UIAction *removePageAction = [UIAction actionWithTitle:@"Remove Note" image:[UIImage systemImageNamed:@"rectangle.stack.fill.badge.minus"] identifier:nil handler:^(UIAction *action) {
//    [self removePage];
//  }];
//  //removePageAction.attributes = (self.pages.count > 1) ? UIMenuElementAttributesDestructive : UIMenuElementAttributesDisabled;
//
//  return [UIMenu menuWithTitle:@"Hi" children:@[removePageAction, addPageAction]];
//}
//
//
//-(void)addPage {
//    
//    self.view.backgroundColor = UIColor.yellowColor;
//    
//}
//
//
//-(void)removePage {
//    
//    self.view.backgroundColor = UIColor.greenColor;
//}
//
//@end
