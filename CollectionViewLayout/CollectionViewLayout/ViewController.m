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
#define CELL_WIDTH                                                  ( DEVICE_WIDTH - (COLUMN_COUNT + 1) * CELL_MARGIN ) / COLUMN_COUNT

#define CELL_MARGIN                                                 5.0f
#define COLUMN_COUNT                                                6


@interface ViewController () < UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *indexList;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.indexList = @[@"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b", @"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b", @"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b",@"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b",@"b", @"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b",@"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b",@"b", @"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b",@"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b",@"b"];

    
    [self addViewWithList:self.indexList];

}

- (void)addViewWithList:(NSArray *)array
{
    // 초기 x,y좌표 위 앞 마진을 제외한 부분부터 시작
    CGFloat originX = CELL_MARGIN;
    CGFloat originY = CELL_MARGIN;
    
    CGFloat cellWidth = CELL_WIDTH;
    CGFloat cellHeight = cellWidth;
    
    CGFloat scrollViewHeight = 0.0f;
    
    CGRect viewFrame = CGRectZero;
    
    for (int i = 0; i < self.indexList.count; i++)
    {
        
        NSInteger index = i % COLUMN_COUNT;
        
        // index는 0부터 시작하기 때문에 column count로 나눴을 때
        // 나머지가 column count 보다 1작은 수가 아닐 때는
        // x좌표의 값만 증가
        // column count - 1 일 때는 y좌표의 값 증가, x좌표 값 초기화
        if(index != COLUMN_COUNT - 1)
        {
            viewFrame = CGRectMake(originX, originY, cellWidth, cellHeight);
            
            originX += cellWidth + CELL_MARGIN;

        }
        else if(index == COLUMN_COUNT - 1)
        {
            viewFrame = CGRectMake(originX, originY, cellWidth, cellHeight);
            
            originX = CELL_MARGIN;
            originY += cellWidth + CELL_MARGIN;

        }
        
        UIView *view = [[UIView alloc]initWithFrame:viewFrame];
        
        view.backgroundColor = [UIColor blackColor];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
        
        [button setTitle:[NSString stringWithFormat:@"%zd", i] forState:UIControlStateNormal];
        
        button.titleLabel.textColor = [UIColor whiteColor];
        
        [button addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        
        [self.scrollView addSubview:view];

    }
    
    // scrollViewHeight는 마지막 cell이 가지는 최대 y좌표와 아래마진을 더한 값
    scrollViewHeight = CGRectGetMaxY(viewFrame) + 5.0f;
    
    // 화면 밖을 벗어난, 총 셀의 높이만큼 scrollView의 높이 설정
    self.scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, scrollViewHeight);
    
}

- (void)didTouchButton:(UIButton *)button
{
    NSLog(@"didTouchButton : %@", button.titleLabel.text);
}




@end
