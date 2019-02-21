## Javascript的数据类型
* JavaScript主要的核心是两链一包：作用域链，原型链，闭包
* JavaScript主要是由以下三部分组成：
* （1）DOM(文档对象模型) 如：document 对象  全称:Document Object Model
* （2）BOM(浏览器对象模型) 如：location,history,screen,navigator 全称：Broswer Object Model其中window对象是所有对象的顶级对象。在代码中顶级对象可以省略不写。
* （3）ECMAScript（ES5，ES6就是JavaScript的版本），核心部分在于两链一包,这是js精华部分。

### 数据类型种类
* 在js中包括基本数据类型和复合数据类型。
* 基本数据类型（5种）：Number、String、Boolean、null、undefined
* 复合(引用)数据类型（1种）object

```
<script type="text/javascript">
var a = 520;
var b = 13.14;
var c = 'huangjian';
var d = true;
var e = null;
var f = undefined;

console.log(typeof a); //number类型
console.log(typeof b); //number类型
console.log(typeof c); //string类型
console.log(typeof d); //boolean类型
console.log(typeof e); //object类型(重要)
console.log(typeof f); //undefined类型
</script>
```

* ①不管是整数还是小数，使用typeof查看都是number类型
* ②null的数据类型是object,代表是一个空的对象引用，一般一个变量将来是存储一个对象，可以先把此变量的值初始化为null。 var obj = null;    、
**var a; //只声明但未赋值，则值默认为undefined**

**案例：判断值的类型**
```
typeof 	null			结果？ object
typeof 	undefined		结果？ undefined
typeof 	typeof	typeof	undefined		结果？   string
null == undefined	 类似0 ==‘0’	结果？  true
null === undefined		结果?  false  ,全等不仅判断值相等，还要判断数据的类型是否相等。
```

**内存可以分为栈内存和堆内存**
* 栈（运行栈 call stack）内存：主要存储临时运行的变量或函数
* 堆内存：主要是存储数组和对象

```
//变量按值传递
var a = "tangyao";
var b = a;
b= "jiangliang";

console.log( a );//tangyao
console.log( b );//jiangliang

//对象按址传递
var obj1 = new Object();
obj1.name = 'tangyao';
var obj2 = obj1;
obj2.name = 'jiangliang';

console.log( obj1 );//jiangliang
console.log( obj1 );//jiangliang
```

**事件流**
* 事件流：页面中接收事件的顺序,即当一个事件发生时，该事件的传播过程就叫做事件流

**事件流的三个阶段**
* 事件目标阶段(处理阶段)：触发当前自身的事件。
* 事件捕获阶段：事件开始由顶层元素触发，然后逐级向下传播，直到目标的元素。
* 事件冒泡阶段：事件由具体的元素先接收，然后逐级向上传播，直到不具体的元素。

**特别注意：如果某个元素的单击事件在捕获阶段被执行，则不会在冒泡阶段执行。即在事件流的阶段中只会执行某个元素事件一次。**
```
//DOM0数据类型
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>dom事件流对象</title>
	<style type="text/css" media="screen">
		#div1{
			width: 300px;
			height: 300px;
			background-color: #ccc;
		}
		#div2{
			width: 250px;
			height: 250px;
			background-color: red;
		}
		#div3{
			width: 200px;
			height: 200px;
			background-color: orange;
		}
	</style>
</head>
<body>
	<div id='div1'>
		div1
		<div id='div2'>
			div2
			<div id='div3'>
				div3
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	var div1 = document.getElementById("div1");
	var div2 = document.getElementById("div2");
	var div3 = document.getElementById("div3");

	function showContent(){
		alert(this.innerHTML);
	}

	div1.onclick = showContent;
	div2.onclick = showContent;
	div3.onclick = showContent;
</script>
</html>
```

**件流的顺序：目标阶段----》冒泡阶段。**

