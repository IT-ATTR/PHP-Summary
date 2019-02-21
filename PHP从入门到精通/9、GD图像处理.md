## GD图像处理技术
### 为什么使用GD图像处理技术
* 在WEB项目中，GD图像处理技术应用非常广泛，比如制作验证码图片，给图片打水印等。

* 什么是GD图像处理技术
* PHP通过使用GD扩展来操作图像的一种技术。

### 如何使用GD扩展
* 首先确定ext文件中，php_gd2.dll文件存在
* 然后在php.ini中开启gd扩展，extension = php_gd2.dll
* 重启apache,在phpinfo()中查看是否成功开启了扩展

### 创建画布相关操作
* imagecreate函数             创建画布
* imagecreatetruecolor函数    创建一个真彩色画布
* imagecreatefromjpeg函数     根据一张已有的jpeg图片创建画布
* imagecreatefromgif函数      根据一张已有的gif图片创建画布
* imagecreatefrompng函数      根据一张已有的png图片创建画布

### 画布相关操作函数
* imagecolorallocate函数    分配一个颜色
* imagefill函数             向画布填充颜色
* imageline函数             画线段操作
* imagerectangle函数        画矩形
* imagearc函数              画圆弧线段
* imagestring函数           根据系统字体写字
* imagettftext函数          根据ttf格式的字体写字

### 图像输出相关函数
* imagejpeg函数   以jpeg的格式输出图片到浏览器或保存成文件
* imagepng函数    以png的格式输出图片到浏览器或保存成文件
* imagegif函数    以gif的格式输出图片到浏览器或保存成文件

### 关闭画布操作
* imagedestroy函数    销毁画布资源

### 辅助图像操作函数
* imagesx函数         获得图片的宽度
* imagesy函数         获得图片的高度
* getimagesize函数    获得图片的宽度和高度等信息

### 创建有颜色的画布
```php
//创建真彩画布
$canvas = imagecreatetruecolor(500,300);
//分配颜色
$color = imagecolorallocate($canvas, mt_rand(0,255),  mt_rand(0,255),  mt_rand(0,255));
//填充颜色
imagefill($canvas,0,0,$color);
//告诉浏览器是图片
header("Content-type:image/jpg");
//输出图片
imagejpeg($canvas);
//保存图片
imagejpeg($canvas,"a.jpg");
```

#### 画矩形
```php
//创建真彩画布
$canvas = imagecreatetruecolor(500,300);
//分配颜色
$color = imagecolorallocate($canvas, mt_rand(0,255), mt_rand(0,255), mt_rand(0,255));
//填充颜色
imagefill($canvas,0,0,$color);
//获取画矩形的颜色
$color = imagecolorallocate($canvas, mt_rand(0,255), mt_rand(0,255), mt_rand(0,255));
//画矩形
imagerectangle($canvas,200,100,300,200,$color);
//告诉浏览器是图片
header("Content-type:image/jpg");
//输出图片
imagejpeg($canvas);
//保存图片
imagejpeg($canvas,"a.jpg");
//关闭画布资源
imagedestroy($canvas);
```

#### 写字
```php
//创建真彩画布
$canvas = imagecreatetruecolor(500,300);
//分配颜色
$color = imagecolorallocate($canvas, mt_rand(0,255), mt_rand(0,255), mt_rand(0,255));
//填充颜色
imagefill($canvas,0,0,$color);
//获取画矩形的颜色
$color = imagecolorallocate($canvas, mt_rand(0,255), mt_rand(0,255), mt_rand(0,255));
//画矩形
imagerectangle($canvas,200,100,300,200,$color);
//获取字体的颜色
$color = imagecolorallocate($canvas, mt_rand(0,255), mt_rand(0,255), mt_rand(0,255));
//写字
imagestring($canvas, 20, 250, 150, "你好中国", $color);
//告诉浏览器是图片
header("Content-type:image/jpg;charset=utf8");
//输出图片
imagejpeg($canvas);
//保存图片
imagejpeg($canvas,"a.jpg");
//关闭画布资源
imagedestroy($canvas);
```

#### 制作水印
**imagecopymerge(目标图像，水印图像，目标x,目标y，水印x，水印y，水印截取x,水印截取y，水印透明度)**
* 1）根据目标图片打开一个画布；
* 2）根据logo图片打开一个画布；
* 3）在目标图片上选择一个坐标基点；
* 4）在logo图片上也选择一个坐标基点（0，0坐标点）；
* 5）将logo图片拖拽到目标图片中，并且将两个坐标基点对齐；
* 6）调整* logo图片的透明度；
* 7）保存图片；
* 8）关闭目标图片和logo图片的画布；
```php
//打开目标图片
$dst = imagecreatefromjpeg("./a.jpg");
//打开水印图片
$pic = imagecreatefrompng("./b.png");
//获取水印图片的宽高
$w = imagesx($pic);
$h = imagesy($pic);
//进行合并两张图
imagecopymerge($dst, $pic, 100, 100, 0, 0, $w, $h, 30);
//进行浏览器设置
header("Content-type:image/jpeg");
//输出图片
imagejpeg($dst);
//保存图片
imagejpeg($dst,"c.jpg");
//关闭画布资源
imagedestroy($dst);
imagedestroy($pic);
```

#### 制作缩略图
**imagecopyresampled(画布，资源图片,画布x,画布y，图像x,图像y,截取画布x,截取画布y,图像x,图像y)**
* 1）根据固定的宽度和高度创建一个目标画布；（200*100）
* 2）根据一张需要缩小的图片创建一个图像画布；
* 3）在目标画布上选择一个坐标基点（0，0坐标点）；
* 4）在图像画布上也选择一个坐标基点（0，0坐标点）；
* 5）将图像画布复制到目标画布中，并且将两个基点对齐；
* 6）调整图像画布的宽度和高度 与 目标画布的宽度和高度一致；
* 7）保存图像；
* 8）关闭目标画布和图像画布；
```php
//创建画布
$canvas = imagecreatetruecolor(200, 100);
//打开资源画布
$resource = imagecreatefromjpeg("./a.jpg");
//使用缩略图函数
imagecopyresampled($canvas,$resource,0,0,0,0,200,100,imagesx($resource),imagesy($resource));
//输出图像到浏览器
header("Content-type:image/jpeg");
//输出
imagejpeg($canvas);
//保存
imagejpeg($canvas,"./b.jpg");
//销毁画布资源
imagedestroy($canvas);
imagedestroy($resource);
```
