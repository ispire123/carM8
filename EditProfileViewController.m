//
//  EditProfileViewController.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 5/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "EditProfileViewController.h"
#import <Parse/Parse.h>

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self retreiveFields];
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

- (IBAction)update:(id)sender {
    [self checkUpdateFields];
}

- (void) retreiveFields{
    NSString *cEmail = [[PFUser currentUser] objectForKey:@"email"];
    PFQuery *profile = [PFQuery queryWithClassName:@"customerMasterDetails"];
    [profile whereKey:@"Email" containsString:cEmail];
    [profile findObjectsInBackgroundWithBlock:^(NSArray *customerProfile, NSError *error){
        if (customerProfile) {
            cProfile = [[NSMutableArray alloc]initWithArray:customerProfile];
            NSLog(@"%@", cProfile);
            _cphone = [cProfile objectAtIndex:5];
        }
        
        
    }];
    
    
    
    
}



- (void) checkUpdateFields{
    if ([_cname.text isEqualToString:@""]||[_cphone.text isEqualToString:@""]==false) {
        PFObject *update = [PFObject objectWithClassName:@"customerMasterDetails"];
        update[@""] = _cname.text;
        update[@""] = _cphone.text;
        [update saveInBackground];
    }
}
@end
