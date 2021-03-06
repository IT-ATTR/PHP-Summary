/* *
 * 功能：常用正则表达式
 * 版本：1.0
 * 作者：江亮（Eden）
 * 修改日期：2019-02-20
 * 说明：

 *************************页面功能说明*************************
 * 常用正则表达式总结
 */

// 匹配中文字符 javascript写法
var regular = /^[\\u4e00-\\u9fa5]+$/;

// 由数字、26个英文字母或者下划线组成的字符串
var regular = /^\\w+$/;

// 验证邮箱（邮箱域名后缀必须满足2-6位数，并且只能是大小写英文字母）
var regular = /^\w+([+-.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,6}$/;

// 验证手机号码 规定手机号码开头必须满足（比较严格）
var regular = /^(?:13|14|15|17|18|19)[0-9]{9}$/;
// 验证手机号码 规定手机号开头必须满足为1（比较宽松）
var regular = /^1\d{10}/;
// 获取手机号码中间4位并隐藏 str/替换的手机号码字符串
var regular = /^(13|14|15|17|18|19)([0-9])(?:\d{4})([0-9]{4})$/;
var html = str.replace(reg,"$1$2****$3");

// 固话验证 比较宽松
var regular = /^[0-9-()（）]{7,18}$/;
var regular = /^(\(*[0-9]{3,4}-)*[0-9]{7,8}$/;

// 验证中国国内标准身份证规则(比较宽松，网上的15位数的身份证验证规则已经过期)
var regular = /^[1-9]\d{16}[\dxX]$/;
// 验证中国国内标准身份证规则(比较严格，开头必须对应相应的省份)
var regular = /^(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-5]|6[1-5]|71|8[1-2])\d{15}[\dxX]$/;

// 验证腾讯QQ号码（最少5位 最多12位）
var regular = /^[1-9](\d{4,})$/;

/*
 * 密码强度匹配
 * 密码强度匹配需要多次匹配，单次匹配无法完全匹配所有情况
 * 特殊符号可能存在不完善
 */
// 一级强度：纯数字 纯字母 纯符号组合  至少6位数
var regular = /^(?:\d+|[a-zA-Z]+|[!@#$%^&*.]+){6,}$/;
// 二级强度：字母+数字，字母+特殊字符，数字+特殊字符
var regular = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*.]+$)[a-zA-Z\d!@#$%^&*.]+$/;
// 三级强度：数字+字母+特殊字符
var regular = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*.]+$)(?![a-zA-z\d]+$)(?![a-zA-z!@#$%^&*.]+$)(?![\d!@#$%^&*.]+$)[a-zA-Z\d!@#$%^&*.]+$/;