**阻止默认行为**
* 在a标签和submit标签都是有默认行为的，a标签的默认行为是跳转，sumit的默认行为是提交，那么如何组织他们的默认行为呢
```
//推荐方法
<a href="javascript:;" title=""></a>
<a href="javascript:void(0);" title=""></a>


<form action="" method="get" accept-charset="utf-8" onsubmit='return false'>

</form>
```

**通过事件对象进行处理默认行为**
```
function stopdefault(e){
	var e = e || window.event;
	if(e.preventDefault){
		e.preventDefault();
	}else{
		e.returnValue = false;
	}
}
```

**函数调用（激活）的一瞬间，每个函数都会生成一个当前函数的活动对象（ActiveObject，简称AO对象，AO对象也可以理解当前函数的上下文环境）**

### 作用域的小结
* 在全局中定义一个变量或函数，变量名和函数名都将成为window对象的一个属性。
* 局部变量只在当前函数内可以访问,也就是当前的函数AO对象内可以访问，没有找到继续往上一层AO对象中寻找，直到找到window全局对象为止，如果没找到则报错。
* 在函数内，如果定义一个没有使用var声明的变量，函数执行时，此变量会污染（覆盖）全局的同名变量，这是个不建议的写法，我们应该避免。但是如果在严格模式（“use strict”;）中,这些代码将会报错！


**原生DOM的基本操作**
```
①创建节点:
	var node =  document.createElement("标签名");
	如创建li节点：var li = document.createElement("li")
②属性操作：
		设置属性：setAttribute(k,v);
		获取属性：getAttribute(k);
参数说明：
	k:属性名（可以是自定义属性）
	v:属性值
③文本操作：
		非表单元素（如：a、h1-h6、div、li、span、p..）: innerHTML
		表单元素（如：input、textarea）: value
设置和获取：
设置（赋值）：dom对象.innerHTML/value = ‘值’;
获取：var content = dom对象.innerHTML/value/innerText
④节点追加和删除和克隆
		父节点.appendChild(子节点)
	删除节点：node.parentElement.removeChild(node)
	浅克隆：node.cloneNode() //只克隆node标签
	深克隆：node.cloneNode(true) //克隆node标签及node所有子标签和内容
浅克隆和深克隆的区别：
<ul id=’ul’>
<li>11</li>
<li>12</li>
</ul>
var ul = document.getElementById(‘ul’);
浅克隆： var new_ul = ul.cloneNode(); // <ul id=ul></ul>
深克隆： var new_ul = ul.cloneNode(true); // <ul id=ul><li>11</li><li>12</li></ul>
⑤节点查找
	父节点.firstElementChild; // 获取第一个子节点
	父节点.lastElementChild; // 获取最后一个子节点
	父节点.children; // 获取所有的子节点
	节点.nextElementSibling ; //找当前节点对象的下一个兄弟节点
	节点.previousElementSibling ; //找当前节点对象的上一个兄弟节点
	获取一个节点： document.querySelector(“#id”) ;   // 返回一个对象
	获取一类节点： document.querySelectorAll(“.类名/标签名/其他选择器(层级)”)  // 返回对象集合
⑥创建option元素特殊用法
除了使用document.createElement()的方法创建option标签，还可以使用以下特有的方式来创建。
var op = new Option(‘栏目一’，5)；
上面代码相当于创建了这样一个option标签，如： <option value=’5’>栏目一</option>

把创建好的option标签除了可以使用appendChild方法追加到select标签内部中，还可以使用以下方法来实现。
var sel = docuement.createElement(‘select’);
sel.options.add(op);
```

**JavaScript调试技术**
#### 1、输出调试
* document.write();  //向浏览器界面输出信息
* alert();
* console.log(); //一般用于打印变量、字符串、对象
* console.dir(); //重点掌握

#### 2、try-catch-finally调试
```
try{
		//可能存在错误的代码块
	}catch(err){
		console.log(err.name);
		console.log(err.message);
	}finally{
		//表示一定会执行，但是使用不多
	}
```

