//
//  CustomerDashboard.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "CustomerDashboard.h"
#import <Parse/Parse.h>
#import "DashboardCell.h"
@interface CustomerDashboard ()

@end

@implementation CustomerDashboard
@synthesize cusTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Dashboard";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backimg1.png"]];
    NSString *currentUser = [[PFUser currentUser] objectForKey:@"fullName"];
    _welcomeLabel.text = [@"Hello, " stringByAppendingString:currentUser];
    
    NSString *customerID = [PFUser currentUser].objectId ;
    PFQuery *query1 = [PFQuery queryWithClassName:@"ServiceRequests"];
    [query1 whereKey:@"customer" equalTo:customerID];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray * serviceobjects, NSError *error) {
        if (!error) {
            currentJobs = [[NSMutableArray alloc] initWithArray:serviceobjects];
            NSLog(@"%@", currentJobs);
        }
        [cusTableView reloadData];
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
    
    return currentJobs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleIdentifier = @"jobcell";
    DashboardCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    // Configure the cell...
    PFObject *parseobject = [currentJobs objectAtIndex:indexPath.row];
    
    serviceid = [parseobject objectForKey:@"serviceName"];
    carid = [parseobject objectForKey:@"car"];
    cell.cleanAddress.text = [parseobject objectForKey:@"location"];
    cell.cleanDate.text = [parseobject objectForKey:@"date"];
    cell.cleanTime.text = [parseobject objectForKey:@"time"];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"services"];
    [query2 getObjectInBackgroundWithId:serviceid block:^(PFObject *serviceobject, NSError *error) {
        if (!error) {
            NSLog(@"%@",serviceobject);
           
        }
    }];
    
    PFQuery *query3 = [PFQuery queryWithClassName:@"customerCars"];
    [query3 getObjectInBackgroundWithId:carid block:^(PFObject *carobject, NSError *error) {
        if (!error) {
            NSLog(@"%@",carobject);
            cell.cleanRego.text = [carobject objectForKey:@"rego"];
            cell.cleanModel.text = [carobject objectForKey:@"model"];
        }
    }];
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
