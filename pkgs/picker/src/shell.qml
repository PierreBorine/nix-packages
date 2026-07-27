import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
	Variants {
		model: Quickshell.screens

		PanelWindow {
			property var modelData
			screen: modelData

			exclusionMode: ExclusionMode.Ignore
			WlrLayershell.namespace: "qs-wallpaper-picker"
			WlrLayershell.layer: WlrLayer.Top
			WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

			implicitHeight: 500
			color: "transparent"

			anchors.left: true
			anchors.right: true

			Shortcut { sequence: "Escape"; onActivated: Qt.quit() }
			Shortcut { sequence: "q"; onActivated: Qt.quit() }

			Picker {
				anchors.fill: parent
			}
		}
	}
}
