//
//  AppDelegate.m
//  AresChooseButtonAnimationDemo
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import "AppDelegate.h"

#import "Path_NSObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
    
    NSString *dataFile=[[shaXiang docPath] stringByAppendingPathComponent:@"one.plist"];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:dataFile];
    
    if(nil == array){
        
        [self doAdd];
    }
    return YES;
}

/**
 *  添加数据
 */
-(void) doAdd{
    
    Path_NSObject *shaXiang = [[Path_NSObject alloc] init];
    NSString *docPath=[shaXiang docPath];
    NSLog(@"当前docment路径：\n%@",docPath);
    
    NSString *dataFile=[docPath stringByAppendingPathComponent:@"one.plist"];
    if (YES==[shaXiang isFileNeedCreate:dataFile]) {
        NSLog(@"文件原先不存在，现已新建空文件！");
    }else{
        NSLog(@"文件已存在，无需创建！");
    }
    
    NSMutableArray *plistDic = [[NSMutableArray alloc ] init];
    // 添加字典
    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"未读通知",@"text",@"a5",@"image",nil]];
    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"已读通知",@"text",@"a6",@"image",nil]];
    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"未读材料",@"text",@"a7",@"image",nil]];
    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"已读材料",@"text",@"a8",@"image",nil]];
    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"任务撰写",@"text",@"a0",@"image",nil]];
    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"任务检索",@"text",@"a1",@"image",nil]];
    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"收文待阅",@"text",@"a2",@"image",nil]];
    
    [plistDic addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"换一换",@"text",@"a16",@"image",nil]];
    
    [plistDic writeToFile:dataFile atomically:YES];//完全覆盖
    NSLog(@"添加内容完成！！");
    
    //添加第二个数据plist
    NSString *dataFile_02=[docPath stringByAppendingPathComponent:@"two.plist"];
    NSMutableArray *plistDic_02 = [[NSMutableArray alloc ] init];
    // 添加字典
    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"收文办理",@"text",@"a4",@"image",nil]];
    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"发文办理",@"text",@"a8",@"image",nil]];
    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"请假审核",@"text",@"a10",@"image",nil]];
    [plistDic_02 addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"离常检索",@"text",@"a9",@"image",nil]];
    
    [plistDic_02 writeToFile:dataFile_02 atomically:YES];//完全覆盖
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"AresChooseButtonAnimationDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
