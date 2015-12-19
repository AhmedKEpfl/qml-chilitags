import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtMultimedia 5.5
import Chilitags 1.0
import QtWebKit 3.0

ChilitagsObject {
    name: "tag_32"
    property string webSiteUrl :"https://www.youtube.com/"
    property string messageToDisplay: "Youtube"

    property int timeLoading: 2000


    property string messageLoading: "Preparing for " + messageToDisplay
    property string messageReady: "Going to " + messageToDisplay
    property int counter: 0
    property bool counterIncrementing: false

    onVisibilityChanged: {
        if(visible && window.pause == false){
            redCircleText.text = messageLoading;
            increaseVideoOutputSize();
            counter = 0;
            counterIncrementing = true;
        } else {
            increaseBrowserSize();
            counter = 0;
            counterIncrementing = false;
        }
    }

    Timer {
        interval: timeLoading / window.counterSteps
        repeat: true
        running: true

        onTriggered: {
            if(counterIncrementing){
                if(counter == window.counterSteps){
                    webView.url = webSiteUrl;
                    textMessage.text = messageReady;
                    redCircleText.text = messageReady;
                    counterIncrementing = false;
                }

                counter++;
            }
        }
    }

    onTransformChanged: {
        var currentXValue = transform.m14;
        var currentYValue = transform.m24;
        var currentZValue = transform.m34;
        var xOnScreen = currentXValue / currentZValue;
        var yOnScreen = currentYValue / currentZValue;

        xOnScreen = (xOnScreen + 0.45) * videoOutput.width / 0.9;
        yOnScreen = (yOnScreen + 0.34) * videoOutput.height / 0.62;

        putCircleAtPosition(xOnScreen, yOnScreen, counter);
    }
}

