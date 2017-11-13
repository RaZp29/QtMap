import QtQuick 2.5
import QtQuick.Controls 2.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3

Item {
    id: menu1
    property alias mouseDelegate: radioDelegate1
    property alias markerDelegate: radioDelegate2
    property alias handDelegate: radioDelegate3
    property alias followButton: followButton
    property alias zoomSlider: zoomS
    property alias zoomValue: zoomVal
    property alias switchDelegate: switchDelegate
    property var mapSource
    width: 200
    height: 400

    Column {
        id: column
        x: 0
        y: 0
        width: 200
        height: 400

        ListView {
            id: listView
            x: 0
            y: 0

            RadioDelegate {
                id: radioDelegate1
                x: 0
                y: 68
                text: qsTr("Mouse")
            }

            RadioDelegate {
                id: radioDelegate2
                x: 0
                y: 126
                text: qsTr("Marker")
            }

            RadioDelegate {
                id: radioDelegate3
                x: 0
                y: 184
                text: qsTr("Hand")
            }

            SwitchDelegate {
                id: switchDelegate
                text: qsTr("Switch Delegate")
            }

            Button {
                id: followButton
                x: 0
                y: 253
                text: qsTr("Follow")
            }

            RowLayout {
                id: rowLayout
                x: 0
                y: 299
                width: 200
                height: 100

                Label {
                    id: label
                    text: qsTr("Zoom")

                    Slider {
                        id: zoomS
                        x: 0
                        y: 18
                        from: mapSource.minimumZoomLevel
                        to: mapSource.maximumZoomLevel
                        value: mapSource.zoomLevel
                        stepSize: 0.5
                        //snapMode: "SnapAlways"
                        snapMode: "SnapOnRelease"
                        /*onValueChanged: {
                            mapSource.zoomLevel = value
                            zoomVal.text = value
                    }*/
                        //value: 0.5
                    }
                }

                Label {
                    id: zoomVal
                    width: 66
                    height: 16
                    //text: qsTr("value: " + zoomS.value.totring())
                }
            }

        }
    }
}
