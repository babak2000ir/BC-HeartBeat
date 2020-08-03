var ControlAddIn = document.getElementById("controlAddIn");

function heartBeatRecievedByClient() {
    //
}

window.top.heartBeat = function() {
    console.log('Internal hit');
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('HeartBeat', [], true, heartBeatRecievedByClient);
}

window.top.startInterval = function() {
    setInterval(window.top.heartBeat, 1000);
}

window.top.startInterval();

var globalPanelInitDiv = document.createElement("div");
globalPanelInitDiv.id = "gpDiv";
globalPanelInitDiv.className = "container mt-3";
var ptag = document.createElement("p");
ptag.innerHTML  ="Global Panel Init";
globalPanelInitDiv.appendChild(ptag);
ControlAddIn.appendChild(globalPanelInitDiv);

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('GlobalPanelIsReady', null);
