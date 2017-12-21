<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx}/static/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	var wsUri = "ws://localhost:8080${ctx}/message";
	var ws = new WebSocket(wsUri);
	ws.onopen=function(evn){
		log("[----------------开启连接----------------]");
	}
	
	ws.onmessage=function(evn){
		log(evn.data,true);
	}
	
	ws.onclose=function(evn){
		log("[----------------关闭连接----------------]");
	}

	var pc = new RTCPeerConnection();
	pc.onaddstream = function(obj) {
	  var vid = document.createElement("video");
	  document.appendChild(vid);
	  vid.srcObject = obj.stream;
	}
	
	// Helper functions
	function endCall() {
	  var videos = document.getElementsByTagName("video");
	  for (var i = 0; i < videos.length; i++) {
	    videos[i].pause();
	  }
	
	  pc.close();
	}
	
	function error(err) { endCall(); }
	
	
	//兼容浏览器的PeerConnection写法
	var PeerConnection = (window.PeerConnection || window.webkitPeerConnection00 || window.webkitRTCPeerConnection || window.mozRTCPeerConnection);
	
	//创建PeerConnection实例
	var pc = new RTCPeerConnection();


	var getUserMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);

	getUserMedia.call(navigator, {
	    video: true,
	    audio: true
	}, function(stream) {
		pc.addStream(stream);
		
		pc.createOffer(function(offer) {
			pc.setLocalDescription(new RTCSessionDescription(offer), function() {
		      // send the offer to a server to be forwarded to the friend you're calling.
		      $.post("",{},function(){
		    	  
		      });
			}, error);
		}, error);
		
		
	    var video = document.getElementById('video');
	    video.src = window.URL.createObjectURL(stream);
	    video.onloadedmetadata = function(e) {
	        console.log("Label: " + stream.label);
	        console.log("AudioTracks" , stream.getAudioTracks());
	        console.log("VideoTracks" , stream.getVideoTracks());
	    };
	}, function(e) {
	    console.log('Reeeejected!', e);
	});
	
	
	
	function log(msg){
		console.log(msg);
	}
</script>
</script>
</head>
<body>
	<video id="video" autoplay="autoplay"></video>
</body>
</html>