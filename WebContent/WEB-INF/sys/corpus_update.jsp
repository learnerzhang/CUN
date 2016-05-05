<%@page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>语料修改-藏语情感资源</title>
<link rel="stylesheet" type="text/css" href="css/css.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<script type="text/javascript" src="js/jquery.json-2.4.js"></script>
<style type="">
.mytable td{
	font-size:18px;
	padding: 6px;
}

.mytable td input{
	height: 20px;
	width: 20px;
}
.mytype{
	font-weight:bold;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#save").click(function(){
			
			$("#feature").css("border","1px solid #dcdbdb");
			
			var input = document.getElementsByTagName("input");
			var tendency = "";
			var flag = true;
			var count = 0;
			for (var int = 0; int < input.length; int++) {
				if(input[int].type == "checkbox" && input[int].name == "tendency")
                {
	                  if (input[int].checked)
	                  {
		                    //这个地方是获取你选定了的的checkbox的Value
		                    //alert(input[int].value);
		                    if (input[int].value=="o") {
		                    	 flag = false;
							}
		                     tendency+=input[int].value+";";
		                     count++;
	                  }
                }
			}
			if (tendency=="") {
				return;
			}
			var feature = $("#feature").val();
			
			var paratmeter;
			if (flag==false) {
				if (count>1) {
					return;
				}
				paratmeter = {
						"id":"${corpus.id }",
						"tendency":tendency,
						"username":"${user.username}"
				};
				
			}else {
				if (feature=='使用英文 ; 分割'||feature.trim()=='') {
					$("#feature").css("border","1px solid red").focus();
					return;
				}
				var type = $("input[name='type']:checked").val();
				if (typeof(type)=="undefined") {
					return;
				}
				
				var negative = $("#negative").val();
				var degree = $("#degree").val();
				
				if (negative=='使用英文 ; 分割') {
					negative="";
				}
				if (degree=='使用英文 ; 分割') {
					degree="";
				}
				paratmeter = {
						"id":"${corpus.id }",
						"tendency":tendency,
						"feature":feature,
						"negative":negative,
						"degree":degree,
						"type":type,
						"username":"${user.username}"
				};
			}
			
			
			/* var type = $(this).attr('id');
			var paratmeter = {
					"id":"${corpus.id }",
					"type":type,
					"username":"${user.username}"
			}; */
			//alert(JSON.stringify(paratmeter));
			$.ajax({
				contentType:"application/json;charset=utf-8",
				url : "MarkTendencyServlet?type=update",
				type : "post",
				data : JSON.stringify(paratmeter),
				dataType : "json",
				success : function(data) {
					if (data.hasOwnProperty("code")) {
						if (data.code == "0") {
							window.location.href="<%=request.getContextPath()%>/MarkTendencyServlet?type=load";//登录成功.跳转首页...
						} else if (data.code == "1") {//原密码错误
							alert("网络异常...稍后再试");
						} 
					}
				},
				error:function(){
					
                }
			});	
		});
	});
