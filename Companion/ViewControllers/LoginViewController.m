//
//  LoginViewController.m
//  Companion
//
//  Created by Eduardo Antoni Carrillo Albor on 9/27/14.
//  Copyright (c) 2014 Keduardo. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnLoginWithFacebook;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginWithFacebook:(id)sender
{
    [PFFacebookUtils logInWithPermissions:@[@"public_profile", @"email"] block:^(PFUser *user, NSError *error) {
        if (!user)
        {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        }
        else if (user.isNew)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"User signed up and logged in through Facebook!");
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"User logged in through Facebook!");
        }
    }];
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
