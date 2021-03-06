<%@page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<link rel="stylesheet" type="text/css" href="css/css.css" />
<script type="text/javascript" src="js/Chart.js"></script>
<style type="text/css">
body {
	padding: 0;
	margin: 0;
}

#canvas-holder {
	width: 40%;
}
#chart-area {
	margin-top: 190px;
}
</style>
<script>
	
	var now = new Date();
	var randomScalingFactor = function() {
		return Math.round(Math.random() * 1000)
	};
	var barChartData = {
		labels : [ (new Date(now.getTime() - 6 * 24 * 3600 * 1000).getMonth() + 1)+"月"+new Date(now.getTime() - 6 * 24 * 3600 * 1000).getDate()+"号",
		           (new Date(now.getTime() - 5 * 24 * 3600 * 1000).getMonth() + 1)+"月"+new Date(now.getTime() - 5 * 24 * 3600 * 1000).getDate()+"号",
		           (new Date(now.getTime() - 4 * 24 * 3600 * 1000).getMonth() + 1)+"月"+new Date(now.getTime() - 4 * 24 * 3600 * 1000).getDate()+"号",
		           (new Date(now.getTime() - 3 * 24 * 3600 * 1000).getMonth() + 1)+"月"+new Date(now.getTime() - 3 * 24 * 3600 * 1000).getDate()+"号",
		           (new Date(now.getTime() - 2 * 24 * 3600 * 1000).getMonth() + 1)+"月"+new Date(now.getTime() - 2 * 24 * 3600 * 1000).getDate()+"号", 
		           (new Date(now.getTime() - 1 * 24 * 3600 * 1000).getMonth() + 1)+"月"+new Date(now.getTime() - 1 * 24 * 3600 * 1000).getDate()+"号", 
		           (now.getMonth() + 1)+"月"+now.getDate()+"号" ],
		datasets : [
				{
					fillColor : "rgb(153, 150, 150)",
					strokeColor : "rgb(189, 186, 186)",
					highlightFill : "rgb(97, 91, 91)",
					highlightStroke : "rgb(128, 123, 123)",
					data : ["${weekdata[6][0]}", "${weekdata[5][0]}","${weekdata[4][0]}", "${weekdata[3][0]}",
					         "${weekdata[2][0]}", "${weekdata[1][0]}", "${weekdata[0][0]}"]
				},{
					fillColor : "#4390b9",
					strokeColor : "#0E95DD",
					highlightFill : "#1955D7",
					highlightStroke : "#013CF7",
					data : [ "${weekdata[6][1]}", "${weekdata[5][1]}","${weekdata[4][1]}", "${weekdata[3][1]}",
					         "${weekdata[2][1]}", "${weekdata[1][1]}", "${weekdata[0][1]}"]
				} ]

	}

	var doughnutData = [ {
		value : "${tendency[0]}",
		color : "rgb(153, 150, 150)",
		highlight : "rgb(97, 91, 91)",
		label : "中性句"
	},{
		value : "${tendency[1]}",
		color : "#4390b9",
		highlight : "#1955D7",
		label : "情感句"
	}];

	window.onload = function() {
		var ctx1 = document.getElementById("chart-area").getContext("2d");
		window.myDoughnut = new Chart(ctx1).Doughnut(doughnutData, {
			responsive : true
		});
		
		var ctx2 = document.getElementById("canvas").getContext("2d");
		window.myBar = new Chart(ctx2).Bar(barChartData, {
			responsive : true
		});
	};
</script>
</head>
<body>
	<div id="pageAll">
		<div class="page">
			<!-- main页面样式 -->
			<div class="indexL" style="margin-top: 30px;">
				<!-- <img class="indexBn" src="img/indexBanner.png" /> -->
				<div style="width: 50%;float: left;margin-left: 20px;" align="center">
					<canvas id="canvas" height="477" width="636"></canvas>
					<div style="margin-top: 10px;"><span style="font-size: 18px;font-weight: bold;">最近一周数据分布</span></div>
				</div>
				<div id="canvas-holder" style="float: left;" align="center">
					<canvas id="chart-area"></canvas>
					<div style="margin-top: 10px;"><span style="font-size: 18px;font-weight: bold;"><c:choose><c:when test="${user.type eq '2' }">个人数据：</c:when><c:otherwise>总体数据：</c:otherwise></c:choose></span><span style="font-size: 16px;">[中性句:<font size="18px" style="font-weight:bold;color: rgb(97, 91, 91);">${tendency[0]}</font> 情感句:<font size="18px" style="font-weight:bold;color: #4390b9;">${tendency[1]}</font> ]</span><div>
				</div>
			</div>
			<!-- main页面样式end -->
		</div>
	</div>
</body>
</html>