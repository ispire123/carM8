//
//  CustomerLogin.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 22/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerLogin : UIViewController <UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UITextField *customerEmail;
//@property (weak, nonatomic) IBOutlet UITextField *customerPassword;
- (IBAction)login:(id)sender;
@property NSString *emailID;
- (IBAction)tabges:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *view1;
- (IBAction)backAction:(id)sender;
@end
