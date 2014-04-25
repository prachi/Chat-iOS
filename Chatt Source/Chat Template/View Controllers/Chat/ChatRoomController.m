
#import "ChatRoomController.h"
#import "ChatViewCell.h"
#import "Chat.h"
#import "User.h"


@interface ChatRoomController ()

@end


@implementation ChatRoomController

@synthesize ctrlForChat;


#pragma mark - ChatRoomController
- ( id ) initWithNibName : ( NSString* ) nibNameOrNil bundle : ( NSBundle* ) nibBundleOrNil
{
    self = [ super initWithNibName : nibNameOrNil bundle : nibBundleOrNil ] ;
    
    if( self )
    {
        
    }
    
    return self ;
}

-(IBAction)segmentIndexChanged:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    self.selectedIndex = segmentedControl.selectedSegmentIndex;
    [self->tblForChat reloadData];
}

- ( void ) viewDidLoad
{
    [ super viewDidLoad ] ;
    self.chatMy = [[NSMutableArray alloc] init];
    self.chatAll = [[NSMutableArray alloc] init];
    self.chatSenderMy = [[NSMutableArray alloc] init];
    self.chatSenderAll = [[NSMutableArray alloc] init];
    self.array = [[NSMutableArray alloc] init];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.firebase = app.firebase;
    self.username = app.username;
    // Navigation Bar ;
    if( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 7.0f )
    {
        [ ctrlForChat setTintColor : [ UIColor whiteColor ] ] ;
    }
    else
    {
        [ ctrlForChat setTintColor : [ UIColor colorWithRed : 0.0f / 255.0f green : 51.0f / 255.0f blue : 102.0f / 255.0f alpha : 1.0f ]] ;
    }
   
    
    [ self.navigationItem setTitleView : viewForTitle ] ;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: btnForSearch, nil]];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images.jpeg"]];
    [tempImageView setFrame:tblForChat.frame];
    
    tblForChat.backgroundView = tempImageView;
    
    /*[self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self.chat addObject:snapshot.value];
        [self->tblForChat reloadData];
    }];*/
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Chat"];
    NSError *requestError = nil;
    NSArray* temp = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    requestError = nil;
    NSArray* tempUsers = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    for (User *thisUser in tempUsers)
        if ([thisUser.username isEqualToString:self.username])
          self.array = [NSKeyedUnarchiver unarchiveObjectWithData: thisUser.friends];
    
    
    if ([temp count]>0){
        for (Chat *thisChat in temp){
            if (thisChat.groupId == self.groupid){
                [self.chatAll addObject: thisChat.text];
                [self.chatSenderAll addObject:thisChat.username];
            }
        }
    }
    NSInteger counter = [temp count];
    BOOL checked[counter];
    for (int i=counter-1;i>=0;i--)
        checked[i]=0;
    counter = 0;
    for (NSString *friends in self.array){
        if ([temp count]>0){
            for (Chat *thisChat in temp){
                if (thisChat.groupId == self.groupid && ([friends isEqualToString:thisChat.username] || [thisChat.username isEqualToString:self.username]) && checked[counter]==false){
                    [self.chatMy addObject: thisChat.text];
                    [self.chatSenderMy addObject:thisChat.username];
                    checked[counter] = true;
                    counter++;
                }
            }
        }
    }
    [self->tblForChat reloadData];
    
}

- ( void ) didReceiveMemoryWarning
{
    [ super didReceiveMemoryWarning ] ;
}

- ( void ) dealloc
{
    [ctrlForChat release];
    [viewForTitle release];
    [btnForSearch release];
    [more release];
    [ super dealloc ] ;
}

#pragma mark - Text field handling


- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    
    //[[self.firebase childByAutoId] setValue:@{@"email" : self.username, @"text": aTextField.text}];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Chat *newChat = [NSEntityDescription insertNewObjectForEntityForName:@"Chat" inManagedObjectContext:app.managedObjectContext];
    if (newChat != nil){
        newChat.username = self.username;
        newChat.groupId = self.groupid;
        newChat.text = aTextField.text;
        [self.chatMy addObject: newChat.text];
        [self.chatSenderMy addObject:newChat.username];
        [self.chatAll addObject:newChat.text];
        [self.chatSenderAll addObject:newChat.username];
        [self->tblForChat reloadData];

        
        NSError *savingError = nil;
        if ([app.managedObjectContext save:&savingError]){
            NSLog(@"Successfully saved the context.");
        } else {
            NSLog(@"Failed to save the Context. Error = %@",savingError);
        }
    } else {
        NSLog(@"Failed to create the new chat.");
    }

    
    [aTextField setText:@""];
    return NO;
}


