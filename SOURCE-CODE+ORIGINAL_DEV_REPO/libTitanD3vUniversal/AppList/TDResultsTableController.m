#import "TDResultsTableController.h"

@implementation TDResultsTableController
- (void)viewDidLoad {
  [super viewDidLoad];

  self.searchTable =
  [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  self.searchTable.backgroundColor = [UIColor clearColor];
  self.view.backgroundColor = [UIColor colorWithRed:53 / 255.0 green:59 / 255.0 blue:68.0 / 255.0 alpha:0.95];
  self.searchTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
  [self.view addSubview:self.searchTable];
}
@end
