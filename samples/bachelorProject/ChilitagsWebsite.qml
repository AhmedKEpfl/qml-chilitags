import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtMultimedia 5.5
import Chilitags 1.0
import QtWebKit 3.0

ChilitagsObject {
    name: "tag_32"
    property string webSiteUrl :"https://www.youtube.com/"
    property string messageToDisplay: "Going to Youtube"

    onVisibilityChanged: {
        if(visible && window.pause == false){
            webView.url = webSiteUrl;
            textMessage.text = messageToDisplay;
            redCircleText.text = messageToDisplay;
            increaseVideoOutputSize();
        } else {
            increaseBrowserSize();
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

        putCircleAtPosition(xOnScreen, yOnScreen);
    }
}

