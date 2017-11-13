import QtQuick 2.4
import QtPositioning 5.5

TestMenuForm {
    id:testMenu1
    signal followMe()
    signal delegate(var index)
    property var mapSourca


    Component.onCompleted: {
        mapSourca.zoomLevel = 14
        mapSource = mapSourca
    }

    followButton.onClicked: {
        //follow = !follow
        followMe()
    }

    zoomSlider.onValueChanged: {
        mapSource.zoomLevel = zoomSlider.value
        zoomValue.text = zoomSlider.value
        //zoomValue.text = Math.floor(zoomSlider.value)
    }

    mouseDelegate.onCheckedChanged: {
        if(mouseDelegate.checked)
            delegate(0)
    }

    markerDelegate.onCheckedChanged: {
        if(markerDelegate.checked)
            delegate(1)
    }

    handDelegate.onCheckedChanged: {
        if(handDelegate.checked)
            delegate(2)
    }

    //switchDelegate.
    //mouseDelegate:
    //markerDelegate:
    //handDelegate:
}