#### 3、断点调试（多用于循环）


## 变量声明提升和函数声明提升
```
JavaScript的运行阶段分为编译阶段（分为词法分析、语法分析）和执行阶段。

编译阶段的工作
把在全局或局部定义的变量和函数声明都会被“移动”到各自作用域的最顶端，这个过程称之为提升。
函数声明（非函数表达式）被提升
var变量声明被提升

注意：函数声明提升的优先级高于变量声明提升。

执行阶段的工作
主要进行变量的赋值(=符号)
```

## 自调用匿名函数
```
格式一：
(function(形参){})(实参);

格式二：
(function(形参){}(实参));
```

**使用自调用匿名函数的原因**
```
(function(window,undefined){

		window.变量名 = 变量值;

	})(window)
```
* 通过定义一个匿名函数，等同于创建了一个“私有”的命名空间，该命名空间的中的变量和方法只在当前函数内可以被使用，不会破坏（污染）全局的命名空间中的同名变量和方法名。

**传入参数window的原因**
>通过传入window变量，使得window由全局变量变为局部变量，则函数内部读取window变量就不需要去全局作用域中寻找，这样可以更快的访问到window；因为访问局部变量的速度是快于全局的。

**传入undefined的原因**
>因为在Javascript中undefined并不是作为关键字，因此可以对其进行赋值更改。注意只有低版本ie浏览器才可以对undefined进行更改，主流浏览器（如：google,firefox）是改不了的.所以为了解决上面的问题，可以使用undefined作为第二个形参,调用时对应的实参不传即可，这样可以保留默认的undefined的值，从而避免了函数外部对undefined的更改也不会影响到函数内对undefined的操作。

## 闭包
* 闭包是指有权访问另一个函数作用域中的变量的函数。
```
function A(){
	var a = 10;
	function B(){
		console.log(a);
	}
	return B;
}
var result = A();

console.log( result );
```

>由于函数A内部的局部变量a不能被A以外的函数访问到，只能被A内部的子函数B访问到，这是由于JavaScript的‘链式作用域’结构导致的，既然只有内部函数B才可以访问到函数A中的局部变量，那么我们只需要把函数B作为函数A的返回值，不就可以在函数A外部访问它的内部变量了吗！ 其中函数B就是闭包。

* 由于在Javascript语言中，只有函数内部的子函数才能读取局部变量，因此可以把闭包简单理解成"定义在一个函数内部的函数"。所以，在一个函数内部创建子函数，最后返回子函数，这是创建闭包最常见的方式。

**闭包的作用**
* 可以让我们在全局作用域中访问局部变量（上面的代码就是）。
* 保持对函数内部的变量持续引用，让一个变量始终保存在内存中。

### 面向对象
**创建对象**
* 1、使用系统基（父）类Object来创建对象，或json格式创建对象
* 2、使用工厂方式来创建对象
* 3、使用构造函数创建对象
* 4、【重点掌握】使用构造函数+原型对象组合来创建对象

```
//通过类Object来创建对象

var obj = new Object();
obj.name = 'jiangliang';
obj.age  = 24;
obj.getname = function(){
	alert(this.name)
}

console.log( obj.name );
console.log( obj.age );

//通过JSON格式创建对象
var obj = {
	"name":"jiangliang",
	"age":"24",
	"getname":function(){
		return this.name+this.age
	}
}

console.log( obj instanceof == Object);//true
```

**因为上面对象有很多属性的话就会很麻烦，可以使用工厂方式创建对象**
```
function createObj(name,age){
	var obj = new Object();
	obj.name = name;
	obj.age  = age;
	obj.getname = function(){
		alert(this.name)
	}

	return obj;
}
var obj1 = createObj('jiangliang',24);
var obj2 = createObj('huangjian',23);

console.log( obj1.name );
console.log( obj2.name );
```

