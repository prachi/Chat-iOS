
#import <UIKit/UIKit.h>


@interface ChatViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >
{
   
    
    IBOutlet UIBarButtonItem *addContact;
    IBOutlet UIButton* btnForLogo ;
    IBOutlet UIBarButtonItem*   itemForSearch ;
    
    IBOutlet UITableView*       tblForChat ;
}

@property (strong,nonatomic) NSMutableArray* groups;
@property (strong,nonatomic) NSMutableArray* groupid;

@end
