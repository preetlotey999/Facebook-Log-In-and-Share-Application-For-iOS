



#import <Foundation/Foundation.h>

// Other Classes
#import "FBConnect.h"


@protocol SingletonDelegate <NSObject>

-(void) loginReturn:(BOOL)success userInfo:(NSDictionary*)user FailWithError:(NSError*)error;

-(void) logoutReturn;


@end


@interface Singleton : NSObject <FBRequestDelegate, FBSessionDelegate, FBDialogDelegate>
{
    Facebook *facebook;

    FBRequest *postRequest;
}


@property (retain,nonatomic) Facebook *facebook;

@property(nonatomic,assign)id <SingletonDelegate> delegate;



+ (id) sharedManager;


- (void) logoutButtonClicked:(id)sender;

- (void) loginButtonClicked:(id)sender;


@end
