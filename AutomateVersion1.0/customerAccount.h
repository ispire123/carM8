//
//  customerAccount.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customerAccount : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *fullName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *oldPassword;
@property (strong, nonatomic) IBOutlet UITextField *nPassword;
- (IBAction)updatePhone:(id)sender;
- (IBAction)updatePassword:(id)sender;
@property NSString *currentEmial;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
