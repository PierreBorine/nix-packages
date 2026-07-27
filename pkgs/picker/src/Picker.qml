import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Io

Item {
	id: window

	property int targetWallIndex: 0
	property bool initialFocusSet: false

	function tryFocus() {
		if (!initialFocusSet) {
			// Wait until the model has loaded enough items to actually reach our target
			if (view.count > targetWallIndex) {
				view.currentIndex = targetWallIndex;
				view.positionViewAtIndex(targetWallIndex, ListView.Center);
				initialFocusSet = true;
			} else if (folderModel.status === FolderListModel.Ready && view.count > 0) {
				// Fallback: If the folder completely finished loading but the index is somehow out of bounds
				let safeIndex = Math.max(0, view.count - 1);
				view.currentIndex = safeIndex;
				view.positionViewAtIndex(safeIndex, ListView.Center);
				initialFocusSet = true;
			}
		}
	}

	readonly property string homeDir: "file://" + Quickshell.env("HOME")
	readonly property string thumbDir: homeDir + "/.cache/wallpaper_picker/thumbs"
	readonly property string srcDir: Quickshell.env("HOME") + "/Pictures/Wallpapers"

	readonly property string awwwCommand: "awww img '%1' --transition-type %2 --transition-pos 0.5,0.5 --transition-fps 144 --transition-duration 1"

	readonly property var transitions: ["grow", "outer", "any", "wipe", "wave", "center"]

	readonly property int itemWidth: 300
	readonly property int itemHeight: 420
	readonly property int borderWidth: 3
	readonly property int spacing: 0
	readonly property real skewFactor: -0.35

	Shortcut { sequence: "Left"; onActivated: view.decrementCurrentIndex() }
	Shortcut { sequence: "h"; onActivated: view.decrementCurrentIndex() }
	Shortcut { sequence: "Right"; onActivated: view.incrementCurrentIndex() }
	Shortcut { sequence: "l"; onActivated: view.incrementCurrentIndex() }
	Shortcut { sequence: "Return"; onActivated: { if (view.currentItem) view.currentItem.pickWallpaper() } }

	// -------------------------------------------------------------------------
	// CONTENT
	// -------------------------------------------------------------------------
	ListView {
		id: view
		anchors.fill: parent
		anchors.margins: 0

		spacing: window.spacing
		orientation: ListView.Horizontal
		clip: false

		// Pre-load items off-screen so they don't block the thread as they enter the view
		cacheBuffer: 2000

		highlightRangeMode: ListView.StrictlyEnforceRange
		preferredHighlightBegin: (width / 2) - (window.itemWidth / 2)
		preferredHighlightEnd: (width / 2) + (window.itemWidth / 2)

		// Reset back to standard speed for snappy manual keyboard navigation
		highlightMoveDuration: window.initialFocusSet ? 300 : 0

		focus: true

		onCountChanged: window.tryFocus()

		model: FolderListModel {
			id: folderModel
			folder: window.thumbDir
			nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp", "*.gif"]
			showDirs: false
			sortField: FolderListModel.Name

			// Re-check focus when the model's loading status updates
			onStatusChanged: window.tryFocus()
		}

		delegate: Item {
			id: delegateRoot
			implicitWidth: window.itemWidth
			implicitHeight: window.itemHeight
			anchors.verticalCenter: parent.verticalCenter

			readonly property bool isCurrent: ListView.isCurrentItem

			z: isCurrent ? 10 : 1

			function pickWallpaper() {
				const originalFile = window.srcDir + "/" + fileName

				const randomTransition = window.transitions[Math.floor(Math.random() * window.transitions.length)]
				const finalCmd = window.awwwCommand.arg(originalFile).arg(randomTransition)
				Quickshell.execDetached(["sh", "-c", finalCmd])
				Qt.quit()
			}

			MouseArea {
				anchors.fill: parent
				onClicked: {
					view.currentIndex = index
					delegateRoot.pickWallpaper()
				}
			}

			Item {
				anchors.centerIn: parent
				implicitWidth: parent.implicitWidth
				implicitHeight: parent.implicitHeight

				scale: delegateRoot.isCurrent ? 1.15 : 0.95
				opacity: delegateRoot.isCurrent ? 1.0 : 0.6

				Behavior on scale { NumberAnimation { duration: 500; easing.type: Easing.OutBack } }
				Behavior on opacity { NumberAnimation { duration: 500 } }

				transform: Matrix4x4 {
					property real s: window.skewFactor
					matrix: Qt.matrix4x4(1, s, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
				}

				Image {
					anchors.fill: parent
					source: fileUrl
					sourceSize: Qt.size(1, 1)
					fillMode: Image.Stretch
					visible: true

					// Load from disk on a background thread to prevent UI freezing
					asynchronous: true
				}

				Item {
					anchors.fill: parent
					anchors.margins: window.borderWidth

					Rectangle { anchors.fill: parent; color: "black" }
					clip: true

					Image {
						anchors.centerIn: parent
						anchors.horizontalCenterOffset: -50

						width: parent.width + (parent.height * Math.abs(window.skewFactor)) + 50
						height: parent.height

						fillMode: Image.PreserveAspectCrop
						source: fileUrl

						// Load from disk on a background thread to prevent UI freezing
						asynchronous: true

						transform: Matrix4x4 {
							property real s: -window.skewFactor
							matrix: Qt.matrix4x4(1, s, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
						}
					}
				}
			}
		}
	}

	Component.onCompleted: {
		getWallpaperTarget.running = true
		view.forceActiveFocus();
	}

	Process {
		id: getWallpaperTarget
		command: ["sh", "-c", "[ -f /tmp/wallpaper_picker_target ] && cat /tmp/wallpaper_picker_target"]
		stdout: StdioCollector {
			onStreamFinished: {
				let raw = this.text.trim();

				let idx = parseInt(raw);
				if (!isNaN(idx)) {
					window.targetWallIndex = idx;
					window.initialFocusSet = false
					tryFocus();
				}
			}
		}
	}
}
