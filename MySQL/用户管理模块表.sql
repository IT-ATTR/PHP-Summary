/**
 *
 * @Author: 李圣鹏
 * @Date:   2018-02-03 18:39:15
 * @Filename: 用户管理模块表.sql
 * @Last modified by:   李圣鹏
 * @Last modified time: 2018-03-10 14:51:57
 */

create table customer_login(
    customer_id int unsigned auto_increment not null comment '用户ID',
    login_name varchar(20) not null comment '用户登陆名',
    password char(32) not null comment 'md5加密密码',
    user_stats tinyint not null default 1 comment '用户状态',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_customerid(customer_id)
) engine=innodb comment '用户登陆表';

create table customer_inf(
    customer_inf_id int unsigned not null auto_increment comment '用户信息ID',
    customer_id int unsigned not null comment 'customer_login表的自增ID',
    customer_name varchar(20) not null comment '用户真实姓名',
    identity_card_no varchar(20) comment '身份证号码',
    mobile_phone int unsigned comment '手机号码',
    customer_email varchar(50) comment '邮箱',
    gender char(1) comment '性别',
    user_point int not null default 0 comment '用户积分',
    register_time timestamp not null default current_timestamp comment '注册时间',
    birthday datetime comment '会员生日',
    customer_level tinyint not null default 1 comment '会员级别：1:普通会员',
    user_money decimal(8,2) not null default 0.00 comment '用户余额',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_customerinfid(customer_inf_id)
) engine=innodb comment '用户信息表';

create table customer_level_inf(
    customer_level tinyint not null auto_increment comment '用户级别ID',
    level_name varchar(10) not null comment '会员级别名称',
    min_point int unsigned not null default 0 comment '该级别最低积分',
    max_point int unsigned not null default 0 comment '该级别最高积分',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_levelid(customer_level)
) engine=innodb comment '用户级别信息表';

create table customer_addr(
    customer_addr_id int unsigned not null auto_increment comment '主键自增id',
    customer_id int unsigned not null comment 'customer_login表自增ID',
    zip smallint not null comment '邮编',
    province smallint not null comment '地区表中省份id',
    city smallint not null comment '地区表中城市的id',
    districe smallint not null comment '地区表中的区id',
    address varchar(200) not null comment '具体地址门牌号',
    is_default tinyint not null comment '是否默认',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_sustomeraddrid(customer_addr_id)
) engine=innodb comment '用户地址表';

create table customer_point_log(
    point_id int unsigned not null auto_increment comment '积分日志ID',
    customer_id int unsigned not null comment '用户ID',
    sourec tinyint unsigned not null comment '积分来源:0订单,1登录,2活动',
    reger_number int unsigned not null default 0 comment '积分来源相关编号',
    change_point smallint not null default 0 comment '变更积分数额',
    create_time timestamp not null comment '积分日志生成时间',
    primary key pk_pointid(point_id)
) engine=innodb comment '用户积分日志表';

create table customer_balance_log(
    balance_id int unsigned not null auto_increment comment '余额日志ID',
    customer_id int unsigned not null comment '用户ID',
    source tinyint unsigned not null default 1 comment '记录来源:1订单,2退货单,3充值,4提现',
    source_sn int unsigned not null comment '相关单据ID',
    create_time timestamp not null default current_timestamp comment '记录生成时间',
    amount decimal(8,2) not null default 0.00 comment '变更金额',
    primary key pk_balanceid(balance_id)
) engine=innodb comment '用户余额变动日志表';

create table customer_login_log(
    login_id int unsigned not null comment '登录日志ID',
    customer_id int unsigned not null comment '登录用户ID',
    login_time datetime not null comment '用户登录时间',
    login_ip int unsigned not null comment '登录IP',
    login_type tinyint not null comment '登录类型：0未成功,1成功',
) engine=innodb comment '用户登录日志表';

create table brand_info(
    brand_id smallint unsigned auto_increment not null comment '品牌ID',
    brand_name varchar(50) not null comment '品牌名称',
    telephone varchar(50) not null comment '品牌电话',
    brand_web varchar(100) comment '品牌网站',
    brand_logo varchar(100) comment '品牌logo URL',
    brand_desc varchar(150) comment '品牌描述',
    brand_status tingyint not null default 0 comment '品牌状态,0禁用,1启用',
    brand_order tinyint not null default 0 comment '排序',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_brandid(brand_id)
) engine=innodb comment '品牌信息表';

create table category(
    crategory_id smallint unsigned auto_increment not null comment '分类ID',
    crategory_name varchar(10) not null comment '分类名称',
    parent_id smallint unsigned not null comment default 0,
    category_level tinyint not null default 1 comment '分类分层',
    category_status tinyint not null default 1 comment '分类状态',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_categoryid(crategory_id)
) engine=innodb comment '分类信息表';

