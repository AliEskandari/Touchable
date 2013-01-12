
#import <UIKit/UIKit.h>
#import "EditInfoScreen.h"

@interface WelcomeScreen : UIViewController <UIImagePickerControllerDelegate, EditInfoScreenDelegate, DoneRegisteringDelegate>
@property  IBOutlet UIButton *btnChangePhoto;
@property  IBOutlet UILabel *welcomeLabel;
@property  IBOutlet UILabel *btnCaption;
@property  IBOutlet UILabel *photoInstructions;
@property  IBOutlet UILabel *photoRules;
@property (copy, nonatomic) NSData* userPhoto;
@property (copy, nonatomic) NSMutableDictionary* savedInfo;
@property BOOL photoChosen;
@property id<DoneRegisteringDelegate> doneRegisteringDelegate;

-(IBAction)btnChangePhotoTapped:(id)sender;
-(IBAction)btnEditInfoTapped:(id)sender;
-(void)editInfoScreenDismissed:(NSMutableDictionary*)completedInfo;
-(void)doneRegistering:(NSString *)username password:(NSString *)pass;

@end

