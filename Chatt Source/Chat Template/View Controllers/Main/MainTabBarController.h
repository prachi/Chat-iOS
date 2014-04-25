
#import <UIKit/UIKit.h>


@interface MainTabBarController : UITabBarController
{
    IBOutlet UIView*            viewForTabBar ;
    IBOutlet UIButton*          btnForChat ;
    IBOutlet UIButton*          btnForNote ;
    IBOutlet UIButton*          btnForProject ;
    IBOutlet UIButton*          btnForMore ;
}

+ ( MainTabBarController* ) sharedController ;

@end
