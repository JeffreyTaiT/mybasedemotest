//
//  ViewController.m
//  本地化存储
//
//  Created by Jeffrey on 2018/11/15.
//  Copyright © 2018年 JeffreyTaiT. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "Car+CoreDataClass.h"

@interface ViewController ()
{
    NSManagedObjectContext * _context;
    NSMutableArray * _dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getUserDefault];
    [self getFixPlist];
    [self getQuickPlist];
    [self getArchiver];
    [self getCoreData];
}

/// NSUserDefaults
- (void)getUserDefault{
    [[NSUserDefaults standardUserDefaults] setObject:@"乐芙兰" forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setInteger:(22) forKey:@"age"];
    [[NSUserDefaults standardUserDefaults] setBool:(YES) forKey:@"master"];
    [[NSUserDefaults standardUserDefaults] setValue:@"women" forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *info = [NSString stringWithFormat:@"\nname： %@\nage: %ld\nsex: %@\nmaster: %d\n",[[NSUserDefaults standardUserDefaults] objectForKey:@"name"],(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"age"],[[NSUserDefaults standardUserDefaults] valueForKey:@"sex"],[[NSUserDefaults standardUserDefaults] boolForKey:@"master"]];
    NSLog(@"UserDefaults == %@", info);
}

///固定的plist文件，不方便修改
- (void)getFixPlist{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"FixPlistData == %@",data);
}

///代码创建plist
- (void)getQuickPlist{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filname = [path stringByAppendingString:@"quickPlist.plist"];
    
    NSDictionary *dic = @{@"zzzz":@"name",@"19":@"age"};
    [dic writeToFile:filname atomically:YES];
    
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:filname];
    
    NSLog(@"QuickPlistData == %@",data);
    
    //其他获取目录方法
//    //获取家目录
//    NSString *homeDocumentPath = NSHomeDirectory();
//    //拼接
//    NSString *documents = [homeDocumentPath stringByAppendingPathComponent:@"quickPlist.plist"];
//
//    NSURL *filePath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/// NSKeyedArchiver
- (void)getArchiver{
    Person *person = [[Person alloc] init];
    person.name = @"孙悟空";
    person.age = 1000;
    person.sex = @"公";
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:person forKey:@"model"];
    [archiver finishEncoding];
    NSString *filPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"modelArchiver"];
    if ([data writeToFile:filPath atomically:YES]) {
        NSLog(@"归档成功");
    }
    
    NSData *undata = [[NSData alloc] initWithContentsOfFile:filPath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:undata];
    Person *unPerson = [unarchiver decodeObjectForKey:@"model"];
    NSLog(@"NSKeyedArchiverPerson = %@",unPerson);
    [unarchiver finishDecoding];
}

///保存图片到本地
- (void)saveImageToLocal:(UIImage *)image{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:(__bridge CGImageRef _Nonnull)(image)];
    NSString *imagePath = [path stringByAppendingString:[NSString stringWithFormat:@"%@/image.jpg",path]];
    [UIImagePNGRepresentation(thumb) writeToFile:imagePath atomically:YES];
}

///CoreData
//创建数据库
- (void)createSqlite{
    //1、创建模型对象
    //获取模型路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Car" withExtension:@"momd"];
    //根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    //2、创建持久化存储助理：数据库
    //利用模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库 path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSError *error = nil;
    //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    
    if (error) {
        NSLog(@"添加数据库失败:%@",error);
    } else {
        NSLog(@"添加数据库成功");
    }
    
    //3、创建上下文 保存信息 操作数据库
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //关联持久化助理
    context.persistentStoreCoordinator = store;
    
    _context = context;
}

- (void)getCoreData{
    [self createSqlite];
    
    //插入
    Car *car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:_context];
    Car *car2 = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:_context];
    //赋值
    [car setValue:@"大众" forKey:@"brand"];
    [car setValue:@"白色" forKey:@"color"];
    [car setValue:@(1.8) forKey:@"size"];

    [car2 setValue:@"特斯拉" forKey:@"brand"];
    [car2 setValue:@"银色" forKey:@"color"];
    [car2 setValue:@(2.0) forKey:@"size"];

    //保存
    if (![_context save:nil])
    {
        NSLog(@"保存失败");
    }
    NSLog(@"保存-----");
    [self checkData];
    
    //排序
    //创建排序请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Car"];
    //实例化排序对象
    NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"size"ascending:YES];
    request.sortDescriptors = @[ageSort];
    //发送请求
    NSError *error = nil;
    NSArray *resArray = [_context executeFetchRequest:request error:&error];
    if (error == nil) {
        NSLog(@"排序----");
        [self checkData];
    }else{
        NSLog(@"排序失败, %@", error);
    }

    //修改
    //先查询要修改的对象
    //设置查询条件
    NSPredicate *predicateModify = [NSPredicate predicateWithFormat:@"brand='大众'"];
    request.predicate = predicateModify;

    //执行查询
    NSArray *objectArrayModify = [_context executeFetchRequest:request error:nil];

    //遍历要修改的对象
    for (Car *car in objectArrayModify)
    {
        //修改(修改内存数据，没有同步数据库)
        [car setValue:@(2.0) forKey:@"size"];
    }
    //同步数据库
    [_context save:nil];

    NSLog(@"修改-----");
    [self checkData];

    //删除
    //查询要删除的数据

    //设置查询条件
    NSPredicate *predicateDelte = [NSPredicate predicateWithFormat:@"brand='特斯拉'"];
    request.predicate = predicateDelte;

    //执行查询
    NSArray *objectArrayDel = [_context executeFetchRequest:request error:nil];

    //遍历删除
    for (Car *car in objectArrayDel)
    {
        //删除内存中的数据
        [_context deleteObject:car];
    }

    //同步数据库
    [_context save:nil];

    NSLog(@"删除-----");
    [self checkData];
}

- (void)checkData{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Car"];
    //执行查询
    NSArray *objectArray = [_context executeFetchRequest:request error:nil];

    //遍历查询结果
    for (Car *car in objectArray)
    {
        NSLog(@"%@ - %@ - %@",[car valueForKey:@"brand"],[car valueForKey:@"color"],[car valueForKey:@"size"]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
