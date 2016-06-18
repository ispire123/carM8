//
//  CarSelectTableViewTableViewController.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 15/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "CarSelectTableViewTableViewController.h"
#import <Parse/Parse.h>
#import "CarSelectionCell.h"
#import "CleaningDetails.h"
@interface CarSelectTableViewTableViewController ()
{
    NSString *carSelectedForClean;
}
@end

@implementation CarSelectTableViewTableViewController
@synthesize cleaningCarTableView;
- (void)viewDidLoad{
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString *currentUserEmail = [[PFUser currentUser] objectForKey:@"email"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"customerCars"];
    [query whereKey:@"cEmail" containsString:currentUserEmail];
    NSLog(@"%@",currentUserEmail);
    [query findObjectsInBackgroundWithBlock:^(NSArray *customerCarFromParse, NSError *error) {
        if (customerCarFromParse) {
            cellDetails = [[NSArray alloc] initWithArray:customerCarFromParse];
            NSLog(@"%@", customerCarFromParse);
            
        }
        //NSLog(customerCars);
        
        [cleaningCarTableView reloadData];
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
    return cellDetails.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"carSelectionClean";
    CarSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    PFObject *parseObj = [cellDetails objectAtIndex:indexPath.row];
    cell.make.text = [parseObj objectForKey:@"make"];
    cell.model.text = [parseObj objectForKey:@"model"];
    cell.year.text = [parseObj objectForKey:@"year"];
    cell.rego.text = [parseObj objectForKey:@"rego"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell tabbed");
    PFObject *temp = [cellDetails objectAtIndex:indexPath.row];
    carSelectedForClean = temp.objectId;
    
   // CleaningDetails *CD = [self.storyboard instantiateViewControllerWithIdentifier:@"cleanDetails"];
    
   // CD.carSelected = carSelectedForClean;
    
    
 //   [self presentViewController:CD animated:YES completion:nil];
    
}

- (IBAction)back:(id)sender {
    UIViewController *tabView = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboardNavigation"];
    [self presentViewController:tabView animated:YES completion:nil];
}

@end