#pragma mark - UITableViewDelegate
- ( NSInteger ) numberOfSectionsInTableView : ( UITableView* ) tableView
{
    return 1 ;
}

- ( NSInteger ) tableView : ( UITableView* ) tableView numberOfRowsInSection : ( NSInteger ) section
{
    if (self.selectedIndex == 0)
         return [self.chatMy count] ;
    else
        return [self.chatAll count];
}

- ( CGFloat ) tableView : ( UITableView* ) tableView heightForRowAtIndexPath : ( NSIndexPath* ) indexPath
{
    return 85.0f ;
}

- ( UITableViewCell* ) tableView : ( UITableView* ) tableView cellForRowAtIndexPath : ( NSIndexPath* ) indexPath
{
    if (self.selectedIndex == 0){
        if( [[self.chatSenderMy objectAtIndex:indexPath.row ] isEqualToString:self.username] ){
            ChatViewCell* cell = [ tblForChat dequeueReusableCellWithIdentifier : @"send" ] ;
            NSArray* array = [ [ NSBundle mainBundle ] loadNibNamed : @"ChatViewCell" owner : self options : nil ] ;
            cell = [ array objectAtIndex : 0 ] ;
            [cell.lblForTitle setText:[self.chatMy objectAtIndex:indexPath.row]];
            return cell ;
         }
        else
        {
            ChatViewCell* cell = [ tblForChat dequeueReusableCellWithIdentifier : @"receive" ] ;
            NSArray* array = [ [ NSBundle mainBundle ] loadNibNamed : @"ChatViewCell" owner : self options : nil ] ;
            cell = [ array objectAtIndex : 1 ] ;
            [cell.lblForTitleR setText:[self.chatMy objectAtIndex:indexPath.row]];
            return cell ;
        }
    } else {
        if( [[self.chatSenderAll objectAtIndex:indexPath.row ] isEqualToString:self.username] ){
            ChatViewCell* cell = [ tblForChat dequeueReusableCellWithIdentifier : @"send" ] ;
            NSArray* array = [ [ NSBundle mainBundle ] loadNibNamed : @"ChatViewCell" owner : self options : nil ] ;
            cell = [ array objectAtIndex : 0 ] ;
            [cell.lblForTitle setText:[self.chatAll objectAtIndex:indexPath.row]];
            return cell ;
        }
        else
        {
            ChatViewCell* cell = [ tblForChat dequeueReusableCellWithIdentifier : @"receive" ] ;
            NSArray* array = [ [ NSBundle mainBundle ] loadNibNamed : @"ChatViewCell" owner : self options : nil ] ;
            cell = [ array objectAtIndex : 1 ] ;
            [cell.lblForTitleR setText:[self.chatAll objectAtIndex:indexPath.row]];
            return cell ;
        }

    }
    
    return nil ;
}

#pragma mark - Keyboard handling

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification*)notification
{
    [self moveView:[notification userInfo] up:YES];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [self moveView:[notification userInfo] up:NO];
}

- (void)moveView:(NSDictionary*)userInfo up:(BOOL)up
{
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]
     getValue:&keyboardEndFrame];
    
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]
     getValue:&animationCurve];
    
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]
     getValue:&animationDuration];
    
    // Get the correct keyboard size to we slide the right amount.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    int y = keyboardFrame.size.height * (up ? -1 : 1);
    self.view.frame = CGRectOffset(self.view.frame, 0, y);
    
    [UIView commitAnimations];
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if ([self->txtForMessage isFirstResponder]) {
        [self->txtForMessage resignFirstResponder];
    }
}



#pragma mark - Events
- ( IBAction ) onBtnCamera : ( id ) sender
{
    
}

- ( IBAction ) onBtnPost : ( id ) sender
{
    [self->txtForMessage resignFirstResponder];
    [[self.firebase childByAutoId] setValue:@{@"email" : self.username, @"text": [self->txtForMessage text]}];
    [self->txtForMessage setText:@" "];
}

@end
