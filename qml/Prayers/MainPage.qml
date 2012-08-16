import QtQuick 1.1
import com.nokia.meego 1.0
import 'PrayTimes.js' as PrayTimes

Page {
    tools: commonTools
    anchors.margins: 50

    Component.onCompleted:
    {
        PrayTimes.prayTimes.setMethod('Tehran')
        var date = new Date(); // today
        var times = PrayTimes.prayTimes.getTimes(date, [32.6729, 51.6666], 3.5)
        fajrTime.text = times.fajr
        sunriseTime.text = times.sunrise
        dhuhrTime.text = times.dhuhr
        asrTime.text = times.asr
        sunsetTime.text = times.sunset
        maghribTime.text = times.maghrib
        ishaTime.text = times.isha
        midnightTime.text = times.midnight
    }

    Flickable {
        boundsBehavior: Flickable.DragOverBounds
        flickableDirection: Flickable.VerticalFlick
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        contentHeight: grid1.height
        Grid {
            id:grid1
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 50
            columns: 2
            Text {
                id: fajr
                text: qsTr("Fajr")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: fajrTime
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: sunrise
                text: qsTr("Sunrise")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: sunriseTime
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: dhuhr
                text: qsTr("Dhuhr")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: dhuhrTime
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: asr
                text: qsTr("Asr")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: asrTime
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: sunset
                text: qsTr("Sunset")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: sunsetTime
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: maghrib
                text: qsTr("Maghrib")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: maghribTime
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: isha
                text: qsTr("Isha")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: ishaTime
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: midnight
                text: qsTr("Midnight")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: midnightTime
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }
            Text {
                id: midnight3
                text: qsTr("Midnight")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: midnightTime3
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }
            Text {
                id: midnight1
                text: qsTr("Midnight")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: midnightTime1
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }
            Text {
                id: midnight2
                text: qsTr("Midnight")
                font.bold: true
                font.pixelSize: 24
            }

            Text {
                id: midnightTime2
                text: qsTr("00:00")
                font.bold: true
                font.pixelSize: 24
            }
        }
    }
}
