
#import <UIKit/UIKit.h>


@interface NoteViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >
{
    IBOutlet UIView*            viewForTitle ;
    IBOutlet UISegmentedControl* ctrlForNote ;
    
    IBOutlet UIButton*          btnForLogo ;
    IBOutlet UIBarButtonItem*   itemForSearch ;
    
    IBOutlet UITableView*       tblForNote ;
}

@end
