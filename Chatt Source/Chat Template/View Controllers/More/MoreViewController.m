
#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController


#pragma mark - MoreViewController
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
}

- ( void ) didReceiveMemoryWarning
{
    [ super didReceiveMemoryWarning ] ;
}

- ( void ) dealloc
{
    [ super dealloc ] ;
}

#pragma mark - UITableViewDelegate
- ( NSInteger ) numberOfSectionsInTableView : ( UITableView* ) tableView
{
    return 1 ;
}

- ( NSInteger ) tableView : ( UITableView* ) tableView numberOfRowsInSection : ( NSInteger ) section
{
    return 6 ;
}

- ( CGFloat ) tableView : ( UITableView* ) tableView heightForRowAtIndexPath : ( NSIndexPath* ) indexPath
{
    return 44.0f ;
}

- ( UITableViewCell* ) tableView : ( UITableView* ) tableView cellForRowAtIndexPath : ( NSIndexPath* ) indexPath
{
    NSArray* titles = @[ @"My Profile", @"Notifications", @"About Chatt", @"My account", @"Feature request", @"Log out" ] ;
    UITableViewCell* cell = [ tblForMore dequeueReusableCellWithIdentifier : @"more" ] ;
    
    if( cell == nil )
    {
        cell = [ [ [ UITableViewCell alloc ] initWithStyle : UITableViewCellStyleDefault reuseIdentifier : @"more" ] autorelease ] ;
        
        // Set ;
        [ cell setAccessoryType : UITableViewCellAccessoryDisclosureIndicator ] ;
    }
    
    // Title ;
    [ cell.textLabel setText : titles[ indexPath.row ] ] ;
    
    return cell ;
}

- ( void ) tableView : ( UITableView* ) tableView didSelectRowAtIndexPath : ( NSIndexPath* ) indexPath
{
    
}

@end
