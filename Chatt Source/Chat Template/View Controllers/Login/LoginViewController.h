
#import <UIKit/UIKit.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "User.h"


@interface LoginViewController : UIViewController < UITextFieldDelegate >
{
    IBOutlet UIScrollView*      viewForContent ;
    IBOutlet UIView*            viewForUser ;
    IBOutlet UITextField*       txtForEmail ;
    IBOutlet UITextField*       txtForPassword ;
    UIActivityIndicatorView *activityIndicator;
}

@property ( strong, nonatomic) FirebaseSimpleLogin* authClient;
@property ( strong, nonatomic) NSString* username;
@property ( strong, nonatomic) NSString* password;




@end
