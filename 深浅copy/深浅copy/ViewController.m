//
//  ViewController.m
//  深浅copy
//
//  Created by Jeffrey on 2018/10/31.
//  Copyright © 2018年 JeffreyTaiT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textTitle;
@property (weak, nonatomic) IBOutlet UITextField *textContent;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;

- (IBAction)btnArchiver:(id)sender;
- (IBAction)btnUnarchiver:(id)sender;


@property (nonatomic, strong)NSString *documentsPath;

@end

@implementation ViewController

- (NSString *)documentsPath{
    if (!_documentsPath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
        if (paths.count > 0) {
            _documentsPath = paths.firstObject;
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:_documentsPath]) {
                NSError *error;
                if (![[NSFileManager defaultManager] createDirectoryAtPath:_documentsPath withIntermediateDirectories:YES attributes:nil error:&error]) {
                    NSLog(@"创建失败");
                }
            }
        }
    }
    return _documentsPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //UI初始化
    [self initView];
    
    //浅-不可变
    [self immutableObjectCopy];
    
    //浅-可变
    [self mutableObject];
    
    //浅-容器
    [self shallowCopyCollections];
    
    //深- 一层复制
    [self oneLevelDeepCopy];
    
    //归档深拷贝
    [self trueDeepCopy];
}

