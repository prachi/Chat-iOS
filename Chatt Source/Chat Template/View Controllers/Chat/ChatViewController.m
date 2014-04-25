
#import "ChatViewController.h"
#import "ChatRoomCell.h"

#import "ChatRoomController.h"
#import "AddGroupViewController.h"

#import "AppDelegate.h"
#import "Group.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

#pragma mark - ChatViewController


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
    self.groups = [[NSMutableArray alloc] init];
    self.groupid = [[NSMutableArray alloc] init];
    
    [ self.navigationItem setTitle:@"Groups"] ;
    addContact = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addGroup:)];
    [ self.navigationItem setLeftBarButtonItem : [ [ [ UIBarButtonItem alloc ] initWithCustomView : btnForLogo ] autorelease ] ] ;
    [self.navigationItem setRightBarButtonItem:addContact];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Group"];
    NSError *requestError = nil;
    NSArray* temp = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    NSLog(@"%d",[temp count]);
    if ([temp count]>0){
        for (Group *thisGroup in temp){
            [self.groups addObject: thisGroup.groupName];
            [self.groupid addObject:thisGroup.groupId];
        }
    }
    [tblForChat reloadData];
    
}

- ( void ) didReceiveMemoryWarning
{
    [ super didReceiveMemoryWarning ] ;
}

- ( void ) dealloc
{
    [addContact release];
    [ super dealloc ] ;
}

#pragma mark - UITableViewDelegate

-(void)addGroup:(id) sender{
    AddGroupViewController* viewController = [ [ [ AddGroupViewController alloc ] initWithNibName : @"AddGroupViewController" bundle : nil ] autorelease ] ;
    
    [ self.navigationController pushViewController : viewController animated : YES ] ;
}


- ( NSInteger ) numberOfSectionsInTableView : ( UITableView* ) tableView
{
    return 1 ;
}

- ( NSInteger ) tableView : ( UITableView* ) tableView numberOfRowsInSection : ( NSInteger ) section
{
    return [self.groups count];
}

- ( CGFloat ) tableView : ( UITableView* ) tableView heightForRowAtIndexPath : ( NSIndexPath* ) indexPath
{
    return 65.0f ;
}

- ( UITableViewCell* ) tableView : ( UITableView* ) tableView cellForRowAtIndexPath : ( NSIndexPath* ) indexPath
{
        ChatRoomCell* cell = [ tblForChat dequeueReusableCellWithIdentifier : @"ChatRoomCell" ] ;
        
        if( cell == nil )
        {
            cell = [ ChatRoomCell sharedCell ] ;
            cell->lblForTitle.text = [self.groups objectAtIndex:indexPath.row];
        }
       cell.selectionStyle = UITableViewCellSelectionStyleGray;
       return cell ;
       
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatRoomController* viewController = [ [ [ ChatRoomController alloc ] initWithNibName : @"ChatRoomController" bundle : nil ] autorelease ] ;
    
    viewController.groupid = [self.groupid objectAtIndex:indexPath.row];
    
    // Push ;
    [ self.navigationController pushViewController : viewController animated : YES ] ;

}

#pragma mark - Events
- ( IBAction ) onBtnChat : ( id ) sender
{
    ChatRoomController* viewController = [ [ [ ChatRoomController alloc ] initWithNibName : @"ChatRoomController" bundle : nil ] autorelease ] ;
    
    [ self.navigationController pushViewController : viewController animated : YES ] ;
}

@end
