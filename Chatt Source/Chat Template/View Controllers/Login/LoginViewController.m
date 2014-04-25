
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - LoginViewController


- ( id ) initWithNibName : ( NSString* ) nibNameOrNil bundle : ( NSBundle* ) nibBundleOrNil
{
    self = [ super initWithNibName : nibNameOrNil bundle : nibBundleOrNil ] ;

    if( self )
    {

    }
    
    return self ;
}

- ( void ) viewDidLoad
{
    [ super viewDidLoad ] ;
    viewForContent.backgroundColor = [ UIColor colorWithRed:204/255 green:255/255 blue:204/255 alpha:0.2 ];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = self.view.center;
    activityIndicator.color = [UIColor blackColor];
    
    [self.view addSubview:activityIndicator];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.authClient = app.authClient;

    [ viewForContent setContentSize : viewForUser.bounds.size ] ;
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

- ( void ) didReceiveMemoryWarning
{
    [ super didReceiveMemoryWarning ] ;
}

- ( void ) dealloc
{
    [ super dealloc ] ;
}

- ( BOOL ) prefersStatusBarHidden
{
    return YES ;
}

#pragma mark - Notification
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
    if( textField == txtForEmail )
    {   self.username = textField.text;
        [ txtForPassword becomeFirstResponder ] ;
    }
    else if( textField == txtForPassword )
    {   self.password = textField.text;
        [ txtForPassword resignFirstResponder ] ;
    }
    
    return YES ;
}

#pragma mark - Events

- ( IBAction ) onBtnRegister : ( id ) sender
{   [activityIndicator startAnimating];
    
    [self.authClient createUserWithEmail:self.username password:self.password
                      andCompletionBlock:^(NSError* error, FAUser* user) {
                          
                          if (error != nil) {
                              NSLog(@"%@",error);
                              UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                                                message:[error localizedDescription]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil];
                              [activityIndicator stopAnimating];
                              [message show];
                          } else {
                              UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                                message:self.username
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil];
                              [activityIndicator stopAnimating];
                              [message show];
                              [ self dismissViewControllerAnimated : YES completion : ^{
                                  
                              } ] ;
                              
                              AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                              app.username = self.username;
                              User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:app.managedObjectContext];
                              if (newUser != nil){
                                  newUser.username = self.username;
                                  newUser.password = self.password;
                                  
                                  NSError *savingError = nil;
                                  if ([app.managedObjectContext save:&savingError]){
                                      NSLog(@"Successfully saved the context.");
                                  } else {
                                      NSLog(@"Failed to save the Context. Error = %@",savingError);
                                  }
                              } else {
                                  NSLog(@"Failed to create the new user.");
                              }
                              
                          }
                      }];
    
}

- ( IBAction ) onBtnLogin : ( id ) sender
{   [activityIndicator startAnimating];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *requestError = nil;
    NSArray *users = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    NSUInteger counter = 0;
    BOOL flag = 0;
    if ([users count] > 0){
               for (User *thisUser in users){
            NSLog(@"%d",[users count]);
            if ([thisUser.username isEqualToString:self.username] && [thisUser.password isEqualToString:self.password]) {
                app.username = self.username;
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                  message:self.username
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                NSLog(@"hello");
                flag = 1;
                [activityIndicator stopAnimating];
                [message show];
                [ self dismissViewControllerAnimated : YES completion : ^{
                    
                } ] ;
            }
            counter++;
        }
    }
    if (counter == [users count] && flag == 0){
         NSLog(@"hello");
        [self.authClient loginWithEmail:self.username andPassword:self.password
                    withCompletionBlock:^(NSError* error, FAUser* user) {
                        
                        if (error != nil) {
                            NSLog(@"%@",error);
                            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                                              message:[error localizedDescription]
                                                                             delegate:nil
                                                                    cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil];
                            [activityIndicator stopAnimating];
                            [message show];
                            
                        } else {
                            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                              message:self.username
                                                                             delegate:nil
                                                                    cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil];
                            [activityIndicator stopAnimating];
                            [message show];
                            [ self dismissViewControllerAnimated : YES completion : ^{
                                
                            } ] ;
                            app.username = self.username;
                            User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:app.managedObjectContext];
                            if (newUser != nil){
                                newUser.username = self.username;
                                newUser.password = self.password;
                                
                                NSError *savingError = nil;
                                if ([app.managedObjectContext save:&savingError]){
                                    NSLog(@"Successfully saved the context.");
                                } else {
                                    NSLog(@"Failed to save the Context. Error = %@",savingError);
                                }
                            } else {
                                NSLog(@"Failed to create the new user.");
                            }
                            
                            
                        }
                    }];
    }
    
}


