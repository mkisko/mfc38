//
//  OfficeModel.swift
//  mfc38
//
//  Created by Алексей Усанов on 01/12/2016.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import Foundation
import CoreLocation

class OfficeModel {
    
    let locationManager = CLLocationManager()
    var dist = [Office]()
    var officesDist = [OfficeDist]()
    
    func setDistOffice() {
        if !minDistance()[0].office.isEmpty {
            let str = minDistance()[0].office
            for index in 0..<list.count {
                if list[index].address == str {
                    dist.append(list[index])
                }
            }
        }
    }
    
    private func minDistance() -> [OfficeDist] {
        
        var officeSort:[OfficeDist] = [OfficeDist]()
        for index in 0..<list.count {
            officesDist.append(OfficeDist(office: list[index].address!, dist: dist(latitude: list[index].latitude, longitude: list[index].longitude)))
        }
        
        officeSort = officesDist.sorted { $0.dist < $1.dist}
        
        return officeSort
    }
    
    private func dist(latitude: Double, longitude: Double) -> Double {
        
        var currentLocation = CLLocation()
        
        currentLocation = locationManager.location!
        
        let coor0 = CLLocation(latitude: latitude, longitude: longitude)
        let coor1 = CLLocation(latitude: currentLocation.coordinate.latitude , longitude: currentLocation.coordinate.longitude)
        
        let distanceInMeters = coor0.distance(from: coor1)
        
        return distanceInMeters
    }
    
