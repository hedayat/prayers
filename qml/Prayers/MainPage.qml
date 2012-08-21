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
        timelist.append({"title":qsTr("Fajr"),
                            "time": Qt.formatTime(new Date(base_hack_str + times.fajr))})
        timelist.append({"title":qsTr("Sunrise"),
                            "time": Qt.formatTime(new Date(base_hack_str + times.sunrise))})
        timelist.append({"title":qsTr("Dhuhr"),
                            "time": Qt.formatTime(new Date(base_hack_str + times.dhuhr))})
        timelist.append({"title":qsTr("Asr"),
                            "time": Qt.formatTime(new Date(base_hack_str + times.asr))})
        timelist.append({"title":qsTr("Sunset"),
                            "time": Qt.formatTime(new Date(base_hack_str + times.sunset))})
        timelist.append({"title":qsTr("Maghrib"),
                            "time": Qt.formatTime(new Date(base_hack_str + times.maghrib))})
        timelist.append({"title":qsTr("Isha"),
                            "time": Qt.formatTime(new Date(base_hack_str + times.isha))})
        timelist.append({"title":qsTr("Midnight"),
                            "time": Qt.formatTime(new Date(base_hack_str + times.midnight))})
    }

    ListModel {
        id: timelist
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

        GridView {
            id: timegrid
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height - titleRec.height
            model: timelist
            clip: true
            cellWidth: 375

            delegate:
                Row {
                Text {
                    width: timegrid.cellWidth / 2
                    font.bold: true
                    font.pixelSize: 24
                    text: title
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    width: timegrid.cellWidth / 2
                    font.bold: true
                    font.pixelSize: 24
                    text: time
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}
