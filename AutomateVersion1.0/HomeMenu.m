//
//  HomeMenu.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 22/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "HomeMenu.h"
#import <Parse/Parse.h>
@interface HomeMenu ()

@end

@implementation HomeMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self checkCurrentUser];
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
-(void) checkCurrentUser{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        //find User Type
        [self checkUserType];
    } else {
        UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *logback = [dashboard instantiateViewControllerWithIdentifier:@"homeScreen"];
        [logback loadView];
    }
}

-(void) checkUserType{
    NSString *uType = [[PFUser currentUser] objectForKey:@"userType"];
    if ([uType  isEqual: @"customer"]) {
        //Redirect customer View DashBoard
        NSLog(@"The user is a customer");
        UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // UIViewController *change = [dashboard instantiateViewControllerWithIdentifier:@"customerDashboard"];
        //  [change loadView];
        UITabBarController *tabView = [dashboard instantiateViewControllerWithIdentifier:@"customerDashboard"];
        //[tabView loadView];
        [self presentViewController:tabView animated:YES completion:nil];
        
        
    }
    else if([uType isEqual:@"mechanic"]){
        //Redirect to mechanic Page
        NSLog(@"The user is Mechanic");
        UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *mechTab = [dashboard instantiateViewControllerWithIdentifier:@"mechanicHome"];
        [self presentViewController:mechTab animated:YES completion:nil];
    }
    else{
        //Undefined User
        NSLog(@"The user type is undefined");
    }
}

@end
