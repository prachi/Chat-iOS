
#import <UIKit/UIKit.h>

@interface ProjectViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >
{
    IBOutlet UIView*            viewForTitle ;
    IBOutlet UISegmentedControl* ctrlForProject ;
    
    IBOutlet UIButton*          btnForLogo ;
    IBOutlet UIBarButtonItem*   itemForSearch ;
    
    IBOutlet UITableView*       tblForProject ;
}

@end
