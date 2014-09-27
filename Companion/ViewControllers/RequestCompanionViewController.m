//
//  RequestCompanionViewController.m
//  Companion
//
//  Created by Eduardo Antoni Carrillo Albor on 9/27/14.
//  Copyright (c) 2014 Keduardo. All rights reserved.
//

#import "RequestCompanionViewController.h"
#import "Consumer.h"
#import <Parse/Parse.h>

@import MapKit;
@import CoreLocation;

@interface RequestCompanionViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapRequestCompanion;
@property (nonatomic, strong) CLLocationManager * manager;
@property (nonatomic, strong) MKPinAnnotationView * annotationView;
@property (nonatomic, strong) MKPointAnnotation * annotation
@end

@implementation RequestCompanionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(![PFUser currentUser])
    {
        UINavigationController * loginNAvigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self presentViewController:loginNAvigationController
                           animated:NO
                         completion:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([PFUser currentUser])
    {
        
        if(!_manager)
        {
            _manager = [[CLLocationManager alloc] init];
        }
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
        {
            [self.manager startUpdatingLocation];
        }
        else
        {
            [self.manager requestWhenInUseAuthorization];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRequestMapRegion:(CLLocation*)location
{
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01, 0.01));
    [self.mapRequestCompanion setRegion:region animated:YES];
    self.annotation = [[MKPointAnnotation alloc] init];
    self.annotation.coordinate = location.coordinate;
    self.annotation.title = @"Set Pick Up Location";
    [self.mapRequestCompanion addAnnotation:self.annotation];
}

-(void)requestACompanion:(id)sender
{
    CLLocationCoordinate2D coordinate = self.annotation.coordinate;
    CLLocation * location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [[Consumer sharedInstance] requestCompanionsAroundCoordinate:location completitionBlock:^(NSArray *companions) {
        
    }];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.manager stopUpdatingLocation];
    CLLocation * location = [locations lastObject];
    [self setRequestMapRegion:location];
    self.mapRequestCompanion.showsUserLocation = YES;
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.manager startUpdatingLocation];
    }
}

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        self.annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
        
        if(!self.annotationView)
        {
            self.annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
            self.annotationView.canShowCallout = YES;
        }
        UIButton * btnRightCallout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [btnRightCallout addTarget:self action:@selector(requestACompanion:) forControlEvents:UIControlEventTouchUpInside];
        self.annotationView.rightCalloutAccessoryView = btnRightCallout;
        return self.annotationView;
    }
    return nil;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}
@end
