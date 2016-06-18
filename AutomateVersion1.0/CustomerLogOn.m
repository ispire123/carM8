//
//  CustomerLogOn.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 22/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "CustomerLogOn.h"
#import <Parse/Parse.h>
#import "TextFieldValidator.h"

@interface CustomerLogOn ()<UITextFieldDelegate>{
    IBOutlet TextFieldValidator *cFullName;
    IBOutlet TextFieldValidator *cFullLstName;
    IBOutlet TextFieldValidator *cEmail;
    IBOutlet TextFieldValidator *cMobileNumber;
    IBOutlet TextFieldValidator *cPassword;
    IBOutlet TextFieldValidator *cConfirmPassword;
}
@end

#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
//#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"
#define REGEX_PHONE_DEFAULT @"[0-9]{10}"



@implementation CustomerLogOn
@synthesize scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAlerts];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupAlerts{
    [cFullName addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    [cFullName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    cFullName.validateOnResign=NO;
    
    [cEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [cMobileNumber addRegx:REGEX_PHONE_DEFAULT withMsg:@"phone number must be of 10 digits eg: 0469407546"];
    
    [cPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [cPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    [cConfirmPassword addConfirmValidationTo:cPassword withMsg:@"Confirm password didn't match."];
    
    
    //cMobileNumber.isMandatory=NO;
}


- (IBAction)customerSignUpAction:(id)sender {
    if([cFullName validate] & [cFullLstName validate] & [cEmail validate] & [cMobileNumber validate] & [cPassword validate] & [cPassword validate] & [cConfirmPassword validate]){
        [self LogOnCustomer];
    }

}

-(void)LogOnCustomer{
    PFUser *customerReg = [PFUser user];
    customerReg.username = cEmail.text;
    customerReg.password = cPassword.text;
    customerReg.email = cEmail.text;
    customerReg[@"phone"] = cMobileNumber.text;
    customerReg[@"firstName"] = cFullName.text;
    customerReg[@"lastName"] = cFullLstName.text;
    customerReg[@"userType"] = @"customer";
    [customerReg signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            UIAlertController *registrationError = [UIAlertController alertControllerWithTitle:@"SignUp success" message:@"Registration completed successfully" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                [registrationError dismissViewControllerAnimated:YES completion:nil];
                UIViewController *tabView = [self.storyboard instantiateViewControllerWithIdentifier:@"homeScreen"];
                [self presentViewController:tabView animated:YES completion:nil];
                
            }];
            [registrationError addAction:ok];
            [self presentViewController:registrationError animated:YES completion:nil];
            
        }
        else{
            UIAlertController *registrationError = [UIAlertController alertControllerWithTitle:@"LogOn Failed" message:@"The Email Address Already Taken" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                [registrationError dismissViewControllerAnimated:YES completion:nil];
            }];
            [registrationError addAction:ok];
            [self presentViewController:registrationError animated:YES completion:nil];
        }
    }];

}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == cFullName){
        [cFullName resignFirstResponder];
        [cFullLstName becomeFirstResponder];
    }
    else if (textField == cFullLstName)
    {
        [cFullLstName resignFirstResponder];
        [cEmail becomeFirstResponder];
    }
    else if(textField == cEmail){
        [cEmail resignFirstResponder];
        [cMobileNumber becomeFirstResponder];
    }
    else if (textField == cMobileNumber){
        [cMobileNumber resignFirstResponder];
        [cPassword becomeFirstResponder];
    }
    else if (textField == cPassword){
        [cPassword resignFirstResponder];
        [cConfirmPassword becomeFirstResponder];
        
    }
    else if(textField == cConfirmPassword){
        [cConfirmPassword resignFirstResponder];
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
        [scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    
}


- (IBAction)backAction:(id)sender {
    UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabView = [dashboard instantiateViewControllerWithIdentifier:@"homeScreen1"];
    [self presentViewController:tabView animated:YES completion:nil];
}
@end

