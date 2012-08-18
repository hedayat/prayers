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
        var base_hack_str = "August 18, 2012 "
        fajrTime.text = Qt.formatTime(new Date(base_hack_str + times.fajr))
        sunriseTime.text = Qt.formatTime(new Date(base_hack_str + times.sunrise))
        dhuhrTime.text = Qt.formatTime(new Date(base_hack_str + times.dhuhr))
        asrTime.text = Qt.formatTime(new Date(base_hack_str + times.asr))
        sunsetTime.text = Qt.formatTime(new Date(base_hack_str + times.sunset))
        maghribTime.text = Qt.formatTime(new Date(base_hack_str + times.maghrib))
        ishaTime.text = Qt.formatTime(new Date(base_hack_str + times.isha))
        midnightTime.text = Qt.formatTime(new Date(base_hack_str + times.midnight))
    }

    Column {
        anchors.fill: parent
        spacing: 30

        Item {
            id: titleRec
            height: titleText.height * 2
            width: parent.width
            Text {
                font.bold: true
                font.pixelSize: 24
                anchors.centerIn: parent
                id: titleText
                text: Qt.formatDate(new Date(), Qt.DefaultLocaleLongDate)
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
