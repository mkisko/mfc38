//
//  urlConstraints.swift
//  mfc38
//
//  Created by Алексей Усанов on 22.09.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import Foundation

class urlConstraints {
    let getServiceList: String = "http://mfc38.ru/index.php?option=com_mfc_services&section=api&space=list_services"
    let getServiceType: String = "http://mfc38.ru/index.php?option=com_mfc_services&section=api&space=tree_types"
    let checkStatus: String = "http://mfc38.ru/index.php?option=com_mfc_status&view=api&num="
    let getNews: String = "http://mfc38.ru/information-service/news?format=feed&type=rss"
    let getTechicalWorks: String = "http://mfc38.ru/information-service/tekhnicheskie-raboty?format=feed&type=rss"
    let coreURL: String = "http://public-preregistration.mfc38.ru:732/API/"
    let getOffice: String = "http://mfc38.ru/tsentry-i-ofisy?section=api&space=location_list"
}


class stringConstraints {
    let reachabillty: String = " Нет сети. Возможности ограничены."
    let warning: String = "Внимание"
    let youAreReady = "Вы действительно хотите очистить информацию об услугах?"
    let yes = "Да"
    let no = "Нет"
    let Description = "Описание"
    let loadNeed = "Для просмотра информации об услугах требуется загрузка данных.\nЭто займёт меньше минуты"
    let networkNeed = "Для загрузки услуг требуется подключение к интернету"
    let good = "Хорошо"
    let later = "В другой раз"
}
