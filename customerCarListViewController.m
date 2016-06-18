//
//  customerCarListViewController.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 2/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "customerCarListViewController.h"
#import <Parse/Parse.h>
#import "customerCars.h"

@interface customerCarListViewController ()

@end


@implementation customerCarListViewController

@synthesize tablecarList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.title = @"My Cars";
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tablecarList.tableFooterView = footerView;
   //[self showNormalNavigationBar];
    self.tablecarList.delegate = self;
    self.tablecarList.dataSource = self;

    NSString *uType = [[PFUser currentUser] objectForKey:@"email"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"customerCars"];
    [query whereKey:@"cEmail" containsString:uType];
    NSLog(@"%@",uType);
    [query findObjectsInBackgroundWithBlock:^(NSArray *customerCarFromParse, NSError *error) {
        if (customerCarFromParse) {
            carList = [[NSMutableArray alloc ] initWithArray:customerCarFromParse];
            cellDetails = [[NSArray alloc] initWithArray:customerCarFromParse];
            NSLog(@"%@", customerCarFromParse);
        }
        
        [tablecarList reloadData];
    }];
}

-(void)showNormalNavigationBar
{
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem.backBarButtonItem setAction:@selector(goBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewCar)];
}

-(void)addNewCar{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *CC = [storyboard instantiateViewControllerWithIdentifier:@"addCars"];
    [self presentViewController:CC animated:YES completion:nil];
    
}

-(void) goBack
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = @"alignedCube";
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return carList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *simpleTableIdentifier = @"mycarslist";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    PFObject *parseObj = [carList objectAtIndex:indexPath.row];
    
   
    
    cell.textLabel.text = [parseObj objectForKey:@"make"];
    
    
    
    cell.detailTextLabel.text = [parseObj objectForKey:@"model"];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    return YES;
    
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        
        
        
        
        
        
        
        PFObject *object = [carList objectAtIndex:indexPath.row];
        
        
        
        [carList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         
         {
             
             if (succeeded) {
                 
                 NSLog(@"Deleted");
                 
                 [tablecarList reloadData];
                 
             }
             
         }];
        
        
        
        
        
    }
    
    else
        
    {
        
        NSLog(@"Error");
        
    }
    
}

- (IBAction)backButton:(id)sender {
    UIViewController *tabView = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboardNavigation"];
    [self presentViewController:tabView animated:YES completion:nil];
}
@end
