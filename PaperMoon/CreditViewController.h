//
//  CreditViewController.h
//  PaperMoon
//
//  Created by Andy Woo on 10/1/13.
//
//

#import <UIKit/UIKit.h>


@interface CreditViewController : UIViewController



@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (strong, nonatomic) IBOutlet UILabel *versionNumber;

- (IBAction)buttonPressed:(id)sender;

@end
