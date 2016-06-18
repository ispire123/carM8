//
//  ForgotPassword.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 12/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPassword : UIViewController
- (IBAction)recoverPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *email;

@end
