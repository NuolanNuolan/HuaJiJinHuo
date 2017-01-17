//
//  OrderAddComplainViewController.m
//  HJApp
//
//  Created by Bruce on 16/3/23.
//  Copyright © 2016年 shanghai baiwei network technology. All rights reserved.
//

#import "OrderAddComplainViewController.h"

@interface OrderAddComplainViewController ()

@property (nonatomic,retain) NSDictionary * dataDict;
@property (nonatomic,retain) NSArray * typeArray;
@property (nonatomic,assign) NSInteger selectedType;
@property (nonatomic,assign) UITextField *typeField;
@property (nonatomic,assign) UITextView *contentField;

@property (nonatomic,retain) NSMutableArray * photoArray;
@property (nonatomic,retain) NSMutableArray * photoDataArray;

@property (nonatomic,assign) UIScrollView *photoView;
@end

#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

@implementation OrderAddComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self pageLayout];
}

-(void) pageLayout{
    
    
    self.title = @"申请售后";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.selectedType = 1;
    
    self.typeArray = [NSArray arrayWithObjects:@"产品质量",@"产品数量",@"产品物流",@"商家服务", nil];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    self.photoArray = [[NSMutableArray alloc] init];
    self.photoDataArray = [[NSMutableArray alloc] init];
    
    [self loadOrderData];
    
    // tap for dismissing keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    // very important make delegate useful
    tap.delegate = self;
}

