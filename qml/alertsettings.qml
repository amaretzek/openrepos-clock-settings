import QtQuick 2.0
import Sailfish.Silica 1.0
import openrepos.alert.settings 1.0

Page {
    id: page

    property alias applicationName: header.title

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column

            width: parent.width

            PageHeader {
                id: header

                //: Page header and settings menu entry
                //% "Alerts"
                title: qsTrId("openrepos_alert_settings-he-title")
            }

            AppSectionHeader {
                //: Clock settings section header
                //% "Clock"
                name: qsTrId("openrepos_alert_settings-se-clock")
                icon: "image://theme/icon-launcher-clock"
            }

            Slider {
                width: parent.width
                visible: opacity > 0
                opacity: clockSnooze.snoozeQueryFinished ? 1 : 0
                Behavior on opacity { FadeAnimation {} }
                minimumValue: SnoozeSettings.SnoozeMin
                maximumValue: SnoozeSettings.SnoozeMax
                stepSize: SnoozeSettings.SnoozeStep
                //: Minutes (shortened)
                //% "min"
                valueText: value/60 + " " + qsTrId("openrepos_alert_settings-la-min")
                //: Slider label (clock snooze)
                //% "Snooze interval"
                label: qsTrId("openrepos_alert_settings-la-clock_snooze")
                value: clockSnooze.snooze
                onSliderValueChanged: clockSnooze.snooze = value

                SnoozeSettings {
                    id: clockSnooze

                    application: "nemoalarms"
                }
            }

            Slider {
                id: clockVolumeSlider

                width: parent.width
                visible: opacity > 0
                opacity: (clockSnooze.snoozeQueryFinished && clockVolume.volumeQueryFinished) ? 1 : 0
                Behavior on opacity { FadeAnimation {} }
                minimumValue: VolumeSettings.VolumeMin
                maximumValue: VolumeSettings.VolumeMax
                stepSize: VolumeSettings.VolumeStep
                valueText: value
                //: Slider label (clock alarm)
                //% "Alarm volume"
                label: qsTrId("openrepos_alert_settings-la-clock_volume")
                value: clockVolume.volume
                onSliderValueChanged: clockVolume.volume = value

                VolumeSettings {
                    id: clockVolume

                    alarmEvent: "clock"
                    volumeKey: "clock.alert.volume"
                    alarmPlaying: clockVolumeSlider.down
                }
            }

            AppSectionHeader {
                //: Calendar settings section header
                //% "Calendar"
                name: qsTrId("openrepos_alert_settings-se-calendar")
                icon: "image://theme/icon-launcher-calendar"
            }

            Slider {
                width: parent.width
                visible: opacity > 0
                opacity: calendarSnooze.snoozeQueryFinished ? 1 : 0
                Behavior on opacity { FadeAnimation {} }
                minimumValue: SnoozeSettings.SnoozeMin
                maximumValue: SnoozeSettings.SnoozeMax
                stepSize: SnoozeSettings.SnoozeStep
                //: Minutes (shortened)
                //% "min"
                valueText: value/60 + " " + qsTrId("openrepos_alert_settings-la-min")
                //: Slider label (repeat interval for calendar alerts)
                //% "Repeat interval"
                label: qsTrId("openrepos_alert_settings-la-calendar_snooze")
                value: calendarSnooze.snooze
                onSliderValueChanged: calendarSnooze.snooze = value

                SnoozeSettings {
                    id: calendarSnooze

                    application: "libextendedkcal"
                }
            }

            Slider {
                id: calendarVolumeSlider

                width: parent.width
                visible: opacity > 0
                opacity: (calendarSnooze.snoozeQueryFinished && calendarVolume.volumeQueryFinished) ? 1 : 0
                Behavior on opacity { FadeAnimation {} }
                minimumValue: VolumeSettings.VolumeMin
                maximumValue: VolumeSettings.VolumeMax
                stepSize: VolumeSettings.VolumeStep
                valueText: value
                //: Slider label (calendar alert)
                //% "Alert volume"
                label: qsTrId("openrepos_alert_settings-la-calendar_volume")
                value: calendarVolume.volume
                onSliderValueChanged: calendarVolume.volume = value

                VolumeSettings {
                    id: calendarVolume

                    alarmEvent: "calendar"
                    volumeKey: "calendar.alert.volume"
                    alarmPlaying: calendarVolumeSlider.down
                }
            }
        }
    }
}
