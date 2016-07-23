//
//  collecController.m
//  SV
//
//  Created by patrik on 3/5/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "collecController.h"
#import "cellmm.h"

@interface collecController (){
    
    
    NSArray *image;
}



@end

@implementation collecController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    image = [[NSArray alloc]initWithObjects:@"program0.png",@"archive button.png",@"playButton.jpg",@"refresh button.png",@"azasenovy.png", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Do any additional setup after loading the view.

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return image.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //  static NSString *CellIdentifier = @"cell";
  
    cellmm *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"forIndexPath:indexPath];
    
    [[cell myImage]setImage:[UIImage imageNamed:[image objectAtIndex:indexPath.item]]];
    
    return cell;
    
    
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
