<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx}/static/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery-webcam-plugin/jquery.webcam.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		//创建画布指定宽度和高度
        var canvas = document.createElement("canvas");
        $("body").append(canvas);
        canvas.setAttribute('width', 320);
        canvas.setAttribute('height', 240);
        
		//设置画布为2d，未来可能支持3d
        var ctx = canvas.getContext("2d");
		//截图320*240，即整个画布作为有效区(cutx?)
        var image = ctx.getImageData(0, 0, 320, 240);
        var pos = 0;
        
        function show (data) {
			//把data切割为数组
            var col = data.split(";");
            var img = image;
			//绘制图像(这里不是很理解算法)
			//参数data  只是每行的数据  ，例如320*240 大小的照片，一张完整的照片下来需要240个data，每个data有320个rgb
            for(var i = 0; i < 320; i++) {
                //转换为十进制
                /* var tmp = parseInt(col[i]);
                img.data[pos + 0] = (tmp >> 16) & 0xff;
                img.data[pos + 1] = (tmp >> 8) & 0xff;
                img.data[pos + 2] = tmp & 0xff;
                img.data[pos + 3] = 0xff; */
                pos+= 4;
            }
            if (pos%(4*320*240) == 0) {
				//把图像放到画布上,输出为png格式
                // ctx.putImageData(img, 0, 0);
                pos = 0;
                console.log("success {pos:"+pos+",img.data:"+img.data.length+"}");
            } else{
            	console.log("error {pos:"+pos+",img.data:"+img.data.length+"}");
            }
        };
        
        function sendDate(data){
        	console.log("sending......");
        	$.post("${ctx}/webcam/upload",{"pic":"1111111"},function(res){
        		console.log("upload success");
        	});
        }
        
		
		$("#webcam").webcam({
			 
		    width: 320,
		    height: 240,
		    mode: "stream",
		    swffile: "${ctx}/static/jquery-webcam-plugin/jscam_canvas_only.swf", // canvas only doesn't implement a jpeg encoder, so the file is much smaller
		 
		    onTick: function(remain) {
		 
		        if (0 == remain) {
		            $("#status").text("Cheese!");
		        } else {
		            $("#status").text(remain + " seconds remaining...");
		        }
		    },
		 
		    onSave: function(data) {
		    	//sendDate(data);
		    	show(data);
		        // var col = data.split(";");
		    // Work with the picture. Picture-data is encoded as an array of arrays... Not really nice, though =/
		    	//console.log(col.length);
		    },
		 
		    onCapture: function () {
		        webcam.save();
		 
		      // Show a flash for example
		    },
		 
		    debug: function (type, string) {
		        // Write debug information to console.log() or a div, ...
		    },
		 
		    onLoad: function () {
		    // Page load
		        var cams = webcam.getCameraList();
		        for(var i in cams) {
		            jQuery("#cams").append("<li>" + cams[i] + "</li>");
		        }
		    }
		});
		
		$("#photoBtn").click(function(){
			webcam.capture();
		});
	});
</script>
</head>
<body>
	<div id="status">11111111111111</div>
	<div id="webcam"></div>
	<button id="photoBtn">拍照</button>
	<img alt="" src=""  id="img" width="320" height="240" />
</body>
</html>