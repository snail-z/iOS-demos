//
//  ViewController.m
//  AutoLayout-Notes
//
//  Created by zhanghao on 2017/3/18.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *aView;
@property (nonatomic, strong) UIView *sView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self example1];
    
//    [self example2];
    
//    [self example3];
    
//    [self example4];
    
//    [self example5];
    
//    [self example6];
    
    [self example7];
}


#pragma mark - 使用constraintWithItem

- (void)example1 {
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 150, 70, 70)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    
    // 约束左边
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:view1
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:20];
    
    // 约束右边
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:view1
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:-20];
    
    // 约束顶部
    NSLayoutConstraint *constraintTop = [NSLayoutConstraint constraintWithItem:view1
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:2
                                                                      constant:50];
    
    // 约束底部
    NSLayoutConstraint *constraintBottom = [NSLayoutConstraint constraintWithItem:view1
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:-50];
    
    // 添加约束
    [self.view addConstraints:@[constraintLeft, constraintRight, constraintTop, constraintBottom]];
    
    // 以上运行程序你会发现没起作用，因为要实现自动布局，必须关掉view的AutoresizeingMask
    view1.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)example2 {
    
    // 创建两个视图view1和view2
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor brownColor];
    [self.view addSubview:view1];
    // 不需要给view设置frame
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view2];
    
    // 关掉AutoresizingMask布局
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
 
    // view1：设置宽度为100px
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:100]];
    
    // view1：设置高度等于宽度
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view1
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1
                                                          constant:0]];
    
    // view1：设置在父视图水平方向上居中
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    // view1：设置在垂直方向上始终距离父视图底部为50px
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:-50]]; // 类似的Bottom、Right设置为负
    
    // view2：设置宽度是view1宽度的0.5倍
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view1
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.5
                                                           constant:0]];
    
    // view2：设置垂直方向上距父视图顶部100px
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:100]];
    
    // view2：设置垂直方向上距view1顶部50px
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view1
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:-50]];
    // 通过以上两个条件可以确定高度，所以不需要再设置高度。
    
    //view2：最后设置水平方向上距离父视图的左边间距与距离view1的间距相等
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view1
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:0.5
                                                           constant:0]];
    
}

#pragma mark - 使用VFL

- (void)example3 {
    
    // 创建视图
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor brownColor];
    [self.view addSubview:view1];
    
    // 关掉AutoresizingMask
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(view1);
    
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view1]-50-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDict];
    
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view1(==200)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDict];
    
    // 使用addConstraints添加约束
    [self.view addConstraints:constraints1];
    [self.view addConstraints:constraints2];
}

- (void)example4 {
    
    UIView *sView = [[UIView alloc] init];
    sView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:sView];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor brownColor];
    [sView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor orangeColor];
    [sView addSubview:view2]; // 将view1 view2添加到sView上
    
    // 关掉AutoresizingMask布局
    sView.translatesAutoresizingMaskIntoConstraints = NO;
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(sView, view1, view2);
    
    // 设置间距和宽度要进行替换的值
    NSDictionary *metricsDict = @{@"padding" : @50, @"height" : @150};
    
    // sView：水平方向布局
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[sView]-padding-|"
                                                                    options:kNilOptions
                                                                    metrics:metricsDict
                                                                      views:viewsDict];
    
    // sView：垂直方向布局
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[sView(height)]-padding-|"
                                                                    options:kNilOptions
                                                                    metrics:metricsDict
                                                                      views:viewsDict];
    
    // 使用addConstraints添加约束
    [self.view addConstraints:constraints1];
    [self.view addConstraints:constraints2];
    
    // view1 - view2：水平方向布局
    // 设置对齐方式，view2顶部与底部都与view1对齐
    NSLayoutFormatOptions options = NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom;
    
    NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[view1(100)]-padding-[view2]-15-|"
                                                                    options:options
                                                                    metrics:metricsDict
                                                                      views:viewsDict];
    
    // view1：垂直方向布局，根据设置的对齐方式可以确定view2高度与view1相等，所以不需要再对view2垂直布局
    NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[view1]-15-|"
                                                                    options:kNilOptions
                                                                    metrics:metricsDict
                                                                      views:viewsDict];
    
    [sView addConstraints:constraints3];
    [sView addConstraints:constraints4];
    
    // 继续创建一个视图redView
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];

    // 设置redView的左右两端对齐sView且高度等于sView的高
    NSArray *constraints5 = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"V:[redView(sView)]-15-[sView]"
                            options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                            metrics:nil
                            views:NSDictionaryOfVariableBindings(sView, redView)];
    
    [self.view addConstraints:constraints5];
}

#pragma mark - 根据文字尺寸进行约束

- (void)example5 {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor purpleColor];
    label.textColor = [UIColor whiteColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    label.numberOfLines = 0;
    label.text = @"测试测试测试测试测试测试测";
    [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    // 水平方向上：始终距离父视图右边空出20px，宽度小于200px且最大等于200px
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[label(<=200)]-20-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(label)];
    
    // 垂直约束：始终距离父视图底部空出50px
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(<=50)]-50-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(label)];
    
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
}

#pragma mark - 居中显示视图

- (void)example6 {
    UIView *aView = [[UILabel alloc] init];
    aView.backgroundColor = [UIColor redColor];
    aView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:aView];
    
    NSDictionary *viewsDict = @{@"superview":self.view, @"aView" : aView};

    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[superview]-(<=1)-[aView(50)]"
                                                                   options:NSLayoutFormatAlignAllCenterX
                                                                   metrics:nil
                                                                     views:viewsDict];
    
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[superview]-(<=1)-[aView(90)]"
                                                                   options:NSLayoutFormatAlignAllCenterY
                                                                   metrics:nil
                                                                     views:viewsDict];
    
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
}

#pragma mark - 固定宽高，等分间距

// 简单将宽高的约束进行封装
- (NSArray<NSLayoutConstraint *> *)constraintWidth:(CGFloat)width
                                            height:(CGFloat)height
                                           forView:(UIView *)view {
    
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint
                                           constraintWithItem:view
                                           attribute:NSLayoutAttributeWidth
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                           attribute:NSLayoutAttributeNotAnAttribute
                                           multiplier:1
                                           constant:width];
    
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint
                                            constraintWithItem:view
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                            constant:height];
    
    return @[constraintWidth, constraintHeight];
}

- (void)example7 {
    
    // 设置三个视图的宽高固定为100px，让三个视图在垂直方向上居中且等分所有间距？
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor redColor];
    [self.view addSubview:view3];
    
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    view3.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 设置三个视图宽高各为100px
    [self.view addConstraints:[self constraintWidth:100 height:100 forView:view1]];
    [self.view addConstraints:[self constraintWidth:100 height:100 forView:view2]];
    [self.view addConstraints:[self constraintWidth:100 height:100 forView:view3]];
    
    // 将view1垂直居中
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:view1
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:0]];

    // 将view1水平居中
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:view1
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0]];
    
    // 将view2垂直居中
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:view2
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:0]];
    
    // view2的CenterX 设置为 view.x 的一半
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:view2
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:view1
                              attribute:NSLayoutAttributeLeft
                              multiplier:0.5
                              constant:0]];
  
    // 暂不知如何对view3进行约束.....？ 若有好的解决方案，请在下面告知，不胜感激~
    
    // ....?
}

@end