**使用工厂模式虽然解决了设置多个属性的问题，但是因为工厂内部域的问题，使得不能使用instanceof对象是由哪一个实例化而来的**

**使用构造函数创建对象**
```
function Person(name,age){
	this.name = name;
	var age = age;

	this.getName = function(){
		alert(this.name);
	}

	this.getAge = function(){
		alert(age);
	}
}

var obj = new Person("zs",33);
obj.getAge();
```

**参数解释**
* 1、格式：function 类名(){},建议类名首字母大写，此构造函数类似于php中的构造函数
* 2、通过this定义公有属性，var定义私有属性
* 3、获取公有属性通过this.属性名
* 4、获取私有属性，直接通过属性名去获取
* 5、实例化对象时，会将this定义的公有属性存储到自身空间中

>使用构造函数创建对象的缺点
>通过构造函数创建对象，但是有个问题，每个对象都是在自身的内存空间中单独存储一个公有的属性和方法，我们应该让这些公有的方法让每个对象共享，没必要在每个对象自身内存空间中单独存储一份，这样会极大的浪费内存空间，我们希望是把这些公共的方法或公有的属性抽离出来，用于每个对象共享。

**利用原型对象（父类）来存储对象公有的属性或方法，从而达到共享。**
* 使用构造函数+原型对象创建对象的核心思想：
* 把对象独有的属性定义在构造函数上面
* 把公有的属性和方法定义在原型对象（父类）上面

* 构造函数和原型对象的关系，记住三个定理：

> * 构造函数天生会有一个prototype属性，其值指向构造函数的原型对象。

> * 每个原型对象天生会有一个constructor的属性，其值指向构造函数本身。

> * 通过构造函数new出来的对象，天生都会有一个__proto__（在有些浏览器看不到）属性，其值指向构造函数的原型对象。


```
function Person(name,age){
	this.name = name;
	this.age  = age;
}

Person.prototype.getName = function(){
	return this.name;
}

Person.prototype.email = "qq.com";

var p1 = new Person("zs",22);
var p2 = new Person("ls",24);

//说明共享其原型对象属性
console.log(p1.getName === p2.getName); //true
```

## 原型对象的相关检测
* isPrototypeOf()：检测对象是否是某个对象的原型对象。

* constructor ：检测对象的构造函数（构造器）,指对象通过哪个构造函数创建(new)出来的。

* in：检测一个对象空间或原型对象空间是否存在某个属性

* hasOwnProperty()：判断当前对象空间中是否存在一个属性（注：不会去原型上找）

* delete：删除自身对象空间中的属性，不会删除原型上的。

## 原型对象的重写，重写也就是覆盖
* 下面不是重写，只是给原型对象添加了一个属性
```
function Person(name,age){
	this.name = name;
	this.age  = age;
}

Person.prototype.getName = function(){
	return this.name;
}
```

* 下面才是重写
```
Person.prototype = {
	"属性名"："属性值"
}
```

**原型对象被重写之后的小结：**
 * 1、原型对象被重写之后构造函数的prototype属性值应该指向重写之后的原型对象
 * 2、原型对象重写之后所创建（new 操作）的对象，其对象的__proto__属性值指向重写之后的原型对象
 * 3、原型对象重写之后不存在constructor属性，但是我们可以手动给其添加一个constructor属性，值设为构造函数本身，这样可以保持原型链的完整。
 ```
 Person.prototype = {
	"constructor":Person
}
 ```

## 静态属性和静态方法
* 设置静态属性：函数名.静态属性 = “值/函数”
* 读取静态属性：函数名.静态属性
```
function Person(name){
	this.name = name;
}

Person.getAge = function(){
	alert('24岁');
}

Person.getAge();
```

## 对象的继承
* 通过for..in实现继承
* 通过call和apply实现伪造继承
* 通过原型对象实现继承
* 通过伪造（call或apply）组合原型对象实现继承

