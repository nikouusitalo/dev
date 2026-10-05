import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
    id: root

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                id: bar

                property var modelData
                property var hyprMonitor: Hyprland.monitorFor(screen)

                screen: modelData

                anchors {
                    top: true
                    left: true
                    right: true
                }

                implicitHeight: 32
                color: "#111318"

                // Workspacet
                Row {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    spacing: 4

                    Repeater {
                        model: [1, 2, 3, 4, 5]

                        Rectangle {
                            required property int modelData

                            width: 24
                            height: 22
                            radius: 4

                            property bool active:
                                bar.hyprMonitor
                                && bar.hyprMonitor.activeWorkspace
                                && bar.hyprMonitor.activeWorkspace.id === modelData

                            color: active ? "#cdd6f4" : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: modelData

                                color: parent.active
                                    ? "#111318"
                                    : "#cdd6f4"

                                font.pixelSize: 13
                            }

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    Hyprland.dispatch(
                                        "workspace " + parent.modelData
                                    )
                                }
                            }
                        }
                    }
                }

                // Kello
                Text {
                    anchors.centerIn: parent

                    text: Qt.formatDateTime(
                        clock.date,
                        "HH:mm"
                    )

                    color: "#cdd6f4"
                    font.pixelSize: 14
                    font.bold: true
                }

                // Päivämäärä
                Text {
                    anchors {
                        right: parent.right
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    text: Qt.formatDateTime(
                        clock.date,
                        "dd.MM.yyyy"
                    )

                    color: "#a6adc8"
                    font.pixelSize: 13
                }
            }
        }
    }
}
