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
import com.nokia.extras 1.0
import com.nokia.meego 1.0

Page {
    id: root

    property string method: buttons.checkedButton.m

    tools: backTools
    anchors.margins: 10

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    Component.onCompleted: {
        var saved_method = settings.getValue("main/calculation_method")
        switch (saved_method)
        {
            case "MWL":
                buttons.checkedButton = butMWL
                break;
            case "ISNA":
                buttons.checkedButton = butISNA
                break;
            case "Egypt":
                buttons.checkedButton = butEgypt
                break;
            case "Makkah":
                buttons.checkedButton = butMakkah
                break;
            case "Karachi":
                buttons.checkedButton = butKarachi
                break;
            case "Tehran":
                buttons.checkedButton = butTehran
                break;
            case "Jafari":
                buttons.checkedButton = butJafari
                break;
            default:
                buttons.checkedButton = butTehran
        }
    }

    ButtonColumn {
        id: buttons
        anchors.fill: parent

        Button {
            id: butMWL
            property string m: "MWL"
            text: qsTr('Muslim World League')
        }
        Button {
            id: butISNA
            property string m: "ISNA"
            text: qsTr('Islamic Society of North America (ISNA)')
        }
        Button {
            id: butEgypt
            property string m: "Egypt"
            text: qsTr('Egyptian General Authority of Survey')
        }
        Button {
            id: butMakkah
            property string m: "Makkah"
            text: qsTr('Umm Al-Qura University, Makkah')
        }
        Button {
            id: butKarachi
            property string m: "Karachi"
            text: qsTr('University of Islamic Sciences, Karachi')
        }
        Button {
            id: butTehran
            property string m: "Tehran"
            text: qsTr('University of Tehran')
        }
        Button {
            id: butJafari
            property string m: "Jafari"
            text: qsTr('Shia Ithna-Ashari, Leva Institute, Qum')
        }
    }

    ToolBarLayout {
        id: backTools
        visible: false
        ToolIcon {
            iconId: "toolbar-back";
            onClicked: {
                settings.setValue("main/calculation_method", method)
                pageStack.pop()
            }
        }
    }
}
