//
//  VKAPIMainClass.swift
//  VKClient
//
//  Created by Lev on 4/14/21.
//

import Foundation
import Alamofire

class VKAPIMainClass {
    
    static func getFriends() {
        let host = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "user_id": Session.shared.userId,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        let url = host + path
        
        /*
        Optional({
            response =     {
                count = 11;
                items =         (
                    24455564,
                    127479583,
                    144274054,
                    159648682,
                    173696429,
                    208775656,
                    222970160,
                    312798788,
                    336387203,
                    495877799,
                    560189260
                );
            };
        })
         */
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.value else { return }
            
            print(data)
        }
    }
    
    static func getGroups() {
        let host = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "user_id": Session.shared.userId,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        let url = host + path
        
        /*
         Optional({
             response =     {
                 count = 178;
                 items =         (
                     49093503,
                     120254617,
                     115218091,
                     144140142,
                     6437840,
                     158316485,
                     144198820,
                     66687279,
                     135665153,
                     19977823,
                     128637780,
                     159333001,
                     129440544,
                     119737845,
                     113307295,
                     153165581,
                     29534144,
                     125004421,
                     144822899,
                     113851128,
                     178132902,
                     115139036,
                     105865149,
                     146731675,
                     95648824,
                     157815643,
                     142149689,
                     154214347,
                     64367994,
                     97845125,
                     165586938,
                     180124438,
                     78346894,
                     190308576,
                     72340584,
                     50241634,
                     141694923,
                     142629138,
                     25336774,
                     159708114,
                     142108710,
                     173149228,
                     83563810,
                     93816930,
                     126196919,
                     183766360,
                     142764736,
                     92656044,
                     23783820,
                     84065439,
                     22822305,
                     777107,
                     44554509,
                     147286578,
                     114454317,
                     55072656,
                     40766820,
                     120944973,
                     154306815,
                     101965347,
                     38818986,
                     170172287,
                     120508713,
                     62908398,
                     84648738,
                     97882810,
                     59954227,
                     165522634,
                     64735298,
                     104064558,
                     121069793,
                     120944550,
                     91524596,
                     51855473,
                     130074765,
                     60919436,
                     170240710,
                     49290676,
                     127532800,
                     144355172,
                     90500554,
                     72000629,
                     92286993,
                     54218032,
                     146794235,
                     73127371,
                     148475723,
                     26433426,
                     134678887,
                     51045852,
                     191097210,
                     41043303,
                     138011606,
                     57815755,
                     183108617,
                     1773864,
                     169016568,
                     115668604,
                     61736602,
                     134109933,
                     61195360,
                     95191641,
                     159027938,
                     8654241,
                     13987882,
                     114653874,
                     95863624,
                     24125843,
                     72133851,
                     79047492,
                     39092148,
                     114363724,
                     166739948,
                     32738716,
                     62018604,
                     132155763,
                     144950704,
                     93797540,
                     47167593,
                     167479002,
                     82667619,
                     49460592,
                     151918416,
                     149970827,
                     155829034,
                     58950918,
                     113991069,
                     85464109,
                     63873859,
                     88039223,
                     166948745,
                     149810565,
                     50457797,
                     95233511,
                     185980261,
                     129619326,
                     78047820,
                     167000967,
                     109364466,
                     187225629,
                     65888967,
                     145732370,
                     118703910,
                     167852174,
                     188679689,
                     65818757,
                     132612988,
                     115395691,
                     107963504,
                     121504041,
                     164563864,
                     40954278,
                     178143116,
                     143470371,
                     168776471,
                     85272744,
                     169619550,
                     118791737,
                     158896415,
                     168602826,
                     165030788,
                     128642443,
                     149117021,
                     2038990,
                     171351769,
                     177812702,
                     174639587,
                     172521363,
                     166560623,
                     170309068,
                     172401100,
                     172682270,
                     139448114,
                     169816922,
                     171504649,
                     153678471,
                     96069473,
                     100327861
                 );
             };
         })
         */
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value as Any)
        }
    }
    
    static func getPhotos(completion: @escaping ([Item]) -> Void) {
        let host = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let version = "5.130"
        
        let parameters: Parameters = [
            "owner_id": Session.shared.userId,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        AF.request(host + path, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.value else { return }
            
            var rawPhotos = [Item]()
            
            do {
                rawPhotos = try JSONDecoder().decode(PhotoModel.self, from: data).response.items
                print("from vkapimainclass: ", rawPhotos)
            } catch {
                print(error)
            }
            
            completion(rawPhotos)
        }
        
        
    }
    
}
