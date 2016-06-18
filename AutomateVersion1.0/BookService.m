//
//  BookService.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "BookService.h"
#import <Parse/Parse.h>
#import "carSelectCellTableViewCell.h"
@interface BookService ()

@end

@implementation BookService

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    NSString *uType = [[PFUser currentUser] objectForKey:@"email"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"customerCars"];
    [query whereKey:@"cEmail" containsString:uType];
    NSLog(@"%@",uType);
    [query findObjectsInBackgroundWithBlock:^(NSArray *customerCarFromParse, NSError *error) {
        if (customerCarFromParse) {
            customerCars = [[NSArray alloc ] initWithArray:customerCarFromParse];
            cellDetails = [[NSArray alloc] initWithArray:customerCarFromParse];
            NSLog(@"%@", customerCarFromParse);
            
        }
        //NSLog(customerCars);
        
        [tableView reloadData];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return customerCars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *simpleTableIdentifier = @"cell";
    
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    carSelectCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    PFObject *parseObj = [customerCars objectAtIndex:indexPath.row];

   // cell.textLabel.text = [parseObj objectForKey:@"make"];
    
    cell.carMake.text = [parseObj objectForKey:@"make"];
    cell.carModel.text = [parseObj objectForKey:@"model"];
    cell.carYear.text = [parseObj objectForKey:@"year"];
    cell.carRego.text = [parseObj objectForKey:@"rego"];
    
    
   // cell.detailTextLabel.text = [parseObj objectForKey:@"model"];
    
    return cell;
    
}

//user to select the cell
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell tabbed");
    PFObject *temp = [customerCars objectAtIndex:indexPath.row];
    NSLog(@"%@", temp.objectId);
    
    
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
