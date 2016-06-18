//
//  CustomerCarSelection.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 9/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "CustomerCarSelection.h"
#import <Parse/Parse.h>
#import "carSelectCellTableViewCell.h"



@interface CustomerCarSelection ()

@end

@implementation CustomerCarSelection


@synthesize carListTableView;
@synthesize carSelectedForService;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"appTheme"]];
    
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
        
        [carListTableView reloadData];
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
    static NSString *simpleTableIdentifier = @"carSelectionCellOne";
    carSelectCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    PFObject *parseObj = [cellDetails objectAtIndex:indexPath.row];
    cell.carMake.text = [parseObj objectForKey:@"make"];
    cell.carModel.text = [parseObj objectForKey:@"model"];
    cell.carYear.text = [parseObj objectForKey:@"year"];
    cell.carRego.text = [parseObj objectForKey:@"rego"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell tabbed");
    PFObject *temp = [cellDetails objectAtIndex:indexPath.row];
    carSelectedForService = temp.objectId;
    
    
   }


#pragma mark - Navigation


- (IBAction)next:(id)sender {
}
- (IBAction)back:(id)sender {
    UIViewController *tabView = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboardNavigation"];
    [self presentViewController:tabView animated:YES completion:nil];
}
@end
