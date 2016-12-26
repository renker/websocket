<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Message Demo</title>
<style type="text/css">
	#messageArea{float: left;width: 30%;}
	#logArea{
		height: 300px;
		width:400px;
		border: 1px solid #C0CCD8;
		float: left;
		margin-left: 50px;
		padding: 10px;
		overflow-y:scroll;
	}
	
	#logArea p{margin: 5px 0px;padding: 0px;color:#797979;font-size:12px;}
	
	#messageText{
		width: 360px; height: 60px;
		color:#797979;font-size:12px;
	}
</style>

<script type="text/javascript" src="${ctx}/static/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/static/sockJs/sockjs-1.1.1.min.js"></script>

<script type="text/javascript">
	var wsUri = "http://localhost:8080${ctx}/spring/sockJs";
	var ws = null;
	$(function(){
		defaultSetting();
		btnEvent();
	});
	
	function defaultSetting(){
		$("#startBtn").removeAttr("disabled");
		$("#stopBtn").attr("disabled","disabled");
		$("#sendBtn").attr("disabled","disabled");
	}
	
	function btnEvent(){
		$("#startBtn").click(function(){
			ws = new SockJS(wsUri);
			
			ws.onopen=function(evn){
				log("[----------------开启连接----------------]");
			}
			
			ws.onmessage=function(evn){
				log(evn.data,true);
			}
			
			ws.onclose=function(evn){
				log("[----------------关闭连接----------------]");
			}
			$("#startBtn").attr("disabled","disabled");
			$("#stopBtn").removeAttr("disabled");
			$("#sendBtn").removeAttr("disabled");
		});
		
		$("#stopBtn").click(function(){
			$("#startBtn").removeAttr("disabled");
			$("#stopBtn").attr("disabled","disabled");
			$("#sendBtn").attr("disabled","disabled");
			ws.close();
		});
		
		$("#sendBtn").click(function(){
			var msg = $("#messageText").val();
			var userName = $("#userName").val();
			var msgJson = "{\"subject\":\""+userName+"\",\"message\":\""+msg+"\"}";
			ws.send(msgJson);
		});
	}
	
	function log(data,isJson){
		var time = new Date();
		var log = '<p>'+Format(time,"HH:mm:ss")+"  "+data+'</p>';
		if(isJson != undefined && isJson){
			var json = $.parseJSON(data);
			log = '<p>'+Format(time,"HH:mm:ss")+"  "+json.subject+"："+json.message+'</p>';
		}
		$("#logArea").append(log);
		$('#logArea').scrollTop($('#logArea')[0].scrollHeight);
	}
	
	
    function Format(now,mask)
    {
        var d = now;
        var zeroize = function (value, length)
        {
            if (!length) length = 2;
            value = String(value);
            for (var i = 0, zeros = ''; i < (length - value.length); i++)
            {
                zeros += '0';
            }
            return zeros + value;
        };
     
        return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0)
        {
            switch ($0)
            {
                case 'd': return d.getDate();
                case 'dd': return zeroize(d.getDate());
                case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
                case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
                case 'M': return d.getMonth() + 1;
                case 'MM': return zeroize(d.getMonth() + 1);
                case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
                case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
                case 'yy': return String(d.getFullYear()).substr(2);
                case 'yyyy': return d.getFullYear();
                case 'h': return d.getHours() % 12 || 12;
                case 'hh': return zeroize(d.getHours() % 12 || 12);
                case 'H': return d.getHours();
                case 'HH': return zeroize(d.getHours());
                case 'm': return d.getMinutes();
                case 'mm': return zeroize(d.getMinutes());
                case 's': return d.getSeconds();
                case 'ss': return zeroize(d.getSeconds());
                case 'l': return zeroize(d.getMilliseconds(), 3);
                case 'L': var m = d.getMilliseconds();
                    if (m > 99) m = Math.round(m / 10);
                    return zeroize(m);
                case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
                case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
                case 'Z': return d.toUTCString().match(/[A-Z]+$/);
                // Return quoted strings with the surrounding quotes removed
                default: return $0.substr(1, $0.length - 2);
            }
        });
    };
	
</script>
</head>
<body>
	<div id="messageArea">
		<div>
			<input id="userName" type="text" value="" />
			<textarea id="messageText">test message ... </textarea>
		</div>
		<button id="startBtn" >启动</button>
		<button id="stopBtn" disabled="disabled">停止</button>
		<button id="sendBtn" disabled="disabled">发送消息</button>
	</div>
	<div id="logArea">
		
	</div>
</body>
</html>