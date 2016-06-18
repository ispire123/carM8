//
//  customerAccount.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "customerAccount.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
@interface customerAccount ()

@end

@implementation customerAccount
@synthesize scrollView;
@synthesize currentEmial;
- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
    // Do any additional setup after loading the view.
    currentEmial = [[PFUser currentUser] objectForKey:@"email"];
    NSString *firstName = [[PFUser currentUser]objectForKey:@"firstName"];
    
    NSString *lastName = [[PFUser currentUser] objectForKey:@"lastName"];

    _fullName.text = [[firstName stringByAppendingString:@" "] stringByAppendingString:lastName];
    

    
    
    
    NSString *emailStr = [[PFUser currentUser] objectForKey:@"email"];
    _email.text = emailStr;
    _phone.text = [[PFUser currentUser] objectForKey:@"phone"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    CGPoint scrollpoit = CGPointMake(0, textField.frame.origin.y);
    [scrollView setContentOffset:scrollpoit animated:YES];
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    [scrollView setContentOffset:CGPointZero animated:YES];
}


- (IBAction)updatePhone:(id)sender {
    PFUser *user = [PFUser currentUser];
    user.username = _email.text;
    
    user[@"email"] = _email.text;
    user[@"phone"] = _phone.text;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Success" message:@"Email Successfully changes remember your login has changed to a new Email" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            
            [fieldAreEmpty addAction:ok];
            [self presentViewController:fieldAreEmpty animated:YES completion:nil];
 
        }
        else if(error){
            UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Failed" message:@"Please enter a valid email address" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            
            [fieldAreEmpty addAction:ok];
            [self presentViewController:fieldAreEmpty animated:YES completion:nil];
        }
    }];
}


- (IBAction)updatePassword:(id)sender {
    if ([_oldPassword.text isEqualToString:@""] || [_nPassword.text isEqualToString:@""]) {
        
        UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"Please enter valid email" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        
        [fieldAreEmpty addAction:ok];
        [self presentViewController:fieldAreEmpty animated:YES completion:nil];
        
    }
    else if ([_oldPassword.text isEqualToString:_nPassword.text]==true){
        
        UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Same Password" message:@"You cannot reset to the same password please use different password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        
        
        
        [fieldAreEmpty addAction:ok];
        [self presentViewController:fieldAreEmpty animated:YES completion:nil];
    }
    else{
        [self changePassword];
    }
}
    -(void)changePassword{
        [PFUser logInWithUsernameInBackground:currentEmial password:_oldPassword.text block:^(PFUser *user, NSError *error)
         {
             if (user) {
                 user.password = _nPassword.text;
                 [user saveInBackground];
                 
             }
             else{
                 
                 UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Try Again!" message:@"There is problem occured during the password change" preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                          
                                      }];
                 
                 
                 [fieldAreEmpty addAction:ok];
                 [self presentViewController:fieldAreEmpty animated:YES completion:nil];
             }
         }];
    }

@end