**for..in的作用**
* 循环数组中的元素
```
var arr = ['a','b','c','d','e'];
for(key in arr){
	document.write(key);
	document.write(arr[key]);
}
```

* 循环对象的属性以及原型对象上面的属性
```
function Person(name,age){
	this.name = name;
	this.age  = age;
}

Person.prototype.getName = function(){
	return this.name;
}

Person.prototype.getAge = function(){
	return this.age;
}

var obj = new Person('jiangliang',24);
for(attr in obj){
	document.write(attr);
	document.write(obj[attr]);
}
```

**由于for..in不仅会循环出对象以及原型对象中的属性，怎么只把当前对象自身空间中已有的属性循环出来？**
* 用hasOwnProperty方法进行判断即可
```
for(attr in obj){
	if( obj.hasOwnPropeerty(attr) ){
		document.write(attr);
		document.write(obj[attr]);
	}
}
```

## 使用for...in完成继承
* 使用for..in继承的核心思想：
* 在子类的构造函数中，创建父类的一个对象，使用for..in循环父类对象属性。
* 注：只把父类对象和父类原型对象在子类对象中不存在的属性才继承过来。

```
//创建父类对象
function Parent(){
	this.email = "qq.com";
}

Parent.prototype.getEmail = function(){
	return this.email;
}


//创建子类对象
function Child(name,age,email){
	var parent = new Parent(email);
	//循环父类中存在的属性
	for(attr in parent){
		//将与子类属性不同的属性才添加进自身的空间
		if( !(attr in this) ){
			this[attr] = parent[attr];
		}
	}
	this.name = name;
	this.age  = age;
}

Child.prototype.getName = function(){
	return this.name;
}

Child.prototype.getAge = function(){
	return this.age;
}
```

## 通过call或者apply方法实现伪造继承
* call和apply的作用：主要是改变函数内this的指向
```
使用语法：函数名调用，如下所示：
functionName.call(obj,参数1，参数2...)
functionName.apply(obj, [ 参数1，参数2..... ] )

// 即函数内this都是obj伪造出来的
```

**call和apply的区别：**
* 相同点：都是改变函数内this的指向。
* 不同点：参数传递的形式不一样。

>* call参数是一个一个传，需要传递几个参数就需要看函数需要几个形参。

>* apply是传递一个参数数组，如果apply是使用在某个函数内则参数数组使用arguments代替即可，这样避免一个个传。

```
var obj1 = {
	"name":"老王",
	"girlfriend":"凤姐",
}

var obj2 = {
	"name" :"老彭",
	"getgf":function(email){
		console.log(this);
		retun this.name+this.girlfriend+this.email;
	}
}

console.log( obj2.getgf.call(obj1,'qq.com') );
console.log( obj2.getgf.apply(obj1,'qq.com') );
```

## 扩展 bind方法
* 通过之前的代码可以发现，call和apply都是改变函数内this的指向，其实立即调用函数，如果不想立即执行，我们可以使用bind方法来解决。
```
bind的用法（和call用法一样）：
使用格式:functionName.bind(obj，参数1,参数2.........)

 var getgf = obj2.getgf.bind(obj1,'qq.com');
 console.log( getgf() );
```

**小结**
>* call和apply和bind方法都是改变函数内this的指向。

>* 调用call和apply函数则立即执行函数，而bind只是返回整个函数，并没有执行，后面需加小括号()才执行。


## toString()和valueof()方法
* toString()方法：作用：①返回对象的字符串表示 ②也可以对一个数值进行进制的转换。
```
判断一个变量是数组还是对象？
var arr = [12,34]; //数组
var obj = {}; // 对象

可以通过系统超类的原型对象调用toString方法来实现，如：

Object.prototype.toString.call(arr);
Object.prototype.toString.call(obj);
```

* valueOf

>* valueOf()方法：作用：返回指定对象的原始值。

**两者的区别**
* 共同点：在 JavaScript 中，toString()方法和valueOf()方法在操作变量时候会自动被调用。
* 不同点：二者并存的情况下，对变量进行数值运算时（如：+），优先调用valueOf，字符串运算中（如：alert），优先调用toString。

