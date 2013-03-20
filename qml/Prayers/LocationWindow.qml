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
        if (locationEdit.index == locationsList.count)
        {
            console.log("Add new location:  " + locationEdit.location.title)
            locationsList.append({"alphabet": locationEdit.location.title[0].toUpperCase(),
                                     "title": locationEdit.location.title,
                                     "subtitle": "",
                                     "lat": locationEdit.location.lat,
                                     "long": locationEdit.location.long,
                                     "elv": locationEdit.location.elv })
        }
        else
        {
            console.log("Update existing location: " + locationEdit.location.title)
            locationsList.set(locationEdit.index, {"alphabet": locationEdit.location.title[0].toUpperCase(),
                                     "title": locationEdit.location.title,
                                     "subtitle": "",
                                     "lat": locationEdit.location.lat,
                                     "long": locationEdit.location.long,
                                     "elv": locationEdit.location.elv })
        }
    }

    Component.onCompleted:
    {
        locationsList.append({"alphabet": "I", "title": "Isfahan", "subtitle": "",
                                 "lat": 32.6729, "long": 51.6666,
                                 "elv": 0 })
        setLocation(locationsList.get(0))
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
                    setLocation(model);
                    pageStack.pop();
                }
                else
                {
                    locationEdit.index = index
                    locationEdit.location = { "title": locationsList.get(index).title,
                        "lat": locationsList.get(index).lat,
                        "long": locationsList.get(index).long,
                        "elv": locationsList.get(index).elv}
                    locationEdit.open()
                }
            }

            Menu {
                id: removeMenu
                visualParent: pageStack
                MenuLayout {
                    MenuItem { text: qsTr("Delete")
                        onClicked: {
                            locationsList.remove(index)
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
            onClicked: { pageStack.pop(); }
        }
        ToolIcon {
            iconId: "toolbar-add";
            onClicked: {
                locationEdit.index = locationsList.count
                locationEdit.location = { "title": "LocationName",
                    "lat": 0.0,
                    "long": 0.0,
                    "elv": 0.0}
                locationEdit.open();
            }
        }
    }

    LocationEdit {
        id: locationEdit
    }

}
