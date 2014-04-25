
#import "ProjectViewController.h"
#import "ProjectViewCell.h"


@interface ProjectViewController ()

@end

@implementation ProjectViewController


#pragma mark - ProjectViewController
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
    
    
    if( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 7.0f )
    {
        [ ctrlForProject setTintColor : [ UIColor whiteColor ] ] ;
    }
    else
    {
        [ ctrlForProject setTintColor : [ UIColor colorWithRed : 0.0f / 255.0f green : 184.0f / 255.0f blue : 99.0f / 255.0f alpha : 1.0f ] ] ;
    }
    
    [ self.navigationItem setTitleView : viewForTitle ] ;
    [ self.navigationItem setLeftBarButtonItem : [ [ [ UIBarButtonItem alloc ] initWithCustomView : btnForLogo ] autorelease ] ] ;
    [ self.navigationItem setRightBarButtonItem : itemForSearch ] ;
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
    return 10 ;
}

- ( CGFloat ) tableView : ( UITableView* ) tableView heightForRowAtIndexPath : ( NSIndexPath* ) indexPath
{
    return 65.0f ;
}

- ( UITableViewCell* ) tableView : ( UITableView* ) tableView cellForRowAtIndexPath : ( NSIndexPath* ) indexPath
{
    ProjectViewCell* cell = [ tblForProject dequeueReusableCellWithIdentifier : @"ProjectViewCell" ] ;
    
    if( cell == nil )
    {
        cell = [ ProjectViewCell sharedCell ] ;
    }
    
    return cell ;
}

@end
