//
//  ChatViewController.swift
//  mfc38
//
//  Created by Алексей Усанов on 29.12.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import UIKit
import YandexMobileMetrica

class ChatViewController: UIViewController, JivoDelegate {
    
    @IBOutlet weak var jivoWebView: UIWebView!
    var jivo = JivoSdk()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YMMYandexMetrica.reportEvent("Открытие чата") { (error) in
        }
        
        jivo = JivoSdk(jivoWebView, "ru")
        jivo.delegate = self
        jivo.prepare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jivo.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        jivo.stop()
    }

    //ответы от сервера чата
    func onEvent(_ name: String!, _ data: String!) {
        print("event: \(name!) + \(data!)")
        
        switch name {
        case "agent.set"://изменился оператор
            self.navigationItem.title = data
        case "agent.message"://получено сообщение
            print()
        case "connection.connect"://установлено соединение
            print()
          //  self.navigationItem.title = "Онлайн"
        case "connection.disconnect"://соединение откючено
            print()
            //self.navigationItem.title = "Оффлайн"
        case "connection.error"://ошибки при подключении
            print()
        case "connection.force_offline"://чат сервер разорвал соединение, некому ответить
            print()
        case "connection.startup_ok"://установлено подключение с сервером
            print()
        case "connection.accep’t"://оператор принял чат
            print()
        case "connection.transferred"://оператор передал чат
            print()
        default:
            print()
        }
    }
}
