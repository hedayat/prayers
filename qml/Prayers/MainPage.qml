import QtQuick 1.1
import com.nokia.meego 1.0
import 'PrayTimes.js' as PrayTimes

Page {
    tools: commonTools
    anchors.margins: 10
    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    function updateTimes()
    {
        var date = timegrid.viewDate;
        var times = PrayTimes.prayTimes.getTimes(date, [32.6729, 51.6666], 3.5)
        var base_hack_str = "August 18, 2012 "
        var i=0
        for (var vaght in times)
        {
            if (vaght === "imsak") continue;
            timelist.setProperty(i++, "time", Qt.formatTime(new Date(base_hack_str + times[vaght])));
        }
    }

    Component.onCompleted:
    {
        // params: Method, coords: lat.lang.elv
        PrayTimes.prayTimes.setMethod('Tehran')
        var date = new Date(); // today
        var times = PrayTimes.prayTimes.getTimes(date, [32.6729, 51.6666], 3.5)
        timegrid.viewDate = date
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
        id: timesCol
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
                text: Qt.formatDate(timegrid.viewDate, Qt.DefaultLocaleLongDate)
            }
        }

        Row {
            width: parent.width
            height: parent.height - titleRec.height

            Image {
                source: "image://theme/meegotouch-button-background-disabled"
                id: prevButton
                anchors.verticalCenter: parent.verticalCenter
                Image {
                    id: prevButtonImg
                    source: "image://theme/meegotouch-calendar-datepicker-monthgrid-previousbutton"
                    anchors.centerIn: parent
                    mirror: LayoutMirroring.enabled
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        prevButtonImg.source = "image://theme/meegotouch-calendar-datepicker-monthgrid-previousbutton-pressed"
                    }

                    onReleased: {
                        prevButtonImg.source = "image://theme/meegotouch-calendar-datepicker-monthgrid-previousbutton"
                    }

                    onClicked: {
                        var newdate = timegrid.viewDate
                        newdate.setDate(newdate.getDate() - 1)
                        timegrid.viewDate = newdate
                        updateTimes();
                    }
                }
            }

            GridView {
                id: timegrid
                width: parent.width - 2 * prevButton.width
                height: parent.height - 30
                model: timelist
                clip: true
                cellWidth: 350
                property date viewDate: "2000-01-01"

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

            Image {
                id: nextButton
                source: "image://theme/meegotouch-button-background-disabled"
                anchors.verticalCenter: parent.verticalCenter
                Image {
                    id: nextButtonImg
                    source: "image://theme/meegotouch-calendar-datepicker-monthgrid-nextbutton"
                    anchors.centerIn: parent
                    mirror: LayoutMirroring.enabled
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        nextButtonImg.source = "image://theme/meegotouch-calendar-datepicker-monthgrid-nextbutton-pressed"
                    }

                    onReleased: {
                        nextButtonImg.source = "image://theme/meegotouch-calendar-datepicker-monthgrid-nextbutton"
                    }

                    onClicked: {
                        var newdate = timegrid.viewDate
                        newdate.setDate(newdate.getDate() + 1)
                        timegrid.viewDate = newdate
                        updateTimes();
                    }
                }
            }

        }
    }
}