- ( IBAction ) onBtnFacebook : ( id ) sender
{   [activityIndicator startAnimating];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *requestError = nil;
    NSArray *users = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    BOOL flag = 0;
    NSUInteger counter = 0;
    if ([users count] > 0){
        
        for (User *thisUser in users){
            NSLog(@"%@",thisUser.username);
            if ([thisUser.password isEqualToString: @"facebook"]) {
                self.username = thisUser.username;
                self.password = thisUser.password;
                app.username = self.username;
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                  message:self.username
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [activityIndicator stopAnimating];
                [message show];
                flag = 1;
                [ self dismissViewControllerAnimated : YES completion : ^{
                    
                } ] ;
            }
            counter++;
        }
    }
    if (counter == [users count] && flag == 0){

    [self.authClient loginToFacebookAppWithId:@"767056019984823" permissions:@[@"email",@"read_friendlists"]
                                     audience:ACFacebookAudienceOnlyMe
                          withCompletionBlock:^(NSError *error, FAUser *user) {
                              [activityIndicator startAnimating];
                              if (error != nil) {
                                  NSLog(@"%@",error);
                                  
                                  UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                                                    message:[error localizedDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil];
                                  [activityIndicator stopAnimating];
                                  
                                  [message show];
                                  
                              } else {
                                  self.username = [user.thirdPartyUserData objectForKey:@"displayName"];
                                  self.password = @"facebook";
                                  app.username = self.username;
                                  UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                                    message:self.username
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil];
                                  [activityIndicator stopAnimating];
                                  
                                  [message show];
                                  [ self dismissViewControllerAnimated : YES completion : ^{
                                      
                                  } ] ;
                                  User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:app.managedObjectContext];
                                  if (newUser != nil){
                                      newUser.username = self.username;
                                      newUser.password = self.password;
                                      
                                      NSError *savingError = nil;
                                      if ([app.managedObjectContext save:&savingError]){
                                          NSLog(@"Successfully saved the context.");
                                      } else {
                                          NSLog(@"Failed to save the Context. Error = %@",savingError);
                                      }
                                  } else {
                                      NSLog(@"Failed to create the new user.");
                                  }

                                  
                              }
                          }];
    }
}

- ( IBAction ) onBtnTwitter : ( id ) sender
{
    [activityIndicator startAnimating];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *requestError = nil;
    NSArray *users = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    NSUInteger counter = 0;
    BOOL flag = 0;
    if ([users count] > 0){
        
        for (User *thisUser in users){
            if ([thisUser.password isEqualToString:@"twitter"]) {
                self.username = thisUser.username;
                self.password = thisUser.password;
                app.username = self.username;
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                  message:thisUser.username
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [activityIndicator stopAnimating];
                [message show];
                flag = 1;
                [ self dismissViewControllerAnimated : YES completion : ^{
                    
                } ] ;
            }
            counter++;
        }
    }
    if (counter == [users count] && flag ==0){

    [self.authClient loginToTwitterAppWithId:@"0UqdooJe4paRu0tWlTlhw"
                     multipleAccountsHandler:^int(NSArray *usernames) {
                         
                         // If you do not wish to authenticate with any of these usernames, return NSNotFound.
                         return NSNotFound;
                     } withCompletionBlock:^(NSError *error, FAUser *user) {
                        
                         if (error != nil) {
                             NSLog(@"%@",error);
                             UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                                               message:[error localizedDescription]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil];
                             [activityIndicator stopAnimating];
                             [message show];
                             
                         } else {
                             self.username = [user.thirdPartyUserData objectForKey:@"screen_name"];
                             self.password = @"twitter";
                             AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                             app.username = self.username;
                             UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                               message:self.username
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil];
                             
                             [activityIndicator stopAnimating];
                             [message show];
                             [ self dismissViewControllerAnimated : YES completion : ^{
                                 
                             } ] ;
                             User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:app.managedObjectContext];
                             if (newUser != nil){
                                 newUser.username = self.username;
                                 newUser.password = self.password;
                                 
                                 NSError *savingError = nil;
                                 if ([app.managedObjectContext save:&savingError]){
                                     NSLog(@"Successfully saved the context.");
                                 } else {
                                     NSLog(@"Failed to save the Context. Error = %@",savingError);
                                 }
                             } else {
                                 NSLog(@"Failed to create the new user.");
                             }

                             
                         }
                     }];
    }
}


- ( IBAction ) onBtnForgot : ( id ) sender
{
    
}

@end
