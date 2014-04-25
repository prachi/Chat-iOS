
#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "AppDelegate.h"


@interface ChatRoomController : UIViewController < UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate >
{
    IBOutlet UITableView*       tblForChat ;
    IBOutlet UIView*            viewForInput ;
    IBOutlet UITextField*       txtForMessage ;
    IBOutlet UISegmentedControl *ctrlForChat;
    IBOutlet UIView *viewForTitle;
    
    IBOutlet UIBarButtonItem *more;
    IBOutlet UIBarButtonItem *btnForSearch;
}

@property (nonatomic, strong ) NSMutableArray* chatMy;
@property (nonatomic, strong ) NSMutableArray* chatAll;
@property (nonatomic, strong ) NSMutableArray* chatSenderMy;
@property (nonatomic, strong ) NSMutableArray* chatSenderAll;
@property (nonatomic, strong ) Firebase* firebase;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSNumber* groupid;
@property (nonatomic, retain) UISegmentedControl *ctrlForChat;
@property  NSInteger selectedIndex;
@property (strong, nonatomic) NSMutableArray* array;

-(IBAction)segmentIndexChanged:(id)sender;


@end
