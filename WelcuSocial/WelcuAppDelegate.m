//
//  WelcuAppDelegate.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAppDelegate.h"
#import <CoreText/CoreText.h>
#import <FacebookSDK/FacebookSDK.h>
#import <TestFlightSDK/TestFlight.h>
#import <TestFlightLogger/TestFlightLogger.h>
#import <CocoaLumberjack/DDASLLogger.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaLumberjack/DDFileLogger.h>
#import "AFHTTPRequestOperationLogger.h"
#import <SDSegmentedControl/SDSegmentedControl.h>
#import <R1PhotoEffectsSDK/R1PhotoEffectsSDK.h>

#import "WelcuAccount.h"

@interface WelcuAppDelegate ()
- (void)setupTracking;
- (void)setupLogging;
- (void)setupApperance;
@end

@implementation WelcuAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupTracking];
    [self setupLogging];
    [self setupApperance];
    
//    // Log AvailableFonts
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }

    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // We need to properly handle activation of the application with regards to Facebook Login
    // (e.g., returning from iOS 6.0 Login Dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[WelcuAccount currentAccount] saveContext];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupTracking
{
    [TestFlight takeOff:kWelcuTestflightToken];
    [[R1PhotoEffectsSDK sharedManager] enableWithClientID:@"30b0fc70-c499-0130-216a-22000afc0b0e"];
}

- (void)setupLogging
{
    [DDLog addLogger:[TestFlightLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    [[AFHTTPRequestOperationLogger sharedLogger] setLevel:AFLoggerLevelWarn];
}

- (void)setupApperance
{
    if ([self.window respondsToSelector:@selector(setTintColor:)]) {
        self.window.tintColor = [UIColor whiteColor];
        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSFontAttributeName : [UIFont fontWithName:@"MuseoSans-500"
                                                                                                 size:20]
                                                           }];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName : [UIFont fontWithName:@"MuseoSans-300"
                                                                                                 size:15]
                                                           }
                                                forState:UIControlStateNormal];
    
    [[SDSegmentView appearance] setItemFont:[UIFont fontWithName:@"MuseoSans-500"
                                                            size:12]];


    // Radium One Customizations
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:R1CropModeSquare] forKey:@"R1ExclusiveCropMode"];
//    NSArray *customTabs = @[R1TabEffects, R1TabBorders, R1TabStickers, R1TabText, R1TabDraw];
//    [[NSUserDefaults standardUserDefaults] setObject:customTabs forKey:@"R1TabSetupList"];

    static const NSUInteger R1CropModeSquare = 1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:R1CropModeSquare] forKey:@"R1ExclusiveCropMode"];

    static const NSUInteger R1TabStickers = 0;
    static const NSUInteger R1TabEffects = 1;
    static const NSUInteger R1TabBorders = 2;
    static const NSUInteger R1TabText = 3;
    static const NSUInteger R1TabDraw = 4;
    

    NSArray *customTabs = @[@(R1TabEffects), @(R1TabBorders), @(R1TabStickers), @(R1TabText), @(R1TabDraw)];
    [[NSUserDefaults standardUserDefaults] setObject:customTabs forKey:@"R1TabSetupList"];
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
