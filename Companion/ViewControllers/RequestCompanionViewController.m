//
//  RequestCompanionViewController.m
//  Companion
//
//  Created by Eduardo Antoni Carrillo Albor on 9/27/14.
//  Copyright (c) 2014 Keduardo. All rights reserved.
//

#import "RequestCompanionViewController.h"

#import <Parse/Parse.h>

@import MapKit;

@interface RequestCompanionViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapRequestCompanion;

@end

@implementation RequestCompanionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(![PFUser currentUser])
    {
        UINavigationController * loginNAvigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self presentViewController:loginNAvigationController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
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

@end
