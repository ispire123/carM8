//
//  cancelService.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 19/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "cancelService.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
#import "CurrentJobsTableViewCell.h"
#import "DetailedServiceList.h"
@interface cancelService ()

@end

@implementation cancelService

@synthesize canceljobTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
    NSString *customerID = [PFUser currentUser].objectId ;
    PFQuery *query = [PFQuery queryWithClassName:@"cleaningService"];
    [query whereKey:@"customer" equalTo:customerID];
    NSLog(@"%@", canceljobList);
    [query findObjectsInBackgroundWithBlock:^(NSArray * serviceobjects, NSError *error) {
       if (!error) {
        canceljobList = [[NSMutableArray alloc] initWithArray:serviceobjects];
        NSLog(@"%@", canceljobList);
        }
        [canceljobTable reloadData];
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return canceljobList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CurrentJobsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"canceljobcell" forIndexPath:indexPath];
    
    // Configure the cell...
    PFObject *parseobject = [canceljobList objectAtIndex:indexPath.row];
    
            cell.car.text = [parseobject objectForKey:@"car"];
            cell.location.text = [parseobject objectForKey:@"location"];
    cell.product.text =[parseobject objectForKey:@"product"];
    
    NSString *statusName = [parseobject objectForKey:@"status"];
    
    if ([statusName isEqualToString:@"requested"]) {
        cell.serviceProgress.progress = 0.1;
        
    }
    else if ([statusName isEqualToString:@"accepted"])
    {
        cell.serviceProgress.progress = 0.5;
       
    }
    else if ([statusName isEqualToString:@"completed"])
    {
        cell.serviceProgress.progress = 1.0;
        
    }
    
    else if ([statusName isEqualToString:@"cancelled"])
    {
        cell.serviceProgress.progress = 1.0;
        cell.serviceProgress.tintColor = [UIColor redColor];
        cell.status.hidden = YES;
        cell.status1.text = @"cancelled";
        cell.status1.textColor = [UIColor blackColor];
        cell.status2.hidden = YES;
    }
    
    
    cell.serviceCancelButton.tag = indexPath.row;
    
    [cell.serviceCancelButton addTarget:self action:@selector(cancelService:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *segue = [canceljobList objectAtIndex:indexPath.row];
    objectId = segue.objectId;
    carRego = [segue objectForKey:@"car"];
    date = [segue objectForKey:@"date"];
    time = [segue objectForKey:@"time"];
    location = [segue objectForKey:@"location"];
    productChoosen = [segue objectForKey:@"product"];
    status = [segue objectForKey:@"status"];
    [self performSegueWithIdentifier:@"serviceDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"serviceDetails"]) {
        
        DetailedServiceList
        *nextView = segue.destinationViewController;

        nextView.ser_ObjectId = objectId;
        nextView.ser_CarRego = carRego;
        nextView.ser_Date = date;
        nextView.ser_Time = time;
        nextView.ser_Product = productChoosen;
        nextView.ser_Status = status;
        nextView.ser_Location = location;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    return YES;
    
}




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      
        PFObject *object = [canceljobList objectAtIndex:indexPath.row];
       
        [canceljobList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         
         {
             
             if (succeeded) {
                 
                 NSLog(@"Deleted");
                 
                 [canceljobTable reloadData];
             }
         }];
    }
    
    else
        
    {
        
        NSLog(@"Error");
        
    }
    
}



- (void)cancelService:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Service"];
    // Retrieve the object by id
    
    [query getObjectInBackgroundWithId:@"xWMyZ4YEGZ"
                                 block:^(PFObject *gameScore, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     gameScore[@"cheatMode"] = @YES;
                                     gameScore[@"score"] = @1338;
                                     [gameScore saveInBackground];
                                 }];
}
@end