>* 返回值类型的差别：
             *  1. toString一定将所有内容转为字符串类型
             *  2. valueOf取出对象内部的值，不进行类型转换
>* 用途的差别：
             *  1. valueOf专用于算数计算(如：+)，会自动触发
             *  2. toString专用于输出字符（如：alert），会自动触发，且可以做数值的进制转换。

**注：如果没有给对象添加toString和valueOf方法，则会触发系统Object.prototype中的默认的两个函数。**

## 找到方法toString和valueOf回家的路线(完整原型链)
* （1）Object.prototype对象的认识
**当一个对象调用一个方法时，若找不到此方法则会去对应系统类或自定义类的原型对象中去找，若还找不到则去Object的原型对象即Object.prototype中空间去找！！**
```
console.dir( Object.prototype );

constructor:ƒ Object()
hasOwnProperty:ƒ hasOwnProperty()
isPrototypeOf:ƒ isPrototypeOf()
propertyIsEnumerable:ƒ propertyIsEnumerable()
toLocaleString:ƒ toLocaleString()
toString:ƒ toString()
valueOf:ƒ valueOf()
__defineGetter__:ƒ __defineGetter__()
__defineSetter__:ƒ __defineSetter__()
__lookupGetter__:ƒ __lookupGetter__()
__lookupSetter__:ƒ __lookupSetter__()
get __proto__:ƒ __proto__()
set __proto__:ƒ __proto__()
```

**给Object.prototype原型对象设置一个方法是不是可以被javaScript任何对象调用（共享）？of course**
```
Object.prototype.sayHi = function(){
	alert("你好呀!");
}
console.dir( Object.prototype );
var box = document.getElementsByTagName("body")[0];
box.sayHi();
```

## toString和valueOf回家的路线(终极完整原型链)
* 1、系统超类Object的原型对象的__proto__ 等于 null ，即 Object.prototype.__proto__ == null ,此时已经到了原型链的终点。
* 2、函数名去调用一个方法，如函数名.call/apply/bind,会去到函数的原型对象中去找，即去Function.protptype中去寻找。
* 3、系统任何变量或对象的__proto__属性，其值都是指向相应类的原型对象（或自定义类原型对象），如下所示：
**如字符串类型：**
* var str1 = 'abc'; 			 // str1.__proto__ === String.prototype ，值为 true
* var str2 = new String('def');  // str2.__proto__ === String.prototype ，值为 true
**如数组类型：**
* var arr1 = ['a','b']; 			// arr1.__proto__ === Array.prototype ，值为 true
* var arr2 = new Array('a','b'); 	// arr2.__proto__ === Array.prototype ，值为 true
**如json对象（Object类对象的语法糖形式）或new Object对象类型：**
* var obj1 = {}; 		// obj1 .__proto__ === Object.prototype ，值为 true
* var obj2 = new Object; 	// obj2 .__proto__ === Object.prototype ，值为 true
**如函数类型**
* var fnName1= function(){}; 	// fnName1.__proto__ === Function.prototype ，值为 true
* function fnName2(){}; 		// fnName2.__proto__ === Function.prototype ，值为 true
```
var arr  =  ['a','b','c'];

function Person(){}

Person.prototype.hello=function(){
	alert("my love");
}

Object.prototype.must=function(){
	alert("让你身不由己");
}

console.log( Object.prototype.toString.call(Person) );
console.log( Object.prototype.toString.call( arr ) );
console.log( Person instanceof Object );
console.log( Person.prototype.__proto__ ==  Object.prototype );
console.log( Array.prototype.__proto__ ==  Object.prototype );
console.log( String.prototype.__proto__ ==  Object.prototype );
console.log( Function.prototype.__proto__ ==  Object.prototype );

var body = document.getElementsByTagName("must");
body.must();
```