    var list: [Office] = [
        Office(area: "Ангарск",
               address: "84й квартал, д.16",
               latitude:52.530193,
               longitude:103.872017,
               monday: "09.00 - 19.00",
               tuesday: "09.00 - 20.00",
               wednesday: "09.00 - 19.00",
               thursday: "09.00 - 20.00",
               friday: "09.00 - 19.00",
               saturday: "09.00 - 16.00",
               boss: "Лялина Светлана Александровна",
               busy: "",
               eo: true,
               ik: true,
               atm: true,
               photobootch: false,
               idea2business: true
        ),
        
        Office(area: "Ангарск",
               address: "ул. Ворошилова, д.65",
               latitude:52.523443,
               longitude:103.888043,
               monday: "09.00 - 19.00",
               tuesday: "09.00 - 20.00",
               wednesday: "09.00 - 19.00",
               thursday: "09.00 - 20.00",
               friday: "09.00 - 19.00",
               saturday: "09.00 - 16.00",
               boss: "Николаева Анастасия Владимировна",
               busy: "",
               eo: true,
               ik: true,
               atm: true,
               photobootch: false,
               idea2business: false
        ),
        
        Office(area: "Байкальск",
               address: "мкр Южный, 1й квартал, д.26",
               latitude:51.50688,
               longitude:104.146218,
               monday: "Выходной",
               tuesday: "09.00 - 19.00",
               wednesday: "09.00 - 19.00",
               thursday: "09.00 - 18.00",
               friday: "09.00 - 18.00",
               saturday: "09.00 – 16.00",
               boss: "Былков Сергей Евгеньевич",
               busy: "",
               eo: true,
               ik: true,
               atm: true,
               photobootch: false,
               idea2business: true
        ),
        
        Office(area: "Балаганск",
               address: "ул.Кольцевая, д.61",
               latitude:54.012517,
               longitude:103.05181,
               monday: "09.00 - 18.00",
               tuesday: "09.00 - 18.00",
               wednesday: "09.00 - 18.00",
               thursday: "09.00 - 18.00",
               friday: "09.00 - 18.00",
               saturday: "10.00 - 12.00",
               boss: "Иванова Инга Александровна",
               busy: "",
               eo: true,
               ik: false,
               atm: false,
               photobootch: false,
               idea2business: false
        ),
        
        Office(area: "Баяндай",
               address: "ул. Некунде, д.131",
               latitude:53.056766,
               longitude:105.504345,
               monday: "Выходной",
               tuesday: "09.00 - 19.00",
               wednesday: "09.00 - 19.00",
               thursday: "09.00 - 18.00",
               friday: "09.00 - 18.00",
               saturday: "09.00 – 16.00",
               boss: "Батомункуев Балдан Жалсанович",
               busy: "",
               eo: true,
               ik: true,
               atm: true,
               photobootch: false,
               idea2business: false
        ),
        
        Office(area: "Бодайбо",
               address: "ул.Урицкого, д.15",
               latitude:57.846673,
               longitude:114.195348,
               monday: "Выходной",
               tuesday: "09.00 - 18.00",
               wednesday: "09.00 - 18.00",
               thursday: "09.00 - 18.00",
               friday: "09.00 - 18.00",
               saturday: "09.00 - 15.00",
               boss: "Абаева Ольга Геннадьевна",
               busy: "",
               eo: true,
               ik: false,
               atm: true,
               photobootch: false,
               idea2business: true
        ),
        
        Office(area: "Бохан", address: "ул. Колхозная, д.7", latitude:53.157165, longitude:103.786982, monday: "Выходной", tuesday: "09.00 - 19.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 – 16.00", boss: "Зверев Сергей Александрович", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Братск", address: "пр-т Ленина, д.37", latitude:56.152069, longitude:101.632094, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Ширин Андрей Геннадьевич", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Братск", address: "ул. Баркова, д.43", latitude:56.154951, longitude:101.587035, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Татарникова Ирина Владимировна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Братск", address: "ул.Юбилейная, д.15", latitude:56.316549, longitude:101.752945, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 19.00", friday: "09.00 - 19.00", saturday: "10.00 - 14.00", boss: "Маркова Юлия Александровна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Вихоревка", address: "ул. Дзержинского д.66 б", latitude:56.122371, longitude:101.168627, monday: "Выходной", tuesday: "09.00 - 19.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 16.00", boss: "Короткевич Надежда Александровна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Еланцы", address: "ул. Ленина, д.48", latitude:52.795685, longitude:106.40187, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Багинова Светлана Максимовна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Ербогачен", address: "ул. Чкалова,  д.11", latitude:61.275731, longitude:108.008812, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Инешина Наталья Викторовна", busy: "", eo:false, ik: false, atm: false, photobootch: false, idea2business: false),
        
        Office(area: "Железногорск-Илимский", address: "ул. Янгеля, д.12", latitude:56.587059, longitude:104.11484, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Чернова Яна Александровна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Жигалово", address: "ул. Партизанская, д.71", latitude:54.813103, longitude:105.150819, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Шипицина Светлана Валерьевна", busy: "", eo: true, ik: true, atm: false, photobootch: false, idea2business: false),
        
        Office(area: "Залари", address: "ул. Гагарина, д.4", latitude:53.554149, longitude:102.489617, monday: "Выходной", tuesday: "09.00 - 19.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 – 16.00", boss: "Китаев Алексей Андреевич", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Зима", address: "ул. Клименко, д.37", latitude:53.920041, longitude:102.049272, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 19.00", friday: "09.00 - 19.00", saturday: "10.00 - 14.00", boss: "Гусева Светлана Владимировна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Иркутск", address: "ул. Трактовая, д.35", latitude:52.329683, longitude:104.211820, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Костина Наталья Анатольевна", busy: "", eo: true, ik: true, atm: true, photobootch: true, idea2business: true),
        
        Office(area: "Иркутск", address: "ул. Декабрьских Событий, д.117", latitude:52.280371, longitude:104.316764, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Парыгин Александр Александрович", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Иркутск", address: "ул. Клары Цеткин, 12/1", latitude:52.277358, longitude:104.253837, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Старикова Елена Николаевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Иркутск", address: "ул. Байкальская, д.340/1", latitude:52.252863, longitude:104.359919, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Камаева Светлана Юрьевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Иркутск", address: "б. Рябикова, д.22А", latitude:52.267427, longitude:104.209828, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 19.00", friday: "09.00 - 19.00", saturday: "10.00 - 14.00", boss: "Чуднова Анна Викторовна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Иркутск", address: "мкрн Юбилейный, д.19/1", latitude:52.227534, longitude:104.304025, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Олзоева Вера Михайловна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Иркутск", address: "ул. Верхняя Набережная, д.10", latitude:52.267653, longitude:104.28914, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 19.00", friday: "09.00 - 19.00", saturday: "10.00 - 14.00", boss: "Шалашова Светлана Владимировна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Качуг", address: "ул. Красной Звезды, д.1", latitude:53.96047, longitude:105.880021, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Бизимова Марина Валерьевна", busy: "", eo: true, ik: true, atm: false, photobootch: false, idea2business: false),
        
        Office(area: "Киренск", address: "ул. Красноармейская, д.2А", latitude:57.77734, longitude:108.11087, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Прокопьева Елена Васильевна", busy: "", eo: true, ik: false, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Куйтун", address: "ул. Красного Октября, д.18", latitude:44.428675, longitude:84.900056, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Высотина Ирина Владимировна", busy: "", eo: true, ik: false, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Кутулик", address: "ул. Советская, д.83", latitude:53.353993, longitude:102.781911, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Шаракшинова Светлана Чингисовна", busy: "", eo: true, ik: false, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Магистральный", address: "ул. 17-го съезда ВЛКСМ, д.70", latitude:56.169839, longitude:107.438804, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Никонович Яна Александровна", busy: "", eo: true, ik: false, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Мама", address: "ул. Октябрьская, д.23", latitude:58.308093, longitude:112.90596, monday: "Выходной", tuesday: "09.00 - 19.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 – 16.00", boss: "Доманюк Владимир Анатольевич", busy: "", eo: true, ik: false, atm: false, photobootch: false, idea2business: true),
        
        Office(area: "Нижнеудинск", address: "ул.Октябрьская, д.1-2", latitude:54.90688, longitude:99.046348, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Шелкова Елена Васильевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Новонукутский", address: "ул. Хангалова, д.2А", latitude:53.701705, longitude:102.703749, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Иванова Инга Александровна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Оса", address: "ул. Чапаева, д.2В/2", latitude:57.274461, longitude:55.451008, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Зверев Сергей Александрович", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Саянск", address: "мкрн Строителей, д.26", latitude:54.117613, longitude:102.174542, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Квятковская Наталья Николаевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Свирск", address: "ул. Молодежная, д.1А", latitude:53.067048, longitude:103.345002, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Богданова Наталья Валерьевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Слюдянка", address: "ул. Магистральная, д.2", latitude:51.66616, longitude:103.692695, monday: "Выходной", tuesday: "09.00 - 19.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 – 16.00", boss: "Былков Сергей Евгеньевич", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Тайшет", address: "ул. Транспортная, д.19Н", latitude:55.94023, longitude:98.004796, monday: "09.00 - 19.00", tuesday: "09.00 - 19.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 19.00", friday: "09.00 - 19.00", saturday: "10.00 - 15.00", boss: "Баймашкина Елена Владимировна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Тулун", address: "ул.Ленина, д.83", latitude:54.559788, longitude:100.578559, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Назарова Наталья Николаевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Усолье-Сибирское", address: "пр-т Комсомольский, д.130", latitude:52.735028, longitude:103.661128, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Шипицына Ольга Николаевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: true),
        
        Office(area: "Усть-Илимск", address: "ул. Мира, д.9", latitude:58.051679, longitude:102.733528, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Ларина Ольга Васильевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Усть-Кут", address: "ул. Хорошилова, д.2А", latitude:56.792878, longitude:105.775672, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 19.00", friday: "09.00 - 19.00", saturday: "10.00 - 14.00", boss: "Николаева Алена Анатольевна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Усть-Ордынский", address: "ул. Ленина, д.8", latitude:52.802845, longitude:104.757109, monday: "Выходной", tuesday: "09.00 - 19.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 – 16.00", boss: "Кузьмин Николай Александрович", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Усть-Уда", address: "ул. 50 лет Октября, д.22А", latitude:54.175034, longitude:103.022749, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Зверев Сергей Александрович", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Черемхово", address: "ул. Некрасова, д.17", latitude:53.138424, longitude:103.093779, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Шевская Елена Борисовна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Чунский", address: "ул. Гоголя, д.3", latitude:56.086294, longitude:99.651687, monday: "Выходной", tuesday: "09.00 - 18.00", wednesday: "09.00 - 18.00", thursday: "09.00 - 18.00", friday: "09.00 - 18.00", saturday: "09.00 - 15.00", boss: "Агафонов Сергей Миронович", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        
        Office(area: "Шелехов", address: "1й квартал, д.10", latitude:52.213426, longitude:104.098922, monday: "09.00 - 19.00", tuesday: "09.00 - 20.00", wednesday: "09.00 - 19.00", thursday: "09.00 - 20.00", friday: "09.00 - 19.00", saturday: "09.00 - 16.00", boss: "Заковряжина Наталья Викторовна", busy: "", eo: true, ik: true, atm: true, photobootch: false, idea2business: false),
        ]
}
