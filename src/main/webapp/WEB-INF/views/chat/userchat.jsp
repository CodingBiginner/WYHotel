<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>wy hotel user chat</title>
<style>
	#textMessage{
        width: 80%;
        height: 5%;
        
        float: left;
	}
	
	#sendButton{
        width: 20%;
        height: 5%;
        float: left;
        background-color: white;
        border : 1px solid black;
	}
	
	#messageTextArea{
		background-color:white;
        float: left;
		width : 100%;
		height : 95%;
		resize : none;
	}
	img {
		position: absolute;
		left : 50%;
		top : 50%;
		transform: translate(-50%, -50%);
		opacity : 0.2;
	}
</style>
</head>
<body onresize="parent.resizeTo(700,700)" onload="parent.resizeTo(700,700)">
	
	<!-- 채팅 영역 -->
	<form>
		<!-- 텍스트 박스에 채팅의 내용을 작성한다. -->
		<input id="textMessage" type="text" onkeydown="return enter()">
		
		<!-- 서버로 메시지를 전송하는 버튼 -->
		<input id="sendButton" onclick="sendMessage()" value="Send"
			type="button">
			
	</form>
	<br />
	
	<!-- 서버와 메시지를 주고 받는 콘솔 텍스트 영역 -->
	<div>
		<img alt="" src="${pageContext.request.contextPath}/img/logo.svg">
		<textarea id="messageTextArea" rows="10" cols="50" disabled="disabled"></textarea>
	</div>
	<script type="text/javascript">
		// 서버의 broadsocket의 서블릿으로 웹 소켓을 한다.
		var webSocket = new WebSocket("ws://wyhotel.site:9053/chat/boardsocket");
		// 콘솔 텍스트 영역
		var messageTextArea = document.getElementById("messageTextArea");
		// 접속이 완료되면
		webSocket.onopen = function(message) {
			// 콘솔에 메시지를 남긴다.
			messageTextArea.value += "안녕하세요 WY HOTEL 실시간 채팅입니다.\n응답이 없을경우 전화번호를 남겨주시면 확인후 처리해드리겠습니다.\n";
		};
		// 접속이 끝기는 경우는 브라우저를 닫는 경우이기 떄문에 이 이벤트는 의미가 없음.
		webSocket.onclose = function(message) {
		};
		// 에러가 발생하면
		webSocket.onerror = function(message) {
			// 콘솔에 메시지를 남긴다.
			messageTextArea.value += "관리자가 현재 부재중이므로 채팅이 불가능 합니다.\n";
		};
		// 서버로부터 메시지가 도착하면 콘솔 화면에 메시지를 남긴다.
		webSocket.onmessage = function(message) {
			messageTextArea.value += "관리자 => " + message.data + "\n";
		};
		// 서버로 메시지를 발송하는 함수
		// Send 버튼을 누르거나 텍스트 박스에서 엔터를 치면 실행
		function sendMessage() {
			// 텍스트 박스의 객체를 가져옴
			let message = document.getElementById("textMessage");
			// 콘솔에 메세지를 남긴다.
			if('${id}' !== ''){
				messageTextArea.value +=  '${id}'+"=>" + message.value + "\n";
			}else{
				messageTextArea.value += "(me) => " + message.value + "\n";	
			}
			// 소켓으로 보낸다.
			webSocket.send(message.value);
			// 텍스트 박스 추기화
			message.value = "";
		}
		// 텍스트 박스에서 엔터를 누르면
		function enter() {
			// keyCode 13은 엔터이다.
			if (event.keyCode === 13) {
				// 서버로 메시지 전송
				sendMessage();
				// form에 의해 자동 submit을 막는다.
				return false;
			}
			return true;
		}
	</script>
</body>
</html>