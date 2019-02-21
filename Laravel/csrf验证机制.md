#ajax中post请求必须添加下面一段代码
headers:{'X-CSRF-TOKEN':'{{csrf_token()}}'},