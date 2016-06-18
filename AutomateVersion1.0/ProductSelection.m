//
//  ProductSelection.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 28/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "ProductSelection.h"
#import "CleaningDetails.h"
#import <Parse/Parse.h>
#import "ProductCell.h"
@interface ProductSelection ()

@end

@implementation ProductSelection
{
    NSString *productGiven;
    NSString *prodctPrice;
}
@synthesize productTableView;
@synthesize carLocationSelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    _enterDetails.enabled = false;
    NSLog(@"locantin from product%@", carLocationSelected);
    self.title = @"Products";
    PFQuery *query = [PFQuery queryWithClassName:@"cleaningProducts"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *produtsFromParse, NSError *error) {
        if (produtsFromParse) {
            NSLog(@"%@", produtsFromParse);
            products = [[NSMutableArray alloc] initWithArray: produtsFromParse];

    
        }
        [productTableView reloadData];
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
    return products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"productCell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    PFObject *parseObj = [products objectAtIndex:indexPath.row];
    cell.productType.text = [parseObj objectForKey:@"type"];
    cell.productPrice.text = [parseObj objectForKey:@"price"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    _enterDetails.enabled = true;
    PFObject *label = [products objectAtIndex:indexPath.row];
    productGiven = [label objectForKey:@"type"];
    prodctPrice = [label objectForKey:@"price"];
    _productInfo.text = [label objectForKey:@"info"];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"enterDetails"]) {
        CleaningDetails *nextView = segue.destinationViewController;
        
        nextView.productSelected = productGiven;
        nextView.productPrice = prodctPrice;
        nextView.lSelected = carLocationSelected;
    }
}



@end

