//
//  DetailedServiceList.m
//  AutomateVersion1.0
//
//  Created by admin on 9/05/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "DetailedServiceList.h"
#import <Parse/Parse.h>
@interface DetailedServiceList ()

@end

@implementation DetailedServiceList
@synthesize ser_CarRego;
@synthesize ser_Date;
@synthesize ser_Time;
@synthesize ser_Location;
@synthesize ser_Product;
@synthesize ser_Status;
@synthesize ser_ObjectId;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    [self stat];
    NSLog(@"%@", ser_Status);
    _ser_Detail_carRego.text = ser_CarRego;
    _ser_Detail_date.text = ser_Date;
    _ser_Detail_time.text = ser_Time;
    _ser_Detail_location.text = ser_Location;
    _ser_Detail_product.text = ser_Product;
    
    if ([ser_Product isEqualToString:@"Hatch"]) {
        _ser_Detail_total.text = @"$25";
        
    }
    else if ([ser_Product isEqualToString:@"Sedan"]){
        _ser_Detail_total.text = @"$30";
    }
    else if ([ser_Product isEqualToString:@"SUV"]){
        _ser_Detail_total.text = @"$35";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stat{
    if ([ser_Status isEqualToString:@"requested"]) {
        _statusBar.progress = 0.1;
        _cancelButton.enabled = true;
    }
    else if ([ser_Status isEqualToString:@"accepted"])
    {
        _statusBar.progress = 0.5;
        _cancelButton.enabled = false;
    }
    else if ([ser_Status isEqualToString:@"completed"])
    {
        _statusBar.progress = 1.0;
        _cancelButton.enabled = false;
    }
    else if ([ser_Status isEqualToString:@"cancelled"]){
        _st1.hidden = YES;
        _st2.hidden = YES;
        _st3.hidden = YES;
        _statusBar.progress = 1.0;
        _statusBar.tintColor = [UIColor redColor];
        _cancelstatus.hidden = NO;
        _cancelButton.enabled = false;
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelService:(id)sender {
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Cancellation"
                                 message:@"Please Choose any appropriate"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Booked other service"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             [self Cancelation];
                             
                             
                            
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Not satisfied"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self Cancelation];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction* cancel1 = [UIAlertAction
                             actionWithTitle:@"Want to reschedule"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self reschedule];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    UIAlertAction* cancel2 = [UIAlertAction
                              actionWithTitle:@"Don't Cancel"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                              [view dismissViewControllerAnimated:YES completion:nil];
                              }];

    
    
    [view addAction:ok];
    [view addAction:cancel];
    [view addAction:cancel1];
    [view addAction:cancel2];
    
    [self presentViewController:view animated:YES completion:nil];

}


-(void)reschedule{
    
    UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Reschedule" message:@"To Reschedule you have to book a new service, Current request will be deleted from our records" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Book"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             PFQuery *query = [PFQuery queryWithClassName:@"cleaningService"];
                             // Retrieve the object by id
                            
                             [query getObjectInBackgroundWithId:ser_ObjectId
                                                          block:^(PFObject *serviceDet, NSError *error) {
                                                              
                                                              
                             [serviceDet deleteInBackground];
                        }];
                             UIViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstView"];
                             [self presentViewController:go animated:YES completion:nil];
                        }];
    UIAlertAction* ok1 = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                             
                        }];
    
    [fieldAreEmpty addAction:ok];
    [fieldAreEmpty addAction:ok1];
    [self presentViewController:fieldAreEmpty animated:YES completion:nil];
    
}

-(void)Cancelation{
    UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Sucess" message:@"Thanks for using carM8, You Service Request has been successfully cancelled" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             PFQuery *query = [PFQuery queryWithClassName:@"cleaningService"];
                             // Retrieve the object by id
                             
                             [query getObjectInBackgroundWithId:ser_ObjectId
                                                          block:^(PFObject *serviceDet, NSError *error) {
                                                              // Now let's update it with some new data. In this case, only cheatMode and score
                                                              // will get sent to the cloud. playerName hasn't changed.
                                                              serviceDet[@"status"] = @"cancelled";
                                                              
                                                              [serviceDet saveInBackground];
                                                          }];

                             
                             [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                             _cancelButton.enabled = NO;
                         
                         }];
    [fieldAreEmpty addAction:ok];
    [self presentViewController:fieldAreEmpty animated:YES completion:nil];
}


@end
