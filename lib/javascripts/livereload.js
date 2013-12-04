(function () {
    var socket = new WebSocket("ws://localhost:5678/websocket");
    socket.onmessage = function () {
        window.location.reload();
    };
    socket.onerror = function (error) {
        console.log("Error: " + error.type);
    };
})();
