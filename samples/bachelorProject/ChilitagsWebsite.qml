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

    property double currentXValue : 0
    property double currentYValue: 0
    property double currentZValue: 0

    property double xOnScreen: 0
    property double yOnScreen: 0

    onVisibilityChanged: {
        if(visible){
            webView.url = webSiteUrl;
            textMessage.text = messageToDisplay;
            redCircleText.text = messageToDisplay;
            increaseVideoOutputSize();
        } else {
            increaseBrowserSize();
        }
    }

    onTransformChanged: {
        currentXValue = transform.m14;
        currentYValue = transform.m24;
        currentZValue = transform.m34;
        xOnScreen = currentXValue / currentZValue;
        yOnScreen = currentYValue / currentZValue;

        xOnScreen = (xOnScreen + 0.45) * videoOutput.width / 0.9;
        yOnScreen = (yOnScreen + 0.34) * videoOutput.height / 0.62;

        putCircleAtPosition(xOnScreen, yOnScreen);
    }
}

