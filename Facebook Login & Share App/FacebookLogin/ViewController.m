



#import "ViewController.h"


// Helper Classes
#import "Singleton.h"


@interface ViewController ()


@end


@implementation ViewController




#pragma mark - View Lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"View Will Appear");
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"View Will Disappear");
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"View Did Appear");
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"View Did Disappear");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}




#pragma mark - IBActions

- (IBAction) loginAndShare:(id)sender
{
    [[Singleton sharedManager] loginButtonClicked:nil];
}


@end
