
#import "AppDelegate.h"

#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "Group.h"
#import "Chat.h"

@implementation AppDelegate


@synthesize window = _window ;
@synthesize viewController = _viewController ;
@synthesize firebase = _firebase ;
@synthesize authClient = _authClient ;
@synthesize username = _username ;
@synthesize managedObjectContext = _managedObjectContext ;
@synthesize managedObjectModel = _managedObjectModel ;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator ;


#pragma mark - AppDelegate
- ( void ) dealloc
{
   
    [ _window release ] ;
    [ _viewController release ] ;
    
    [ super dealloc ] ;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    return wasHandled;
}

- ( BOOL ) application : ( UIApplication* ) application didFinishLaunchingWithOptions : ( NSDictionary* ) launchOptions
{
    
    [ [ UIApplication sharedApplication ] setStatusBarHidden : NO ] ;
    [ [ UIApplication sharedApplication ] setStatusBarStyle : UIStatusBarStyleLightContent ] ;
    
    
    if( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 7.0f )
    {
        [ [ UINavigationBar appearance ] setBarTintColor : [ UIColor colorWithRed : 0.0f / 255.0f green : 51.0f / 255.0f blue : 102.0f / 255.0f alpha : 1.0f ] ] ;
        [ [ UINavigationBar appearance ] setTintColor : [ UIColor whiteColor ] ] ;
    }
    else
    {
        [ [ UINavigationBar appearance ] setTintColor : [ UIColor colorWithRed : 0.0f / 255.0f green : 51.0f / 255.0f blue : 102.0f / 255.0f alpha : 1.0f ] ] ;
    }
    
    NSMutableDictionary* titleBarAttributes = [ NSMutableDictionary dictionaryWithDictionary : [ [ UINavigationBar appearance ] titleTextAttributes ] ] ;
    
    [ titleBarAttributes setValue : [ UIColor whiteColor ] forKey : UITextAttributeTextColor ] ;
    
    [ [ UINavigationBar appearance ] setTitleTextAttributes : titleBarAttributes ] ;
    
        self.window = [ [ [ UIWindow alloc ] initWithFrame : [ [ UIScreen mainScreen ] bounds ] ] autorelease ] ;
    self.viewController = [ MainTabBarController sharedController ] ;
    
    [ self.window setRootViewController : self.viewController ] ;
    [ self.window makeKeyAndVisible ] ;
    
    self.firebase = [[Firebase alloc] initWithUrl:@"https://intense-fire-8831.firebaseio.com"];
    self.authClient = [[FirebaseSimpleLogin alloc] initWithRef:self.firebase];
    
    [ self login ] ;
    
    return YES ;
}

- ( void ) login
{
    LoginViewController* viewController = [ [ [ LoginViewController alloc ] initWithNibName : @"LoginViewController" bundle : nil ] autorelease ] ;
    viewController.authClient = self.authClient;
    [ _viewController presentViewController : viewController animated : NO completion : ^{
        
    } ] ;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Chat Template.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
