//
//  LeftTableView.m
//  AnimationText
//
//  Created by 李阳 on 16/4/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "LeftTableView.h"

#import "LeftCell.h"

@implementation LeftTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
//        [self registerNib:[UINib nibWithNibName:@"LeftCell" bundle:[NSBundle bundleForClass:[LeftCell class]]] forCellReuseIdentifier:@"Cell"];
        self.rowHeight = 50.0;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

#pragma mark - iOS8 cell滑动操作
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"喜欢" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 实现相关的逻辑代码
        // ...
        // 在最后希望cell可以自动回到默认状态，所以需要退出编辑模式
        tableView.editing = NO;
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 首先改变model
        [self.dataArr removeObjectAtIndex:indexPath.row];
        // 接着刷新view
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        // 不需要主动退出编辑模式，上面更新view的操作完成后就会自动退出编辑模式
    }];
    
    return @[deleteAction, likeAction];
}

#pragma mark - iOS7 cell滑动操作
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        /*此处处理自己的代码，如删除数据*/
        [self.dataArr removeObjectAtIndex:indexPath.row];
        /*删除tableView中的一行*/
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark --datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    NSString *imgname = [_dataArr[indexPath.row] objectForKey:@"imgname"];
    cell.imageView.image = [UIImage imageNamed:imgname];
    NSString *title = [_dataArr[indexPath.row] objectForKey:@"title"];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"测试测试测试测试";
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark --delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_leftRowSelect) {
        _leftRowSelect(indexPath);
    }
}

@end
