
#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contacts = [[NSMutableArray alloc] init];
    self.groupMembers = [[NSMutableArray alloc] init];
    
    self.navigationItem.title = self.group;
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addContact:)];
    [self.navigationItem setRightBarButtonItem:button];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *requestError = nil;
    NSArray *users = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    if ([users count] > 0){
        for (User *thisUser in users){
            if ( [thisUser.username isEqualToString:app.username])
                continue;
            else
            [self.contacts addObject:thisUser.username];
        }
    }
    [self.tableView reloadData];
}

- (void) addContact:(id) sender {
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Group"];
    NSError *requestError = nil;
    NSArray *groups = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    Group *newGroup = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:app.managedObjectContext];
    if (newGroup != nil){
        newGroup.groupId = [NSNumber numberWithInteger:[groups count]];
        newGroup.groupName = self.group;
        newGroup.groupMembers = [NSKeyedArchiver archivedDataWithRootObject:self.groupMembers];
        
        NSError *savingError = nil;
        if ([app.managedObjectContext save:&savingError]){
            NSLog(@"Successfully saved the context.");
        } else {
            NSLog(@"Failed to save the Context. Error = %@",savingError);
        }
    } else {
        NSLog(@"Failed to create the new Group.");
    }
    
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    requestError = nil;
    NSArray *users = [app.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if ( [users count]>0){
        for ( User *thisUser in users){
            if ([thisUser.username isEqualToString:app.username]){
                NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData: thisUser.friends];
                [self.groupMembers addObjectsFromArray:array];
                thisUser.friends = [NSKeyedArchiver archivedDataWithRootObject:self.groupMembers];
            }
        }
    }
     
    
    
    ChatViewController* viewController = [ [ [ ChatViewController alloc ] initWithNibName : @"ChatViewController" bundle : nil ] autorelease ] ;
    [ self.navigationController pushViewController : viewController animated : YES ] ;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
       
    }
    cell.textLabel.text = [self.contacts objectAtIndex:indexPath.row];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryNone){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.groupMembers addObject:cell.textLabel.text];
        }
      else
          cell.accessoryType = UITableViewCellAccessoryNone;
    
}


@end