- (void)initView{
    [self.textTitle addTarget:self action:@selector(textFieldTitleDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.textContent addTarget:self action:@selector(textFieldContentDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTitleDidChange:(UITextField *)textField{
    
}

- (void)textFieldContentDidChange:(UITextField *)textField{
    
}

#pragma mark- 归档
- (void)setArchiverwithObj:(id)obj{
    
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:self.documentsPath];
    
    if (![NSKeyedArchiver archiveRootObject:obj toFile:@"testArchiver"]) {
        NSLog(@"归档失败");
    }else{
        NSLog(@"归档成功");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnArchiver:(id)sender {
    if (self.textTitle.text.length == 0 || self.textContent.text.length == 0) {
        NSLog(@"请完善信息");
        return;
    }
    NSDictionary *dic = @{@"title":self.textTitle.text,@"content":self.textContent.text};
    [self setArchiverwithObj:dic];
}

- (IBAction)btnUnarchiver:(id)sender {
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:@"testArchiver"];
    self.labelTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    self.labelContent.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
}

#pragma mark- 拷贝
///浅拷贝  不可变
- (void)immutableObjectCopy{
    NSString *string1 = @"abc";
    NSString *string2 = string1;
    NSString *stringCopy = [string1 copy];
    NSMutableString *stringMutableCopy = [string1 mutableCopy];
    
    NSLog(@"\n-----浅拷贝不可变-----\nstring1 = %p\nstring2 = %p\nstringCopy = %p\nstringMutable = %p",string1,string2,stringCopy,stringMutableCopy);
}

///浅拷贝  可变
- (void)mutableObject{
    NSMutableString *mString1 = [NSMutableString stringWithFormat:@"abc"];
    NSMutableString *mStringCopy = [mString1 copy];
    NSMutableString *mString3 = [mString1 copy];
    NSMutableString *mStringMCopy = [mString1 mutableCopy];
    
    [mString1 appendString:@"def"];
//    [mStringCopy appendString:@"error"];//错误
    [mStringMCopy appendString:@"ghi"];
    
    NSLog(@"\n-----浅拷贝可变-----\nmstring1 = %@\nmStringCopy = %@\nmString3 = %@\nmStringMCopy = %@",mString1,mStringCopy,mString3,mStringMCopy);
    
    NSLog(@"\n-----浅拷贝可变-----\nmstring1 = %p\nmStringCopy = %p\nmString3 = %p\nmStringMCopy = %p",mString1,mStringCopy,mString3,mStringMCopy);
}

///浅拷贝  容器类
- (void)shallowCopyCollections{
    NSMutableArray *mArr1 = [NSMutableArray arrayWithObjects:@"Red",@"Green",@"Blue", nil];
    NSMutableArray *mArr2 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",mArr1,nil];
    
    NSMutableArray *mArr3 = [mArr2 mutableCopy];
    
    mArr3[3][2] = @"yellow";
    
    NSLog(@"\nmArr3 = %@\nmArr2 = %@",mArr3,mArr2);
    
//========================================================================================//
    
    // 1.创建一个不可变数组，数组内元素为可变字符串。
    NSMutableString *red = [NSMutableString stringWithString:@"Red"];
    NSMutableString *green = [NSMutableString stringWithString:@"Green"];
    NSMutableString *blue = [NSMutableString stringWithString:@"Blue"];
    NSArray *myArray1 = [NSArray arrayWithObjects:red, green, blue, nil];
    
    // 2.进行浅复制。
    NSArray *myArray2 = [myArray1 copy];
    NSMutableArray *myMutableArray3 = [myArray1 mutableCopy];//一层深拷贝
    NSArray *myArray4 = [[NSArray alloc] initWithArray:myArray1];
    
    // 3.修改myArray2的第一个元素。
    NSMutableString *tempString = myArray2.firstObject;
    [tempString appendString:@"Color"];
    
    //    NSMutableString *tempString2 = myMutableArray3.firstObject;
    //    [tempString2 appendString:@"Color"];
    
    // 4.输出四个数组内存地址，输出四个数组。
    NSLog(@"Memory location of \n myArray1 = %p, \n myArray2 %p, \n myMutableArray3 %p, \n myArray4 %p",myArray1, myArray2, myMutableArray3, myArray4);
    NSLog(@"Contents of 浅复制容器类对象 \n myArray1 %@, \n myArray2 %@, \n myMutableArray3 %@, \n myArray4 %@",myArray1, myArray2, myMutableArray3, myArray4);
}

///容器类一层深复制
- (void)oneLevelDeepCopy{
    // 1.创建一个不可变数组，数组内元素为可变字符串。
    NSMutableString *red = [NSMutableString stringWithString:@"Red"];
    NSMutableString *green = [NSMutableString stringWithString:@"Green"];
    NSMutableString *blue = [NSMutableString stringWithString:@"Blue"];
    NSArray *myArray1 = [NSArray arrayWithObjects:red, green, blue, nil];
    
    // 2.进行浅复制。
    NSArray *myArray2 = [myArray1 copy];
    NSMutableArray *myMutableArray3 = [myArray1 mutableCopy];
    NSArray *myArray4 = [[NSArray alloc] initWithArray:myArray1 copyItems:YES];//完全拷贝
    
    // 3.修改myArray2的第一个元素。
    NSMutableString *tempString = myArray2.firstObject;
    [tempString appendString:@"Color"];
    
    // 4.输出四个数组内存地址，输出四个数组。
    NSLog(@"Memory location of \n myArray1.firstObject = %p, \n myArray2.firstObject %p, \n myMutableArray3.firstObject %p, \n myArray4.firstObject %p",myArray1.firstObject, myArray2.firstObject, myMutableArray3.firstObject, myArray4.firstObject);
    NSLog(@"Contents of 容器类一层深复制\n myArray1 %@, \n myArray2 %@, \n myMutableArray3 %@, \n myArray4 %@",myArray1, myArray2, myMutableArray3, myArray4);
}

// 5.使用归档进行完全深复制。
- (void)trueDeepCopy {
    // 1.创建一个可变数组，数组第一个元素是另一个可变数组，第二个元素是另一个不可变数组。
    NSMutableString *hue = [NSMutableString stringWithString:@"hue"];
    NSMutableString *saturation = [NSMutableString stringWithString:@"saturation"];
    NSMutableString *brightness = [NSMutableString stringWithString:@"brightness"];
    NSMutableArray *hsbArray1 = [NSMutableArray arrayWithObjects:hue, saturation, brightness, nil];
    NSArray *hsbArray2 = [NSArray arrayWithObjects:hue, saturation, brightness, nil];
    NSMutableArray *hsbArray3 = [NSMutableArray arrayWithObjects:hsbArray1, hsbArray2, nil];
    
    // 2.通过归档、解档进行完全深复制。
    NSData *dataArea = [NSKeyedArchiver archivedDataWithRootObject:hsbArray3];
    NSMutableArray *hsbArray4 = [NSKeyedUnarchiver unarchiveObjectWithData:dataArea];
    
    // 3.输出hsbArray3和hsbArray4数组第一个元素内存地址。
    NSLog(@"Memory location of htmlString\n hsbArray3.firstObject = %p, \n hsbArray4.firstObject = %p",hsbArray3.firstObject, hsbArray4.firstObject);
    
    // 4.为hsbArray4第一个元素添加字符串。
    NSMutableArray *tempArray1 = hsbArray4.firstObject;
    [tempArray1 addObject:@"hsb"];
    
    // 5.hsbArray4第二个元素是hsbArray2，而hsbArray2是不可变数组，这一步将产生错误。
    //    NSMutableArray *tempArray2 = hsbArray4[1];
    //    [tempArray2 addObject:@"Color"];
    
    // 6.输出数组内容。
    NSLog(@"Contents of \n hsbArray3 %@, \n hsbArray4 %@",hsbArray3, hsbArray4);
}

@end
