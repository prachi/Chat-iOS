

#import "AddGroupViewController.h"
#import "ContactViewController.h"

@interface AddGroupViewController ()

@end

@implementation AddGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- ( void ) viewWillAppear : ( BOOL ) animated
{
    [ super viewWillAppear : animated ] ;
    
    
    [ [ UIApplication sharedApplication ] setStatusBarHidden : YES ] ;
    
    
    [ [ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector( willShowKeyBoard: ) name : UIKeyboardWillShowNotification object : nil ] ;
    [ [ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector( willHideKeyBoard: ) name : UIKeyboardWillHideNotification object : nil ] ;
}

- ( void ) viewWillDisappear : ( BOOL ) animated
{
    [ super viewWillDisappear : animated ] ;
    
    
    [ [ UIApplication sharedApplication ] setStatusBarHidden : NO ] ;
    
    
    [ [ NSNotificationCenter defaultCenter ] removeObserver : self ] ;
}

- ( void ) willShowKeyBoard : ( NSNotification* ) notification
{
    NSDictionary* userInfo = [ notification userInfo ] ;
    NSTimeInterval duration ;
    UIViewAnimationCurve curve ;
    CGRect keyboardFrame ;
    CGRect frame = [ viewForContent frame ] ;
    
    
    [ [ userInfo objectForKey : UIKeyboardAnimationCurveUserInfoKey ] getValue : &curve ] ;
    [ [ userInfo objectForKey : UIKeyboardAnimationDurationUserInfoKey ] getValue : &duration ] ;
    [ [ userInfo objectForKey : UIKeyboardFrameEndUserInfoKey ] getValue : &keyboardFrame ] ;
    
    frame.size.height -= keyboardFrame.size.height ;
    
    
    [ UIView beginAnimations : nil context : nil ] ;
    [ UIView setAnimationCurve : curve ] ;
    [ UIView setAnimationDuration : duration ] ;
    
    [ viewForContent setFrame : frame ] ;
    
    
    [ UIView commitAnimations ] ;
}

- ( void ) willHideKeyBoard : ( NSNotification* ) notification
{
    NSDictionary* userInfo = [ notification userInfo ] ;
    NSTimeInterval duration ;
    UIViewAnimationCurve curve ;
    CGRect keyboardFrame ;
    CGRect frame = [ viewForContent frame ] ;
    
   
    [ [ userInfo objectForKey : UIKeyboardAnimationCurveUserInfoKey ] getValue : &curve ] ;
    [ [ userInfo objectForKey : UIKeyboardAnimationDurationUserInfoKey ] getValue : &duration ] ;
    [ [ userInfo objectForKey : UIKeyboardFrameEndUserInfoKey ] getValue : &keyboardFrame ] ;
    
    frame.size.height += keyboardFrame.size.height ;
    
   
    [ UIView beginAnimations : nil context : nil ] ;
    [ UIView setAnimationCurve : curve ] ;
    [ UIView setAnimationDuration : duration ] ;
    
    [ viewForContent setFrame : frame ] ;
    
    [ UIView commitAnimations ] ;
}

#pragma mark - UITextField Delegate
- ( BOOL ) textFieldShouldReturn : ( UITextField* ) textField
{
    self.group = textField.text;
    [textField resignFirstResponder];
    return YES ;
}

- ( BOOL ) prefersStatusBarHidden
{
    return YES ;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Add Group";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showFriends:)];
    [self.navigationItem setRightBarButtonItem:button];
    
    [viewForContent setContentSize : CGSizeMake(320, 700) ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

- (void)showFriends:(id) sender{
    if (self.group == Nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter a group name first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else {
        ContactViewController* viewController = [ [ [ ContactViewController alloc ] initWithNibName : @"ContactViewController" bundle : nil ] autorelease ] ;
        viewController.group = self.group;
        
        [ self.navigationController pushViewController : viewController animated : YES ] ;
    }
    
}

- (void)dealloc {
    [viewForContent release];
    [groupName release];
    [viewForUser release];
    [groupImage release];
    [groupName release];
    [super dealloc];
}
@end
