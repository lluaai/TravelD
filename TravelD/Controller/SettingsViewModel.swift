//
//  SettingsViewModel.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 09.04.2024.
//

import Foundation

class SettingsViewModel {
    var settingsItems: [[SettingsItem]] = [
        [
            SettingsItem(title: "101 - Өртсөндіру", value: "On"),
            SettingsItem(title: "102 - Полиция", value: "On"),
            SettingsItem(title: "103 - Жедел жәрдем", value: "Off"),
            SettingsItem(title: "112 - Құтқару қызметі ТЖ", value: "English"),
        ],
        [
            SettingsItem(title: "Демалыс кезінде тыныштықты құрметтеңіз", value: "On"),
            SettingsItem(title: "Кемпинг алаңын таза ұстаңыз", value: "Off"),
            SettingsItem(title: "Табиғатты құрметтеіңіз", value: "50%")
        ]
    ]
}
