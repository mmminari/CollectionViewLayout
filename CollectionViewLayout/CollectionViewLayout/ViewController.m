//
//  ViewController.m
//  CollectionViewLayout
//
//  Created by 김민아 on 2017. 3. 28..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

#define STANDARD_DEVICE_WIDTH                                       414.0f
#define DEVICE_WIDTH                                                [UIScreen mainScreen].bounds.size.width
#define WRATIO_WIDTH(w)                                             (w/3.0f) / STANDARD_DEVICE_WIDTH * DEVICE_WIDTH
#define CELL_WIDTH                                                  (DEVICE_WIDTH - 25.0f) / 4


@interface ViewController ()

@property (strong, nonatomic) NSArray *indexList;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.indexList = @[@"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b"];
    
    [self addViewWithList:self.indexList columnCount:10 margin:6.0f];
    

}

- (void)addViewWithList:(NSArray *)array columnCount:(NSInteger)column margin:(CGFloat)margin
{
    CGFloat xValue = margin;
    CGFloat yValue = margin;
    
    CGFloat cellWidth = (DEVICE_WIDTH - (column + 1) * margin ) / column;
    
    for (int i = 0; i < self.indexList.count; i++)
    {
        CGRect viewFrame = CGRectZero;
        
        NSInteger index = i % column;
        
        if(index != column - 1)
        {
            viewFrame = CGRectMake(xValue, yValue, cellWidth, cellWidth);
            
            xValue += cellWidth + margin;
        }
        else if(index == column - 1)
        {
            viewFrame = CGRectMake(xValue, yValue, cellWidth, cellWidth);
            
            xValue = margin;
            yValue += cellWidth + margin;
        }
        
        UIView *view = [[UIView alloc]initWithFrame:viewFrame];
        
        view.backgroundColor = [UIColor blackColor];
        
        UIButton *button = [[UIButton alloc]initWithFrame:viewFrame];
        
        [button setTitle:[NSString stringWithFormat:@"%zd", i] forState:UIControlStateNormal];
        
        button.titleLabel.textColor = [UIColor whiteColor];
        
        [button addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:view];
        
        [self.view addSubview:button];

    }
    
}

- (void)didTouchButton:(UIButton *)button
{
    NSLog(@"didTouchButton : %@", button.titleLabel.text);
}




@end
