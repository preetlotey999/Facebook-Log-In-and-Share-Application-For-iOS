



#define kAppId @"409043425790610"


#import "Singleton.h"


@implementation Singleton


@synthesize facebook,delegate;

static Singleton *sharedMyManager = nil;





+ (id) sharedManager
{
    @synchronized(self)
    {
        if (sharedMyManager == nil)
            
            sharedMyManager = [[self alloc] init];
    }
    
    return sharedMyManager;
}

- (id) init
{
    if (self = [super init])
    {
        facebook = [[Facebook alloc] initWithAppId:kAppId  andDelegate:self];
        
    }
    
    return self;
}




#pragma mark - Facebook Method

- (void) loginButtonClicked:(id)sender
{
    if (![facebook isSessionValid])
    {
        NSLog(@"facebook session");
        
        NSArray *permissions = [[[NSArray alloc] initWithObjects:@"email", @"publish_actions", nil] autorelease];
        
        [facebook authorize:permissions];
    }
    
    else
    {
        NSLog (@"Session is still valid.");
        
        [[[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Session is still valid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (void) logoutButtonClicked:(id)sender
{
    [facebook logout];
}




#pragma mark - Facebook Delegate

- (void) request:(FBRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error %@",error);
    
    [[[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}



- (void) request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"requestdidload");
    
    NSLog(@"result %@",result);
    
    [[[UIAlertView alloc] initWithTitle:@"Facebook" message:@"You have successfully posted your post on your wall." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)fbDidLogin
{
    NSLog(@"fdLogin");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    
    [defaults synchronize];
    
     [facebook requestWithGraphPath:@"me" andDelegate:self];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   kAppId, @"app_id",
                                   @"http://www.hunkatech.com", @"link",
                                   @"http://hwsdemos.com/LangGuage/medal_1.png", @"picture",
                                   @"Test Application!", @"name",
                                   @"Facebook iOS Demo", @"caption",
                                   @"I have test the application successfully.", @"description",
                                   nil];
    
    postRequest = [facebook requestWithGraphPath:@"me/feed" andParams:params andHttpMethod:@"POST" andDelegate:self];
   
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
    NSLog(@"facebook cancel login");
    
    [[[UIAlertView alloc] initWithTitle:@"Facebook" message:@"You have successfully cancelled your login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


- (void) fbDidLogout
{
    NSLog(@"fbDidLogout");
    
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"FBAccessTokenKey"])
    {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        
        [defaults synchronize];
    }
}

- (void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    NSLog(@"token extended");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    
    [defaults synchronize];
}

- (void) fbSessionInvalidated
{
    
}


@end
