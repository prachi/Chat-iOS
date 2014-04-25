
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "User.h"
#import "Group.h"
#import "ChatViewController.h"

@interface ContactViewController : UITableViewController

@property ( strong, nonatomic) NSString* group;
@property ( strong, nonatomic) NSMutableArray* contacts;
@property ( strong, nonatomic) NSMutableArray* groupMembers;

@end
