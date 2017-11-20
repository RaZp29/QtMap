import QtQuick 2.5;
import QtLocation 5.6
import QtQuick 2.0

MapQuickItem {
    id: marker
    property alias lastMouseX: markerMouseArea.lastX
    property alias lastMouseY: markerMouseArea.lastY
    property MapComponent overlay: null
    property variant markersConnected
    property variant polylinesConnected
    property int connectedCount: 0
    property int markerID: 0

    anchorPoint.x: rect.width/2
    anchorPoint.y: rect.height/2

    sourceItem: Rectangle {
        id:rect
        color: "LimeGreen"
        width: 10
        height: 10
        rotation: 45
        border.color: "Black"
        smooth: true
        opacity: markerMouseArea.pressed ? 0.6 : 1.0


        MouseArea  {
            id: markerMouseArea
            property int pressX : -1
            property int pressY : -1
            property int jitterThreshold : 10
            property int lastX: -1
            property int lastY: -1
            anchors.fill: parent
            hoverEnabled : false
            drag.target: marker
            preventStealing: true

            onClicked : {
                overlay.pressX = mouse.x
                overlay.pressY = mouse.y
                var prev = false
                if(overlay.currentMarker != -1) {
                    overlay.previousMarker = overlay.currentMarker
                } else if(overlay.currentMarker > -1) {

                } else {
                    prev = true
                }
                overlay.currentMarker = -1
                for (var i = 0; i< overlay.markers.length; i++){
                    if (marker == overlay.markers[i]){
                        overlay.currentMarker = i
                        if(overlay.previousMarker != overlay.currentMarker) {
                            overlay.connectMarkers()
                        } else {
                            overlay.currentMarker = -1
                            overlay.previousMarker = -1
                            console.log("dubbelpress")
                        }
                        break
                    }
                }
            }
        }
    }

    function connectMark(Marker) {
        //only connect to Marker if not already connected
        connectedCount ++
        markersConnected.push(Marker)
        if(markersConnected.length > 2) {
            rect.color = "Red"
        }
        printConnections()
    }

    function connectMarker(MarkerTo) {
        connectMark(MarkerTo)
        MarkerTo.connectMark(this)
    }

    function isConnectedTo(Marker) {
        //return markersConnected.contains(Marker)
        if(this == Marker) {
            return true
        }
        for (var i = 0; i< markersConnected.length; i++){
            if (Marker == markersConnected[i]){
                return true
            }
        }
        return false
    }

    function connectedMarkers() {
        return connectedCount
    }

    function connectedMarks() {
        return markersConnected.length
    }

    function returnID() {
        return markerID
    }

    function printConnections() {
        console.log(markerID, " is connected to: ")
        for (var i = 0; i< markersConnected.length; i++){
            console.log(markersConnected[i].returnID(), ", ")
        }
    }

    function disconnectMarkers() {
        for(var i = 0; i<markersConnected.length; i++) {
            var marker = markersConnected(i)
            marker.disconnectMarker(this)
        }
    }

    function disconnectMarker(Marker){
        connectedCount --
        //disconnect Marker from 1 or more Polylines
        markersConnected.pop(Marker)
        if(markersConnected.length < 3) {
            rect.color = "LimeGreen"
        }
    }

    Component.onCompleted: {
        //coordinate = overlay.toCoordinate(Qt.point(markerMouseArea.mouseX,
                                                              //markerMouseArea.mouseY));
        markerID = overlay.markerCounter
        markersConnected = new Array();
        polylinesConnected = new Array();
        //console.log(markerID)
    }
}
