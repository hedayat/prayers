/*
 *  Prayers, Islamic prayer time application
 *  Copyright (C) 2013  Hedayat Vatankhah <gmail email: hedayatv>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 1.1
import QtMobility.location 1.1
import com.nokia.meego 1.0

Sheet {
    id: locationSheet

    property int index: -1
    property variant location: { "title": locationName.text,
                                 "lat": locationLat.text,
                                 "long": locationLong.text,
                                 "elv": locationElv.text }

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    acceptButtonText: qsTr("Save")
    rejectButtonText: qsTr("Cancel")

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

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Current Location"
                onClicked: positionSource.start()
            }
        }
    }

    PositionSource {
        id: positionSource
        updateInterval: 5000
        active: false
        onPositionChanged: {
            locationLat.text = position.coordinate.latitude
            locationLong.text = position.coordinate.longitude
            if (position.altitudeValid)
                locationElv.text = position.coordinate.altitude
        }
    }

    onStatusChanged: {
        if (status === DialogStatus.Opening)
        {
            locationName.text = location.title
            locationLat.text = location.lat
            locationLong.text = location.long
            locationElv.text = location.elv
        }
    }

    onAccepted: {
        positionSource.stop()
        location = { "title": locationName.text,
            "lat": locationLat.text,
            "long": locationLong.text,
            "elv": locationElv.text }
        updateLocation()
    }
    onRejected: positionSource.stop()
}
