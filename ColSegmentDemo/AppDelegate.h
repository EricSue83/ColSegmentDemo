//
//  AppDelegate.h
//  ColSegmentDemo
//
//  Created by EricSue on 19/05/2018.
//  Copyright © 2018 EricSue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

