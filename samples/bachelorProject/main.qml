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

    property bool started : false;
    property bool pause: false;

    property list<ChilitagsWebsite> chilitagsWebsites : [
        ChilitagsWebsite {
            webSiteUrl: "https://www.google.ch/?gfe_rd=cr&ei=fepNVsnXFuyg8wel1bS4CA"
            name: "tag_15"
            messageToDisplay: "Youpi"
        }

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

    Chilitags{
        id: chilitags
        chiliobjects:
            [tagYoutube, tagGoogle, tag0,
            tag1, tag2, tag3, tag4, tag5, tag6, tag7, tag8, tag9]
    }

    Chilitags {
        id: chilitagsConfigFile
        chiliobjects: chilitagsWebsites
    }

    ChilitagsWebsite {

        id: tagYoutube
        name: "tag_32"
        webSiteUrl :"https://www.youtube.com/embed/op0uloAV0wY"
        messageToDisplay: "Going to Youtube"
    }

    ChilitagsWebsite {
        id: tagGoogle
        name: "tag_10"
        webSiteUrl: "https://www.google.fr/?gws_rd=ssl"
        messageToDisplay: "Going to google"
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

    ChilitagsWebsite {
        id: tag0
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }

    ChilitagsWebsite {
        id: tag1
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }
    ChilitagsWebsite {
        id: tag2
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }
    ChilitagsWebsite {
        id: tag3
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }
    ChilitagsWebsite {
        id: tag4
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""

    }

    ChilitagsWebsite {
        id: tag5
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }
    ChilitagsWebsite {
        id: tag6
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }
    ChilitagsWebsite {
        id: tag7
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }
    ChilitagsWebsite {
        id: tag8
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }
    ChilitagsWebsite {
        id: tag9
        name: ""
        webSiteUrl: ""
        messageToDisplay: ""
    }

    function putCircleAtPosition(x, y){
        redCircle.x = x;
        redCircle.y = y;
    }

    function increaseBrowserSize(){
        redCircle.visible = false;
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

        /*
        for(var i = 0; i < 10; ++i){
            chilitagsWebsites[i].name = tagUrlPairs[4 * i];
            chilitagsWebsites[i].webSiteUrl = tagUrlPairs[4 * i + 1];
            chilitagsWebsites[i].messageToDisplay = tagUrlPairs[4 * i + 2];
        }*/

        tag0.name = tagUrlPairs[0];
        tag0.webSiteUrl = tagUrlPairs[1];
        tag0.messageToDisplay = tagUrlPairs[2];

        tag1.name = tagUrlPairs[4];
        tag1.webSiteUrl = tagUrlPairs[5];
        tag1.messageToDisplay = tagUrlPairs[6];

        tag2.name = tagUrlPairs[8];
        tag2.webSiteUrl = tagUrlPairs[9];
        tag2.messageToDisplay = tagUrlPairs[10];

        tag3.name = tagUrlPairs[12];
        tag3.webSiteUrl = tagUrlPairs[13];
        tag3.messageToDisplay = tagUrlPairs[14];

        tag4.name = tagUrlPairs[16];
        tag4.webSiteUrl = tagUrlPairs[17];
        tag4.messageToDisplay = tagUrlPairs[18];

        tag5.name = tagUrlPairs[20];
        tag5.webSiteUrl = tagUrlPairs[21];
        tag5.messageToDisplay = tagUrlPairs[22];

        tag6.name = tagUrlPairs[24];
        tag6.webSiteUrl = tagUrlPairs[25];
        tag6.messageToDisplay = tagUrlPairs[26];

        tag7.name = tagUrlPairs[28];
        tag7.webSiteUrl = tagUrlPairs[29];
        tag7.messageToDisplay = tagUrlPairs[30];

        tag8.name = tagUrlPairs[32];
        tag8.webSiteUrl = tagUrlPairs[33];
        tag8.messageToDisplay = tagUrlPairs[34];

        tag9.name = tagUrlPairs[36];
        tag9.webSiteUrl = tagUrlPairs[37];
        tag9.messageToDisplay = tagUrlPairs[38];

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
            filters: [chilitags, chilitagsConfigFile]
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

    Rectangle {
        id: pauseRectangle
        anchors.fill: parent
        color: "white"
        z : -1

        Text {
            id : pauseText
            text: qsTr("")
            anchors.centerIn: parent
        }
    }
}
