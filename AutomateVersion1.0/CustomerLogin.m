//
//  CustomerLogin.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 22/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "CustomerLogin.h"
#import <Parse/Parse.h>
#import "TextFieldValidator.h"

@interface CustomerLogin () <UITextFieldDelegate>
{
    IBOutlet TextFieldValidator *cusEmail;
    IBOutlet TextFieldValidator *cusPassword;
    
}



@end


#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"

@implementation CustomerLogin
@synthesize scrollView;
@synthesize emailID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupAlerts];
}

- (void)viewDidAppear:(BOOL)animated{
    
    PFUser *currentuser = [PFUser currentUser];
    if(currentuser)
    {
        UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *tabView = [dashboard instantiateViewControllerWithIdentifier:@"FirstView"];
        [self presentViewController:tabView animated:YES completion:nil];
    }
    else{
        NSLog(@"Problem in login");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)setupAlerts{
    
    [cusEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    [cusPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [cusPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    [cusPassword resignFirstResponder];
    if([cusEmail validate] & [cusPassword validate]){
        [self customerLogin];
    }
    
    
    
}

-(void)customerLogin{
        [PFUser logInWithUsernameInBackground:cusEmail.text password:cusPassword.text
         block:^(PFUser *user, NSError *error) {
         if (!(error)) {
         //[self performSegueWithIdentifier:@"loginSuccess" sender:self];
        NSLog(@"Should change to dashboard here");
        UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *tabView = [dashboard instantiateViewControllerWithIdentifier:@"FirstView"];
        [self presentViewController:tabView animated:YES completion:nil];
             PFInstallation *installation = [PFInstallation currentInstallation];
             installation[@"user"] = [PFUser currentUser].objectId;
             [installation saveInBackground];
         
         }
        else
        
        {
        // The login failed. Check error to see why.
        NSLog(@"login failed");
            UIAlertController *wronglogin = [UIAlertController alertControllerWithTitle:@"Failed" message:@"Please enter your correct username and password" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [wronglogin dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            UIAlertAction* fg = [UIAlertAction
                                 actionWithTitle:@"forgot password"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {

                                    UIViewController *forgot = [self.storyboard instantiateViewControllerWithIdentifier:@"forgotPassword"];
                                     [self presentViewController:forgot animated:YES completion:nil];
                                     
                                 }];
            
            [wronglogin addAction:ok];
            [wronglogin addAction:fg];
            [self presentViewController:wronglogin animated:YES completion:nil];
    
       }
      }];

}

- (IBAction)tabges:(id)sender {
    [self.view endEditing:YES];
    [self.view1 endEditing:YES];
    [self dissmisskeyboard];
}



-(void) dissmisskeyboard{
    [cusEmail resignFirstResponder];
    [cusPassword resignFirstResponder];
}


#pragma mark - UITextFieldDelegate
 - (BOOL)textFieldShouldReturn:(UITextField *)textField{
     if(textField == cusEmail){
         [cusEmail resignFirstResponder];
         [cusPassword becomeFirstResponder];
     }
     else if (textField == cusPassword)
     {
     [cusPassword resignFirstResponder];
     
     }
    return YES;
}
- (IBAction)backAction:(id)sender {
    UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabView = [dashboard instantiateViewControllerWithIdentifier:@"homeScreen1"];
    [self presentViewController:tabView animated:YES completion:nil];
    
}


@end

