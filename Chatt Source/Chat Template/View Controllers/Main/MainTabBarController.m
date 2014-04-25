
#import "MainTabBarController.h"

@interface MainTabBarController ()
{
    NSInteger selectedIndex ;
}

@end

@implementation MainTabBarController


#pragma mark - Shared Functions
+ ( MainTabBarController* ) sharedController
{
    NSArray* array = [ [ NSBundle mainBundle ] loadNibNamed : @"MainTabBarController" owner : nil options : nil ] ;
    MainTabBarController* sharedController = [ array objectAtIndex : 0 ] ;
    
    return sharedController ;
}

#pragma mark - MainTabBarController
- ( void ) viewDidLoad
{
    [ super viewDidLoad ] ;
    
    CGRect oldFrame = self.tabBar.frame ;
    CGRect newFrame = viewForTabBar.bounds ;
    
    newFrame.origin.y = oldFrame.origin.y + oldFrame.size.height - newFrame.size.height ;
    
    [ self.tabBar setFrame : newFrame ] ;
    [ self.tabBar addSubview : viewForTabBar ] ;
    
    
    viewForTabBar.backgroundColor = [ UIColor colorWithRed : 0.0f / 255.0f green : 51.0f / 255.0f blue : 102.0f / 255.0f alpha : 1 ];

    selectedIndex = -1 ;
    [ self setSelected : 0 ] ;
}



- ( void ) didReceiveMemoryWarning
{
    [ super didReceiveMemoryWarning ] ;
}

- ( void ) dealloc
{
    [ super dealloc ] ;
}

#pragma mark - Events
- ( void ) setSelected : ( NSInteger ) index
{
   
    if( selectedIndex != index )
    {
        switch( selectedIndex )
        {
            case 0 :
                [ btnForChat setAdjustsImageWhenHighlighted : YES ] ;
                [ btnForChat setImage : [ UIImage imageNamed : @"tabbar_chat.png" ] forState : UIControlStateNormal ] ;
                break ;
                
            case 1 :
                [ btnForNote setAdjustsImageWhenHighlighted : YES ] ;
                [ btnForNote setImage : [ UIImage imageNamed : @"tabbar_note.png" ] forState : UIControlStateNormal ] ;
                break ;
                
            case 2 :
                [ btnForProject setAdjustsImageWhenHighlighted : YES ] ;
                [ btnForProject setImage : [ UIImage imageNamed : @"tabbar_project.png" ] forState : UIControlStateNormal ] ;
                break ;
                
            case 3 :
                [ btnForMore setAdjustsImageWhenHighlighted : YES ] ;
                [ btnForMore setImage : [ UIImage imageNamed : @"tabbar_more.png" ] forState : UIControlStateNormal ] ;
                break ;
                
            default :
                break ;
        }
    }
    
    if( selectedIndex != index )
    {
        selectedIndex = index ;
        
        switch( selectedIndex )
        {
            case 0 :
                [ btnForChat setAdjustsImageWhenHighlighted : NO ] ;
                [ btnForChat setImage : [ UIImage imageNamed : @"tabbar_chat_highlighted.png" ] forState : UIControlStateNormal ] ;
                break ;
                
            case 1 :
                [ btnForNote setAdjustsImageWhenHighlighted : NO ] ;
                [ btnForNote setImage : [ UIImage imageNamed : @"tabbar_note_highlighted.png" ] forState : UIControlStateNormal ] ;
                break ;
                
            case 2 :
                [ btnForProject setAdjustsImageWhenHighlighted : NO ] ;
                [ btnForProject setImage : [ UIImage imageNamed : @"tabbar_project_highlighted.png" ] forState : UIControlStateNormal ] ;
                break ;
                
            case 3 :
                [ btnForMore setAdjustsImageWhenHighlighted : NO ] ;
                [ btnForMore setImage : [ UIImage imageNamed : @"tabbar_more_highlighted.png" ] forState : UIControlStateNormal ] ;
                break ;
                
            default :
                break ;
        }
    }
    
    if( selectedIndex != [ self selectedIndex ] )
    {
        [ self setSelectedIndex : selectedIndex ] ;
        return ;
    }
    
    if( [ self.selectedViewController isKindOfClass : [ UINavigationController class ] ] )
    {
        [ ( UINavigationController* )self.selectedViewController popToRootViewControllerAnimated : YES ] ;
        return ;
    }
}

- ( IBAction ) onBtnChat : ( id ) sender
{
    [ self setSelected : 0 ] ;
}

- ( IBAction ) onBtnNote : ( id ) sender
{
    [ self setSelected : 1 ] ;
}

- ( IBAction ) onBtnProject : ( id ) sender
{
    [ self setSelected : 2 ] ;
}

- ( IBAction ) onBtnMore : ( id ) sender
{
    [ self setSelected : 3 ] ;
}

@end