-(void) loadOrderData{
 
    [HttpEngine detailOrder:self.order_no completion:^(NSDictionary *dataDic) {
        
        self.dataDict = dataDic;
        
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSubmit.frame = CGRectMake(20, 10, VIEW_WIDTH-40, 50);
    [btnSubmit setTitle:@"提交投诉" forState:UIControlStateNormal];
    [btnSubmit setTintColor:[UIColor whiteColor]];
    [btnSubmit setBackgroundColor:[BWCommon getRGBColor:0xff0000]];
    [btnSubmit addTarget:self action:@selector(submitTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 60)];
    [view addSubview:btnSubmit];
    
    return view;
}

-(void) submitTouched : (UIButton *) sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"花集进货提醒" message:@"" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    if ([self.contentField.text isEqualToString:@""]){
        [alert setMessage:@"问题描述未填写"];
        [alert show];
        return;
    }
    
    NSMutableDictionary *dict0 = [[NSMutableDictionary alloc] init];
    [dict0 setValue:self.order_no forKey:@"order_no"];
    [dict0 setValue:self.contentField.text forKey:@"content"];
    [dict0 setValue:[NSString stringWithFormat:@"%ld",(long)self.selectedType] forKey:@"complain_type"];
    
    
    
    [dict0 setValue:[[self.photoArray mutableCopy] componentsJoinedByString:@"|"] forKey:@"images"];
    
    

    [HttpEngine addOrderComplain:dict0 complete:^(NSDictionary *dict) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提醒" message:@"投诉提交成功，请等待客服处理" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];

    } failure:^(NSString *error) {

        [alert setMessage:@"提交失败，请重试"];
        [alert show];
    }];

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 1)
    {
        return 110;
    }
    else if(indexPath.row == 2)
    {
        return 50;
    }
    else if (indexPath.row == 3)
    {
        return 130;
    }
    else if(indexPath.row == 4)
    {
        return 120;
    }
    return 40;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    if(indexPath.row == 0){
        UIView *orderNoView = [self cellInfoView:@"订单编号" content:self.order_no];
        [cell.contentView addSubview:orderNoView];
    }
    else if(indexPath.row == 1){
        NSString *amount =[NSString stringWithFormat:@"%@元", [self.dataDict objectForKey:@"order_price"] ];
        UIView *orderAmountView = [self cellInfoView:@"订单金额" content:amount];
        [cell.contentView addSubview:orderAmountView];
        
        NSString *deadline = [self.dataDict objectForKey:@"deadline"];
        UIView *deadlineView = [self cellInfoView:@"配送日期" content:deadline];
        CGRect deadlineFrame = deadlineView.frame;
        deadlineFrame.origin.y = 30;
        deadlineView.frame = deadlineFrame;
        [cell.contentView addSubview:deadlineView];
        
        NSString *toFloristId = [self.dataDict objectForKey:@"to_florist_id"];
        UIView *toFloristIdView = [self cellInfoView:@"交易对方" content:toFloristId];
        CGRect toFloristIdFrame = toFloristIdView.frame;
        toFloristIdFrame.origin.y = 60;
        toFloristIdView.frame = toFloristIdFrame;
        [cell.contentView addSubview:toFloristIdView];
    }
    else if(indexPath.row == 2){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        titleLabel.text = @"投诉类型";
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:titleLabel];
        
        UITextField *typeField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, VIEW_WIDTH-130, 30)];
        
        [typeField setText:[self.typeArray objectAtIndex:self.selectedType]];
        typeField.borderStyle = UITextBorderStyleRoundedRect;
        [typeField.layer setBorderColor:[BWCommon getRGBColor:0xcccccc].CGColor];
        [typeField.layer setCornerRadius:5.0];
        [typeField.layer setBorderWidth:1.0f];
        [typeField setFont:[UIFont systemFontOfSize:14]];

        
        typeField.delegate = self;
        self.typeField = typeField;
        
        
        [self setPickerView:typeField];
        [cell.contentView addSubview:typeField];
    }
    else if(indexPath.row == 3){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        titleLabel.text = @"问题描述";
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:titleLabel];
        
        UITextView *contentView = [[UITextView alloc] initWithFrame:CGRectMake(15, 40, VIEW_WIDTH-30, 80)];
        [contentView.layer setCornerRadius:5.0f];
        [contentView.layer setBorderWidth:1.0f];
        
        [contentView.layer setBorderColor:[BWCommon getRGBColor:0xcccccc].CGColor];
        [cell.contentView addSubview:contentView];
        
        self.contentField = contentView;
    }
    else if(indexPath.row == 4){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        titleLabel.text = @"相关凭证";
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:titleLabel];
        
        UIButton *btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUpload.frame = CGRectMake(15, 40, 60, 60);
        [btnUpload setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        
        [btnUpload addTarget:self action:@selector(uploadTouched:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnUpload];
        
        UIScrollView *photoView = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 40, VIEW_WIDTH-100, 60)];
        photoView.bounces=NO;
        photoView.showsVerticalScrollIndicator = NO;
        photoView.contentSize = CGSizeMake(VIEW_WIDTH, 60);
        photoView.scrollEnabled = YES;
        [cell.contentView addSubview:photoView];
        
        self.photoView = photoView;
    }
    
    //[BWCommon setBottomBorder:cell.contentView color:[BWCommon getRGBColor:0xeeeeee]];
    
    return cell;
}

