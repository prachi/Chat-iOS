
#import <UIKit/UIKit.h>

@interface AddGroupViewController : UIViewController{
    
    IBOutlet UIScrollView *viewForContent;
    IBOutlet UIView *viewForUser;
    
    IBOutlet UIImageView *groupImage;

    IBOutlet UITextField *groupName;
}

@property ( strong, nonatomic) NSString* group;


@end
