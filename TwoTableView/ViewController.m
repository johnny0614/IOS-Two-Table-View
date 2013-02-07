//
//  ViewController.m
//  TwoTableView
//
//  Created by Yu Zhou on 7/02/13.
//  Copyright (c) 2013 Yu Zhou. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableView.h"
#import "SecondTableView.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray * firstItems;
@property (strong, nonatomic) NSMutableArray * secondItems;
@property (weak, nonatomic) IBOutlet FirstTableView *firstTableView;
@property (weak, nonatomic) IBOutlet SecondTableView *secondTableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if(!_firstItems) {
        _firstItems = [@[@"1",@"2",@"3",@"4"] mutableCopy];
    }
    if (!_secondItems) {
        _secondItems = [@[@"a",@"b",@"c",@"d",@"e"] mutableCopy];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isKindOfClass:[_firstTableView class]]) {
        return [self.firstItems count];
    } else {
        return [self.secondItems count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;

    if([tableView isKindOfClass:[FirstTableView class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"first table cell"];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"first table cell"];
        }
        cell.textLabel.text = [_firstItems objectAtIndex:indexPath.row];
        UISwipeGestureRecognizer * swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGestureHandler:)];
        [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [cell addGestureRecognizer:swipeGesture];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"second table cell"];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"second table cell"];
        }
        cell.textLabel.text = [_secondItems objectAtIndex:indexPath.row];
        UISwipeGestureRecognizer * swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureHandler:)];
        [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [cell addGestureRecognizer:swipeGesture];
    }
    
    return cell;
    
}

#pragma mark - gesture handler


- (void)swipeRightGestureHandler:(UISwipeGestureRecognizer *)gesture
{
    UITableViewCell * cell = [gesture view];
    NSIndexPath * index = [_firstTableView indexPathForCell:cell];
    [_secondItems addObject:_firstItems[index.row]];
    [_firstItems removeObjectAtIndex:index.row];
    [_firstTableView reloadData];
    [_secondTableView reloadData];
}

- (void)swipeLeftGestureHandler:(UISwipeGestureRecognizer *)gesture
{
    UITableViewCell * cell = [gesture view];
    NSIndexPath * index = [_secondTableView indexPathForCell:cell];
    [_firstItems addObject:_secondItems[index.row]];
    [_secondItems removeObjectAtIndex:index.row];
    [_firstTableView reloadData];
    [_secondTableView reloadData];
}




@end




