-(UIView *) cellInfoView:(NSString *)title content:(NSString *)content{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 30)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 90, 20)];
    titleLabel.text = title;
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, VIEW_WIDTH-120, 20)];
    contentLabel.text = content;
    [contentLabel setFont:[UIFont systemFontOfSize:14]];
    [contentLabel setTextColor:[BWCommon getRGBColor:0x666666]];
    [view addSubview:contentLabel];
    return view;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void) setPickerView:(UITextField *) field{
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.tag = field.tag;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton,[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],doneButton, nil]];
    field.inputView = pickerView;
    field.inputAccessoryView = toolBar;
}
-(void) uploadTouched:(UIButton *)sender{
    
    if([self.photoArray count]>=5){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"花集进货提醒" message:@"最多只允许上传5张照片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    UIActionSheet *menu=[[UIActionSheet alloc] initWithTitle:@"上传照片" delegate:self cancelButtonTitle:@"取消上传" destructiveButtonTitle:nil otherButtonTitles:@"手机拍照",@"手机相册", nil];
    menu.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    [menu showInView:self.view];
}

-(void) doneTouched:(UIBarButtonItem *)sender{
    
    self.typeField.text = [self.typeArray objectAtIndex:self.selectedType-1];
    [self.typeField resignFirstResponder];
    
}

-(void) cancelTouched:(UIBarButtonItem *) sender{
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        //pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        //[pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //return [self.items count];
    
    return [self.typeArray count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //return [self.items objectAtIndex:row];

    return [self.typeArray objectAtIndex:row];
}


-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen{
    self.selectedType = row + 1;
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==0){
        [self snapImage];
        
    }else if(buttonIndex==1){
        [self pickImage];
    }
    
}


//拍照
- (void) snapImage{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    ipc.allowsEditing=NO;
    
    
    [self presentViewController:ipc animated:YES completion:^{
        
        
    }];
    
}
//从相册里找
- (void) pickImage{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    ipc.allowsEditing=NO;
    
    [self presentViewController:ipc animated:YES completion:^{
    }];
    
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info{
    
    UIImage *img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
   /* if(picker.sourceType==UIImagePickerControllerSourceTypeCamera){
        //UIImageWriteToSavedPhotosAlbum(img,nil,nil,nil);
    }
    
    int y = (arc4random() % 1001) + 9000;
    
    NSString *fileName = [NSString stringWithFormat:@"%d%@",y,@".jpg"];
    
    [self saveImage:img WithName:fileName];
    
    NSString *fullFileName = [[self documentFolderPath] stringByAppendingPathComponent:fileName];
    
    NSURL *fileUrl = [[NSURL alloc] initFileURLWithPath:fullFileName];
    //NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    MYLOG(@"%@",fileUrl);
    

    
    ///default/app/addshopphoto
    */
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.delegate=self;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"花集进货提醒" message:@"" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    
    
    [HttpEngine publicUploadImage:img complete:^(NSDictionary *dict) {
        
        [hud removeFromSuperview];
        
        NSString *imgurl = [dict objectForKey:@"filename"];
        
        NSURL *dataurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@@!l60",imgurl]];
        
        NSData* ndata = [NSData dataWithContentsOfURL:dataurl];
        
        [self.photoArray addObject:imgurl];
        [self.photoDataArray addObject:ndata];
        
        [self loadPhotoView];
        
        MYLOG(@"filename: %@",imgurl);
        
        //[self.photoButton setBackgroundImage:[UIImage imageWithData:ndata] forState:UIControlStateNormal];
        
        
    } failure:^(void){
        [hud removeFromSuperview];
        
        [alert setMessage:@"超时，请重试"];
        [alert show];
    }];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)loadPhotoView{
    
    for(UIView *subView in [self.photoView subviews])
    {
        [subView removeFromSuperview];
        MYLOG(@"%@",subView);
    }
    
    MYLOG(@"photoDataArray count: %ld", (unsigned long)[self.photoDataArray count]);
    
    for(int i=0;i<self.photoDataArray.count;i++){
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(65*i, 0, 60, 60);
        photoButton.tag = i;
        [photoButton addTarget:self action:@selector(photoRemoveTouched:) forControlEvents:UIControlEventTouchUpInside];
        [photoButton setBackgroundImage:[UIImage imageWithData:self.photoDataArray[i]] forState:UIControlStateNormal];
        [self.photoView addSubview:photoButton];
    }
    
}

-(void) photoRemoveTouched:(UIButton *)sender{
    
    
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"确定要删除此照片吗？" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction*defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){
                                     
        [self.photoArray removeObjectAtIndex:sender.tag];
        [self.photoDataArray removeObjectAtIndex:sender.tag];
        
        [self loadPhotoView];
    
    }];
    UIAlertAction*cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action)
                          {}];
    [alert addAction:cancel];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (NSString *)documentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(tempImage,1);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
    //[self.password resignFirstResponder];
}

@end
