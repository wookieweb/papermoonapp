//
//  CreditViewController.m
//  PaperMoon
//
//  Created by Andy Woo on 10/1/13.
//
//

#import "CreditViewController.h"


 @interface CreditViewController ()

 @end

@implementation CreditViewController

@synthesize versionNumber = _versionNumber;

@synthesize doneButton = _doneButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *left = @" (";
    NSString *right = @")";
    

    NSString* buildNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *tmpString = [left stringByAppendingString:buildNumber];
    NSString *completeBuildNumber = [tmpString stringByAppendingString:right];
    NSString* versionNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    self.versionNumber.text = [versionNumber stringByAppendingString:completeBuildNumber];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
 //   [self dismissModalViewControllerAnimated:YES];
	// [self.view removeFromSuperview];
}



- (void)viewDidUnload {
    [self setDoneButton:nil];
    [self setVersionNumber:nil];

    [super viewDidUnload];
}
@end
