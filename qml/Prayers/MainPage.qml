/*
 *  Prayers, islamic prayer time application
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
import com.nokia.meego 1.0
import 'PrayTimes.js' as PrayTimes

Page {
    tools: commonTools
    anchors.margins: 10

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property variant currentLocation: {"title": ""}
    function updateTimes()
    {
        var date = timegrid.viewDate;
        var times = PrayTimes.prayTimes.getTimes(date,
                        [currentLocation.lat, currentLocation.long, currentLocation.elv])
        var base_hack_str = "August 18, 2012 "
        var i=0
        for (var vaght in times)
        {
            if (vaght === "imsak") continue;
            timelist.setProperty(i++, "time", Qt.formatTime(new Date(base_hack_str + times[vaght])));
        }
    }

    function setLocation(location)
    {
        currentLocation = location
        locationButton.text = location.title
        updateTimes()
    }

    Component.onCompleted:
    {
        // params: Method, coords: lat.long.elv
        PrayTimes.prayTimes.setMethod('Tehran')
        var date = new Date(); // today
        var times = PrayTimes.prayTimes.getTimes(date, [32.6729, 51.6666])
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
        spacing: 10

        Item {
            id: titleRec
            height: titleText.height
            width: parent.width
            Text {
                font.bold: true
                font.pixelSize: 24
                anchors.centerIn: parent
                id: titleText
                text: Qt.formatDate(timegrid.viewDate, Qt.DefaultLocaleLongDate)
            }
        }

        LocationWindow {
            id: locationWindow
        }

        ToolButton {
            id: locationButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            text: "Isfahan"
            onClicked: {
                locationWindow.selectionMode = true;
                pageStack.push(locationWindow)
            }
        }

        Row {
            width: parent.width
            height: parent.height - titleRec.height
            spacing: 10

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
                width: parent.width - 2 * (prevButton.width + parent.spacing)
                height: parent.height - 30
                model: timelist
                clip: true
                cellWidth: width > 500 ? width / 2 : width
                cellHeight: 80
                property date viewDate: "2000-01-01"

                delegate:
                    Rectangle {
                    width: timegrid.cellWidth - 10
                    height: timegrid.cellHeight - 10
                    radius: 30
                    smooth: true
                    border.color: "gray"
                    border.width: 1
                    Row {
                        anchors.fill: parent
                        Text {
                            width: timegrid.cellWidth / 2
                            font.bold: true
                            font.pixelSize: 24
                            text: title
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            width: timegrid.cellWidth / 2
                            font.bold: true
                            font.pixelSize: 24
                            text: time
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
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

    ToolBarLayout {
        id: commonTools
        visible: true
        ToolIcon {
            iconId: "toolbar-view-menu"
//            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open()
                                                               : myMenu.close()
        }
//        ToolIcon {
//            iconId: "toolbar-grid"
////            platformIconId: "toolbar-grid"
////            anchors.right: menutool.left
////            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
//        }
//        ToolIcon {
//            iconId: "toolbar-list"
//        }
    }

    QueryDialog {
        id: aboutDialog

        icon: "qrc:///Prayers.png"
        titleText: qsTr("About Prayers 1.0")
        message: qsTr("Copyright (C) 2013 <br/><br/>    \
            <b>Hedayat Vatankhah</b>  <br/><br/>        \
            License: GNU GPLv3+<br/><br/>               \
            Thanks to: PrayerTimes <br/>                 \
            http://praytimes.org<br/><br/>              \
            This program comes with ABSOLUTELY NO WARRANTY. \
            This is free software, and you are welcome to redistribute it   \
            under terms of GNU GPL version 3 (or later). <br/>  \
                http://www.gnu.org/licenses/")
        acceptButtonText: "OK"
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem { text: qsTr("Locations")
                onClicked: {
                    locationWindow.selectionMode = false;
                    pageStack.push(locationWindow)
                }
            }
            MenuItem { text: qsTr("About")
                onClicked: {
                    aboutDialog.open()
                }
            }
        }
    }

}
