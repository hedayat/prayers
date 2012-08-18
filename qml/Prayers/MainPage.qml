import QtQuick 1.1
import com.nokia.meego 1.0
import 'PrayTimes.js' as PrayTimes

Page {
    tools: commonTools
    anchors.margins: 50
    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    Component.onCompleted:
    {
        PrayTimes.prayTimes.setMethod('Tehran')
        var date = new Date(); // today
        var times = PrayTimes.prayTimes.getTimes(date, [32.6729, 51.6666], 3.5)
        var test = new Number(4.5);
//        fajrTime.text = test.toLocaleString()
        midnightTime2.text = test.toLocaleString()
        fajrTime.text = times.fajr
        sunriseTime.text = times.sunrise
        dhuhrTime.text = times.dhuhr
        asrTime.text = times.asr
        sunsetTime.text = times.sunset
        maghribTime.text = times.maghrib
        ishaTime.text = times.isha
        midnightTime.text = times.midnight
    }

    Column {
        anchors.fill: parent
        spacing: 30

        Item {
            id: titleRec
            height: titleText.height * 2
            width: parent.width
            Text {
                anchors.centerIn: parent
                id: titleText
                text: qsTr("NewTitle")
            }
        }

        Flickable {
            boundsBehavior: Flickable.DragOverBounds
            flickableDirection: Flickable.VerticalFlick
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height - titleRec.height
            //        anchors.fill: parent
            contentHeight: grid1.height
            clip: true
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
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
                    text: "00:00"
                    font.bold: true
                    font.pixelSize: 24
                }
            }
        }
    }
}
