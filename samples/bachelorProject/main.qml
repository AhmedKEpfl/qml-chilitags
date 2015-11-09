import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtMultimedia 5.5
import Chilitags 1.0
import QtWebKit 3.0

Window {
    id: window
    visible: true
    height: 480
    width: 640

    Camera{
        id:camDevice
        imageCapture.resolution: "640x480" //Android sets the viewfinder resolution as the capture one
        viewfinder.resolution: "640x480"
    }

    Chilitags{
        id: chilitags
        chiliobjects: [tag2, tag32]
    }

    ChilitagsObject{
        id: tag2
        name: "tag_2"

        onVisibilityChanged: {
            if(tag2.visible){
                increaseVideoOutputSize();
            } else {
                increaseBrowserSize();
            }
        }
    }

    ChilitagsObject{
        id: tag32
        name: "tag_32"
        property string webSiteUrl :"https://www.google.fr/?gws_rd=ssl"
        property string messageToDisplay: "Going to google"

        onVisibilityChanged: {
            if(tag32.visible){
                webView.url = webSiteUrl;
                textMessage.text = messageToDisplay + "\n" + tag32.transform.m14;

            }
        }
    }

    function increaseBrowserSize(){
        videoOutputContainer.width = 120;
        videoOutputContainer.height = 80;
        webViewContainer.width = window.width;
        webViewContainer.height = window.height;
        videoOutputContainer.z = 1;
    }

    function increaseVideoOutputSize(){
        videoOutputContainer.width = window.width;
        videoOutputContainer.height = window.height;
        webViewContainer.width = 120;
        webViewContainer.height = 80;
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
            filters: chilitags
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

