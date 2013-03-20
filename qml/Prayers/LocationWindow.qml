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
import com.nokia.extras 1.0
import com.nokia.meego 1.0

Page {
    tools: pageTools
    anchors.margins: 10

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property bool selectionMode: true

    function updateLocation()
    {
        var location = {"alphabet": locationEdit.location.title[0].toUpperCase(),
            "title": locationEdit.location.title,
            "subtitle": "",
            "lat": locationEdit.location.lat,
            "long": locationEdit.location.long,
            "elv": locationEdit.location.elv }
        if (locationEdit.index == locationsList.count)
        {
            console.log("Add new location:  " + locationEdit.location.title)
            locationsList.append(location)
            settings.appendToArray("locations", location)
            if (locationsList.count == 1)
                setLocation(location)
        }
        else
        {
            console.log("Update existing location: " + locationEdit.location.title)
            var locname = settings.getValue("main/location")
            if (locationsList.get(locationEdit.index).title === locname)
                settings.setValue("main/location", location.title)
            locationsList.set(locationEdit.index, location)
            settings.setArrayValue("locations", locationEdit.index, location)
        }
    }

    function newLocationWindow()
    {
        locationEdit.index = locationsList.count
        locationEdit.location = { "title": "LocationName",
            "lat": 0.0,
            "long": 0.0,
            "elv": 0.0}
        locationEdit.open();
    }

    function loadLocation()
    {
        var locname = settings.getValue("main/location")
        var locidx = settings.getIndexOfValueInArray("locations", "title", locname);
        if (locidx === -1)
            locidx = 0
        setLocation(locationsList.get(locidx))
    }

    Component.onCompleted:
    {
//        locationsList.append({"alphabet": "I", "title": "Isfahan", "subtitle": "",
//                                 "lat": 32.6729, "long": 51.6666,
//                                 "elv": 0 })
        settings.sortArray("locations")
        var locations = settings.getArray("locations")
        if (locations.length)
        {
            for (var i = 0; i < locations.length; i++)
                locationsList.append(locations[i])
            loadLocation()
        }
        else
            newLocationWindow()
    }

    ListModel {
        id: locationsList
    }

    ListView {
        id: locationsListView
        anchors.fill: parent

        section.property: "alphabet"
        section.criteria: ViewSection.FirstCharacter
        Component {
            id: sectionHeading
            Rectangle {
                width: parent.width
                height: childrenRect.height * 2
                color: "lightsteelblue"

                Text {
                    text: section
                    font.bold: true
                    anchors.centerIn: parent
                }
            }
        }
        section.delegate: sectionHeading

        model: locationsList
        delegate: ListDelegate {
            Component.onCompleted: {
                click_area.clicked.connect(clicked)
            }

            BorderImage {
                id: background
                anchors.fill: parent
                visible: click_area.pressed
                opacity: 0.8
                source: "image://theme/meegotouch-list-background-pressed-center"
            }

            MouseArea {
                id: click_area
                anchors.fill: parent
                onPressAndHold: {
                    removeMenu.open()
                }
            }

            onClicked: {
                if (selectionMode)
                {
                    settings.setValue("main/location", title);
                    setLocation(model);
                    pageStack.pop();
                }
                else
                {
                    locationEdit.index = index
                    locationEdit.location = { "title": title,
                        "lat": lat,
                        "long": model.long,
                        "elv": elv}
                    locationEdit.open()
                }
            }

            Menu {
                id: removeMenu
                visualParent: pageStack
                MenuLayout {
                    MenuItem { text: qsTr("Delete")
                        onClicked: {
                            settings.removeArrayEntry("locations", index)
                            locationsList.remove(index)
                            loadLocation()
                        }
                    }
                }
            }

        }
    }

    SectionScroller {
        listView: locationsListView
    }

    ScrollDecorator {
        flickableItem: locationsListView
    }

    ToolBarLayout {
        id: pageTools
        visible: false
        ToolIcon {
            iconId: "toolbar-back";
            onClicked: pageStack.pop()
        }
        ToolIcon {
            iconId: "toolbar-add";
            onClicked: newLocationWindow()
        }
    }

    LocationEdit {
        id: locationEdit
    }
}