create table supplier_info(
    supplier_id int unsigned auto_increment not null comment '供应商ID',
    supplier_code char(8) not null comment '供应商编码',
    supplier_name char(50) not null comment '供应商名称',
    supplier_type tinyint not null comment '供应商类型,1自营,2平台',
    link_man varchar(10) not null comment '供应商联系人',
    phone_number varchar(50) not null comment '联系电话',
    bank_name varchar(50) not null comment '供应商开户银行名称',
    bank_account varchar(50) not null comment '银行账号',
    address varchar(200) not null comment '供应商地址',
    supplier_status tinyint not null default 0 comment '状态,0禁用,1启用',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_supplierid(supplier_id)
) engine=innodb comment '供应商信息表';

create table product_info(
    product_id int unsigned auto_increment not null comment '商品ID',
    product_code char(16) not null comment '商品编号',
    product_name varchar(20) not null comment '商品名称',
    var_code vharchar(50) not null comment '国条码',
    brand_id int unsigned not null comment '品牌表的ID',
    category_id smallint unsigned not null comment '商品分类ID',
    supplier_id int unsigned not null comment '商品供应商id',
    price decimal(8,2) not null comment '商品销售价格',
    average_cost decimal(18,2) not null comment '商品加权平均成本',
    publish_status tinyint not null default 0 comment '上下架状态,0下架1上架',
    audit_status tinyint not null default 0 comment '审核状态:0未审核,1已经审核',
    descript text comment '商品描述',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_productid(product_id)
) engine=innodb comment '商品信息表';

-- 这里修改过
create table product_pic_info(
    res_id int unsitgned auto_increment not null comment '资源图片ID',
    product_id int unsigned not null comment '商品ID',
    is_master tinyint not null default 0 comment '是否主图,0.非主图 1主图',
    pic_order tinyint not null default 0 comment '图片排序',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间'
) engine=innodb comment '商品图片信息表';

create table order_master(
    order_id int unsitgned not null auto_increment comment '订单ID',
    order_sn bigint unsigned not null comment '订单编号',
    customer_id int unsigned not null comment '下单人ID',
    shipping_user varchar(10) not null comment '收货人姓名',
    province smallint not null comment '省',
    city smallint not null comment '市',
    district smallint not null comment '区',
    address varchar(180) not null comment '地址',
    payment_method tinyint not null comment '支付方式:1现金 2余额 3网银 4支付宝 5微信',
    order_method decimal(8,2) not null comment '订单金额',
    district_money decimal(8,2) not null default 0.00 comment '优惠金额',
    shipping_money decimal(8,2) not null default 0.00 comment '运费金额',
    payment_money decimal(8,2) not null default 0.00 comment '支付金额',
    shipping_comp_name varchar(10) comment '快递公司名称',
    shipping_sn varchar(50) comment '快递单号',
    create_time timestamp not null default current_timestamp  comment '下单时间',
    shinpping_time datetime comment '发货时间',
    pay_time datetime comment '支付时间',
    receive_time datetime comment '收货时间',
    order_status tinyint not null default 0 comment '订单状态',
    order_point int unsigned not null default 0 comment '订单积分',
    invoice_title varchar(180) comment '发票抬头',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_productid(order_id)
) engine=innodb comment '订单主表';

create table order_detail(
    order_detail_id int unsigned not null auto_increment comment '订单详情表ID',
    order_id int unsitgned not null comment '订单表ID',
    product_id int unsigned not null comment '订单商品ID',
    product_name varchar(50) not null comment '商品名称',
    product_cut int not null default 1 comment '购买的数量',
    product_price decimal(8,2) not null comment '购买商品的单价',
    average_cost decimal(8,2) not null default 0.00 comment '商品的成本价格',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_productid(order_detail_id) 
) engine=innodb comment '订单详情表';

create table order_cart(
    cart_id int unsigned not null auto_increment comment '购物车ID',
    customer_id int unsigned not null comment '用户ID',
    product_id int unsigned not null comment '商品ID',
    product_amount int not null comment '加入购物车商品数量',
    price decimal(8,2) not null comment '商品价格',
    add_time timestamp not null default current_timestamp comment '加入购物车时间',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_productid(cart_id)
) engine=innodb comment '购物车表';

create table product_comment(
    comment_id int unsigned auto_increment not null comment '评论ID',
    product_id int unsigned not null comment '商品ID',
    order_id bigint unsigned not null comment '订单ID',
    customer_id int unsigned not null comment '用户ID',
    title varchar(50) not null comment '评论标题',
    content charchar(300) not null comment '评论内容',
    audit_status tinyint not null comment '审核状态：0未审核,1已审核',
    audit_time timestamp not null comment '评论时间',
    modified_time timestamp not null default current_timestamp on update current_timestamp comment '最后修改时间',
    primary key pk_productid(comment_id)
) engine=innodb comment '商品评论表';
