import QtQuick 1.1
import com.nokia.meego 1.0

Sheet {
    id: locationSheet

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    acceptButtonText: qsTr("Save")
    rejectButtonText: qsTr("Cancel")

    property int index: -1
    property variant location: { "title": locationName.text,
                                 "lat": locationLat.text,
                                 "long": locationLong.text,
                                 "elv": locationElv.text }

    content: Flickable {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.topMargin: 10
        contentWidth: col2.width
        contentHeight: col2.height
        flickableDirection: Flickable.VerticalFlick
        Column {
            id: col2
            anchors.fill: parent
            width: 480
            spacing: 10

            Row {
                width: parent.width
                spacing: 10
                Text {
                    text: qsTr("Name:")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                TextField {
                    id: locationName
                    width: parent.width - parent.children[0].width - 20 - parent.spacing
                }
            }
            Row {
                width: parent.width
                spacing: 10
                Text {
                    text: qsTr("Latitude:")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                TextField {
                    id: locationLat
                    validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    width: parent.width - parent.children[0].width - 20 - parent.spacing
                }
            }
            Row {
                width: parent.width
                spacing: 10
                Text {
                    text: qsTr("Longitude:")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                TextField {
                    id: locationLong
                    validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    width: parent.width - parent.children[0].width - 20 - parent.spacing
                }
            }
            Row {
                width: parent.width
                spacing: 10
                Text {
                    text: qsTr("Elevation:")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                TextField {
                    id: locationElv
                    validator: DoubleValidator {}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    width: parent.width - parent.children[0].width - 20 - parent.spacing
                }
            }
        }
    }

    onStatusChanged: {
        if (status === DialogStatus.Opening || status === DialogStatus.Opened)
        {
            locationName.text = location.title
            locationLat.text = location.lat
            locationLong.text = location.long
            locationElv.text = location.elv
        }
    }

    onAccepted: {
        location = { "title": locationName.text,
            "lat": locationLat.text,
            "long": locationLong.text,
            "elv": locationElv.text }
        updateLocation()
    }
//    onRejected: console.log("Rejected")
}
