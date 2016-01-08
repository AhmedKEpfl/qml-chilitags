import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtMultimedia 5.5
import Chilitags 1.0
import QtWebKit 3.0

Window {
    id: window
    visible: true
    maximumHeight: 480
    maximumWidth: 640
    height: maximumHeight
    width: maximumWidth

    property int counterSteps: 8

    property bool started : false;
    property bool pause: false;

    property list<ChilitagsWebsite> chilitagsWebsites : [
        ChilitagsWebsite {}, ChilitagsWebsite {},ChilitagsWebsite {},ChilitagsWebsite {},ChilitagsWebsite {},
        ChilitagsWebsite {},ChilitagsWebsite {},ChilitagsWebsite {},ChilitagsWebsite {},ChilitagsWebsite {}
    ]

    onActiveChanged: {
        if(!started){
            assignTagsToUrls();
            started = true;
        }
    }

    Camera{
        id:camDevice
        imageCapture.resolution: "640x480" //Android sets the viewfinder resolution as the capture one
        viewfinder.resolution: "640x480"
    }

    Chilitags {
        id: chilitagsConfigFile
        chiliobjects: chilitagsWebsites
    }

    Timer {
        interval: 500
        repeat: true
        running: true

        onTriggered: {
            getPauseStateFromServer();
        }
    }

    function getPauseStateFromServer(){
        var request = new XMLHttpRequest();
        request.open('GET', 'file:///home/ahmed/Documents/epfl/bachelorProject/MyBachelorProject/qml-chilitags/samples/bachelorProject/pause.txt');
        request.onreadystatechange = function(event) {
            if (request.readyState === XMLHttpRequest.DONE) {
                var lines = request.responseText;
                if(lines.substring(0, 5) == "pause"){
                    activatePause();
                } else {
                    deactivatePause();
                }
            }
        }
        request.send();
    }

    function activatePause() {
        webViewContainer.visible = false;
        pause = true;
    }

    function deactivatePause() {
        webViewContainer.visible = true;
        pause = false;
    }

    function putCircleAtPosition(x, y, counter){
        redCircle.x = x;
        redCircle.y = y;

        greenCircle.width = (counter - 1) * redCircle.width / counterSteps;
    }

    function increaseBrowserSize(){
        redCircle.visible = false;
        greenCircle.visible = false;
        videoOutputContainer.width = 120;
        videoOutputContainer.height = 80;
        webViewContainer.width = window.width;
        webViewContainer.height = window.height;
        videoOutputContainer.z = 1;
        webViewContainer.z = 0;
        webViewContainer.horizontalScrollBarPolicy = Qt.ScrollBarAsNeeded;
        webViewContainer.verticalScrollBarPolicy = Qt.ScrollBarAsNeeded;
    }

    function increaseVideoOutputSize(){
        redCircle.visible = true;
        greenCircle.visible = true;
        videoOutputContainer.width = window.width;
        videoOutputContainer.height = window.height;
        webViewContainer.width = 120;
        webViewContainer.height = 80;
        videoOutputContainer.z = 0;
        webViewContainer.z = 1;  
        webViewContainer.horizontalScrollBarPolicy = Qt.ScrollBarAlwaysOff;
        webViewContainer.verticalScrollBarPolicy = Qt.ScrollBarAlwaysOff;
    }

    function assignTagsToUrls(){
        textMessage.text = "Assigning tags to urls";
        var tagUrlPairs = FileIO.read().split('\n');


        for(var i = 0; i < 10; ++i){
            chilitagsWebsites[i].name = tagUrlPairs[4 * i];
            chilitagsWebsites[i].webSiteUrl = tagUrlPairs[4 * i + 1];
            chilitagsWebsites[i].messageToDisplay = tagUrlPairs[4 * i + 2];
        }

        textMessage.text = "Tags have been assigned";
    }

    Rectangle{
        id: videoOutputContainer
        property int initialWidth: 120
        property int initialHeight: 80
        width: initialWidth
        height: initialHeight

        VideoOutput{
            id: videoOutput
            source: camDevice
            anchors.fill: parent
            filters: chilitagsConfigFile
        }

        Rectangle {
             id: redCircle
             width: (parent.width < parent.height ? parent.width : parent.height) / 5
             height: width
             color: "red"
             border.color: "black"
             border.width: 1
             radius: width * 0.5

             Text {
                 id: redCircleText
                 x: parent.width
                 text: "red circle"
             }
        }

        Rectangle {
            id: greenCircle

            x: redCircle.x
            y: redCircle.y

            width: 10
            height: width

            color: "green"
            radius: width * 0.5
        }
    }

    ScrollView {
        id: webViewContainer
        property int initialWidth: parent.width
        property int initialHeight: parent.height
        width: initialWidth
        height: initialHeight


        WebView{
            id: webView
            url: "https://fr.wikipedia.org/"

            onLoadingChanged: {
                if(!webView.loading){
                    textMessage.text = "Doing nothing";
                }
            }
        }
    }

    Rectangle {
        id: textMessageContainer
        property int initialHeight: parent.height / 10

        opacity: 0.4
        width: window.width
        height: initialHeight
        y: window.height - initialHeight
        z: 2

        Text{
            id: textMessage
            text: "Doing nothing"
        }
    }
}
