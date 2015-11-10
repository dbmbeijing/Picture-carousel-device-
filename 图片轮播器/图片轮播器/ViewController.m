//
//  ViewController.m
//  图片轮播器
//
//  Created by User on 15/11/10.
//  Copyright © 2015年 User. All rights reserved.
//

#import "ViewController.h"
#define JZCount 5
@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib./
    //    1.添加图片
    for (int i = 0; i < JZCount; i++) {
        //        1.1创建图片对象
        UIImageView *iconView = [[UIImageView alloc]init];
        //        1.2设置frame
        CGFloat iconViewW = self.scrollView.frame.size.width;
        CGFloat iconViewH = self.scrollView.frame.size.height;
        
        CGFloat iconViewX = i *iconViewW;
        CGFloat iconViewY = 0;
        iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
        //       1.3添加
        //        [self.scrollView addSubview:iconView];
        [self .scrollView insertSubview:iconView atIndex:0];
        //       1.4设置图片数据
        NSString *iconName = [NSString stringWithFormat:@"img_%02d",i +1];
        iconView.image = [UIImage imageNamed:iconName];
        
        
        
        
    }
    //    2.设置滚动范围
    self.scrollView.contentSize = CGSizeMake(JZCount* self.scrollView.frame.size.width, 0);
    //    3.设置分页
    self.scrollView.pagingEnabled = YES;
    
    //    4.设置总页数
    self.pageControl.numberOfPages = JZCount;
    //    5.设置当前页
    //    self.pageControl.currentPage = 0;
    //    6.设置代理
    self.scrollView.delegate = self;
    
    //    7.添加定时器
    //    NSTimer :定时器,可以每隔一段时间执行方法,并且可以设定执行方法的时间,
    
    //
    //    CADisplayLink :刷帧,这个每个一秒钟会调用多次,一般和动画配合使用
    //    scheduledTimerWithTimeInterval:表示每个多长时间执行方法
    //    selector:表示要做的事情
    //    target:表示谁来做事情,(即谁来调用这个方法)
    //    repeats:表示是否重复
    
    
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    //    self.timer = timer;
    [self addTimer];
    
    //    8.提高定时器的优先级(修改消息循环添加定时器的添加模式)
    [[NSRunLoop currentRunLoop ]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}


- (void)next{
    //    1.确定页码
    //    if (self.pageControl.currentPage == 4) {
    //        self.pageControl.currentPage = 0;
    //    }else{
    //
    //        self.pageControl.currentPage++;
    //    }
    //
    NSInteger page = self.pageControl.currentPage;
    if (page == JZCount - 1) {
        page = 0;
    }else{
        
        page ++;
    }
    
    
    //    2.根据页码确定滚动的偏移量
    CGFloat scrollViewW = self.scrollView.frame.size.width;
    
    //
    //    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * scrollViewW, 0);
    [ self.scrollView setContentOffset:CGPointMake(page * scrollViewW,0)animated:YES];
    
    
    
    
    
}
/**
 *  监听滚动
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%f",scrollView.contentOffset.x);
    //    1.根据滚动的偏移量确定当前页
    CGFloat scrollViewW = scrollView.frame.size.width;
    
    CGFloat offsetX= scrollView.contentOffset.x;
    int page = ( offsetX + 0.5 *scrollViewW) /scrollViewW;
    //    2.设置当前页
    
    
    self.pageControl.currentPage = page;
    
    
}

/**
 *  监听开始拖拽
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //   1.停止定时器,定时一旦停止,不能在开启,想要重用定时器,必须重新开一个定时器
    [self.timer invalidate];
    self.timer = nil;
    
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    
}

- (void)addTimer{
    
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    self.timer = timer;
    
}



@end
