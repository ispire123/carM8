//
//  ForgotPassword.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 12/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "ForgotPassword.h"
#import <Parse/Parse.h>
@interface ForgotPassword ()

@end

@implementation ForgotPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)recoverPassword:(id)sender {
    if ([_email.text isEqualToString:@""]==false) {
        [self changePassword];
    }
    else{
        UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Missing" message:@"Please enter Email" preferredStyle:UIAlertControllerStyleAlert];
        
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
}

-(void)changePassword{
    [PFUser requestPasswordResetForEmailInBackground:_email.text block:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please check you Email" preferredStyle:UIAlertControllerStyleAlert];
            
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
        else if(error)
        {
            UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Error" message:@"This Email is not registed with us" preferredStyle:UIAlertControllerStyleAlert];
            
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
