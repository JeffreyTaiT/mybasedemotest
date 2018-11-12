//
//  ViewController.m
//  PickerView
//
//  Created by  zengchunjun on 2017/4/20.
//  Copyright © 2017年  zengchunjun. All rights reserved.
//

#import "ViewController.h"
#import "SexPickerTool.h"

#import "DatePickerTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    SexPickerTool *sexPick = [[SexPickerTool alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 200)];
    __block SexPickerTool *blockPicker = sexPick;
    sexPick.callBlock = ^(NSString *pickDate) {
        NSLog(@"%@",pickDate);
        
        if (pickDate) {
            
        }
        
        [blockPicker removeFromSuperview];
    };
    [self.view addSubview:sexPick];
    
    
    
    DatePickerTool *datePicker = [[DatePickerTool alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 200)];
    __block DatePickerTool *blockPick = datePicker;
    datePicker.callBlock = ^(NSString *pickDate) {
        
        NSLog(@"%@",pickDate);
        
        if (pickDate) {
            
        }
        
        [blockPick removeFromSuperview];
    };
    
    [self.view addSubview:datePicker];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
