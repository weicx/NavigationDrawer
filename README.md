### NavigationDrawer
####实现抽屉导航、搜索视图的切换动画等
============================
####抽屉导航基本思路
* 1. 导航控制器视图添加Pan手势和Tap手势
* 2. 分别确定左右两条分界线并记录上一次抽屉的状态（开启/关闭）
* 3. 导航控制器视图跟随拖拽手势而移动
* 4. 当手势结束或取消时
  * 如果视图的坐标在左分界线左侧，则弹回原位置，关闭抽屉；
  * 如果视图的坐标在右分界线右侧，则移动至抽屉完全打开的位置，打开抽屉；
  * 如果视图的坐标在左、右分界线之间，则
    * 若上一次抽屉的状态为关闭，则移动至抽屉完全打开的位置，打开抽屉；
    * 若上一次抽屉的状态为开启，则移动至抽屉完全关闭的位置，关闭抽屉。
    
####导航及动画关键点
* 跟随Pan手势进行平移动画时，需要及时清空手势
```
    self.view.transform = CGAffineTransformTranslate(self.view.transform, transform.x, 0);
    [pan setTranslation:CGPointZero inView:pan.view];
```
* 当手势停止的时候对此时视图位置的判断要准确
```
    // 手势结束或被打断
    if (pan.state == UIGestureRecognizerStateEnded || pan.state ==UIGestureRecognizerStateCancelled) {
        if (self.view.x < LEFT_DEVIDE_DISTANCE) {// 不到左分界线弹回原位置
            [self closeMenuView];
        } else if (self.view.x > RIGHT_DEVIDE_DISTANCE) {// 越过右分界线移动到抽屉展开的位置
            [self openMenuView];
        } else {// 处于左、右分界线之间
            if (self.isopen) {
                [self closeMenuView];
            } else {
                [self openMenuView];
            }
        }
    }
```
* 移除搜索视图时的缩放、遮盖透明度动画
  * 缩放比例以及透明度系数根据搜索视图划过的程度来计算
  * 在抽屉打开或关闭后设置如下代码，将视图transform重置，才能保证搜索视图切换动画正常！
```
      self.view.transform = CGAffineTransformIdentity;
```

###详情请参照项目中具体注释！
  