</script>
</head>
<body>
	<div id="pageAll">
		<div class="pageTop">
			<div class="page">
				<img src="img/coin02.png" /><span><a href="#">首页</a>&nbsp;-&nbsp;<a
					href="#">工作详情</a>&nbsp;-</span>&nbsp;修改标记信息
			</div>
		</div>
		<div class="page ">
			<!-- 修改密码页面样式 -->
			<div class="bacen" style="width: 96%">
				<p style="font-size:18px;">藏语句子#&nbsp;<font style="color:red; font-size:30px; font-weight:bold;">${corpus.context }</font></p>
				<p style="font-size:18px;margin-top: 13px;">词性标志#&nbsp;<font style="color:red; font-size:30px; font-weight:bold;">${corpus.tagging }</font></p>	
				<p></p>
				<div style="float: left;width: 580px;">
					<table style="margin-top:20px" class="mytable">
						<tr style="height: 60px;">
							<td>情感类别#</td>
							<td>
								<table style="height: 50px;border: 0;" border="0" cellpadding="0" cellspacing="0">
									<tr >
										<td>
											<table>
												<tr>
													<td class="mytype">乐:</td>
													<td><input type="checkbox" name="tendency" value="h" />快乐</td>
													<td><input type="checkbox" name="tendency" value="e" />安心</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>
											<table>
												<tr>
													<td class="mytype">好:</td>
													<td><input type="checkbox" name="tendency" value="p" />赞扬</td>
													<td><input type="checkbox" name="tendency" value="r" />相信</td>
													<td><input type="checkbox" name="tendency" value="b" />尊重</td>
													<td><input type="checkbox" name="tendency" value="l" />喜爱</td>
													<td><input type="checkbox" name="tendency" value="k" />感动</td>
													<td><input type="checkbox" name="tendency" value="c" />期望</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>
											<table>
												<tr>
													<td class="mytype">怒:</td>
													<td><input type="checkbox" name="tendency" value="i" />愤怒</td>
													<td><input type="checkbox" name="tendency" value="s" />悲伤</td>
													<td><input type="checkbox" name="tendency" value="w" />失望</td>
													<td><input type="checkbox" name="tendency" value="g" />&nbsp;&nbsp;&nbsp;疚</td>
												</tr>
											</table>
										</td>
									</tr>
									
									<tr>
										<td>
											<table>
												<tr>
													<td class="mytype">哀:</td>
													<td><input type="checkbox" name="tendency" value="s" />悲伤</td>
													<td><input type="checkbox" name="tendency" value="w" />失望</td>
													<td><input type="checkbox" name="tendency" value="g" />&nbsp;&nbsp;&nbsp;疚</td>
													<td><input type="checkbox" name="tendency" value="m" />&nbsp;&nbsp;&nbsp;思</td>
												</tr>
											</table>
										</td>
									</tr>
									
									<tr>
										<td>
											<table>
												<tr>
													<td class="mytype">恐:</td>
													<td><input type="checkbox" name="tendency" value="f" />恐惧</td>
													<td><input type="checkbox" name="tendency" value="u" />&nbsp;&nbsp;&nbsp;慌</td>
												</tr>
											</table>
										</td>
									</tr>
									
									<tr>
										<td>
											<table>
												<tr>
													<td class="mytype">恶:</td>
													<td><input type="checkbox" name="tendency" value="t" />烦闷</td>
													<td><input type="checkbox" name="tendency" value="d" />贬责</td>
													<td><input type="checkbox" name="tendency" value="a" />憎恶</td>
													<td><input type="checkbox" name="tendency" value="j" />嫉妒</td>
													<td><input type="checkbox" name="tendency" value="y" />怀疑</td>
													<td><input type="checkbox" name="tendency" value="x" />&nbsp;&nbsp;&nbsp;羞</td>
												</tr>
											</table>
										</td>
									</tr>
									
									<tr>
										<td>
											<table>
												<tr>
													<td class="mytype">惊:</td>
													<td><input type="checkbox" name="tendency" value="q" />惊奇</td>
												</tr>
											</table>
										</td>
									</tr>
									
									<tr>
										<td>
											<table>
												<tr>
													<td class="mytype">无:</td>
													<td><input type="checkbox" name="tendency" value="o" />&nbsp;&nbsp;&nbsp;无</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<table  style="margin-top:20px" class="mytable">
						<tr>
							<td >否定副词#</td>
							<td ><input id="negative" style="height: 35px;width: 300px;font-size:20px;color:#999999;border: 1px solid #dcdbdb;" type="text" name="negative" value="使用英文 ; 分割" onfocus="if(this.value=='使用英文 ; 分割'){ this.value='';this.style.color='#000';}"  onblur="if(this.value==''){ this.value='使用英文 ; 分割';this.style.color='#999'}"/></td>
						</tr>
						<tr>
							<td >程度副词#</td>
							<td ><input id="degree" style="height: 35px;width: 300px;font-size:20px;color:#999999;border: 1px solid #dcdbdb;" type="text" name="degree" value="使用英文 ; 分割" onfocus="if(this.value=='使用英文 ; 分割'){ this.value='';this.style.color='#000';}"  onblur="if(this.value==''){ this.value='使用英文 ; 分割';this.style.color='#999'}"/></td>
						</tr>
						<tr>
							<td >关键词#</td>
							<td ><input id="feature" style="height: 35px;width: 320px;font-size:20px;color:#999999;border: 1px solid #dcdbdb;" type="text" name="feature" value="使用英文 ; 分割" onfocus="if(this.value=='使用英文 ; 分割'){ this.value='';this.style.color='#000';}"  onblur="if(this.value==''){ this.value='使用英文 ; 分割';this.style.color='#999'}"/></td>
						</tr>
					</table>
				</div>
				<table style="margin-top:20px" class="mytable">
						<tr>
							<td>修辞类别#</td>
							<td>
								<table>
									<tr>
										<td><input type="radio" name="type" value="biyu"/>比喻</td>
										<td><input type="radio" name="type" value="bini"/>比拟</td>
										<td><input type="radio" name="type" value="jiedai"/>借代</td>
										<td><input type="radio" name="type" value="kuazhang"/>夸张</td>
										<td><input type="radio" name="type" value="duiou"/>对偶</td>
									</tr>
									<tr>
										<td><input type="radio" name="type" value="paibi"/>排比</td>
										<td><input type="radio" name="type" value="shewen"/>设问</td>
										<td><input type="radio" name="type" value="fanwen"/>反问</td>
										<td><input type="radio" name="type" value="chongfu"/>重复</td>
										<td><input type="radio" name="type" value="chenshu"/>陈述</td>
									</tr>
								</table>
							</td>
						</tr>
				</table>
				
				<div class="bbD">
					<p class="bbDP" align="center">
						<button id="save" style="margin-top:10px; font-size:16px;color:#fff; line-height:40px; width:100px;height: 40px;background-color: #1971FA">保存</button>
					</p>
				</div>
				<!-- <div class="bbD">
					<p class="bbDP" id="markp">
						<button id="2" class="btn_ok btn_yes" style="background-color: #1971FA" href="#">积极</button>
						<button id="0" class="btn_ok btn_yes" style="background-color:rgb(153, 150, 150)" href="#">消极</button>
						<button id="1" class="btn_ok btn_yes" style="background-color: #D2C755" href="#">中立</button>
					</p>
				</div> -->
			</div>
			<!-- 修改密码页面样式end -->
		</div>
	</div>
</body>
</html>