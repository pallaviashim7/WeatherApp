//
//  ViewModelTests.swift
//  WeatherAppTests
//
//  Created by Pallavi Ashim on 9/13/24.
//

import XCTest
import Combine
import CoreLocation
@testable import WeatherApp

final class ViewModelTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testGetLocationInfo() {
        let serviceProvider = getMockServiceProvider()
        let viewModel = MainViewModel(serviceManager: serviceProvider)
        viewModel.location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        viewModel.getWeatherDataUsingSearchText("dallas")
        XCTAssertTrue(viewModel.viewstate.description() == "loaded")
    }
    
    func testGetLocationInfoFailureCase1() {
        let serviceProvider = getMockServiceProvider()
        let viewModel = MainViewModel(serviceManager: serviceProvider)
        viewModel.location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        viewModel.getWeatherDataUsingSearchText("")
        XCTAssertTrue(viewModel.viewstate.description() == "error")
    }
    
    func testGetLocationInfoFailureCase2() {
        let serviceProvider = getMockServiceProvider()
        let viewModel = MainViewModel(serviceManager: serviceProvider)
        viewModel.getWeatherDataUsingSearchText("dallas")
        XCTAssertTrue(viewModel.viewstate.description() == "error")
    }
    
    
    func getMockServiceProvider() -> MockServiceProvider {
        return MockServiceProvider(weatherDataString: "{\"coord\":{\"lon\":-122.4064,\"lat\":37.7858},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clearsky\",\"icon\":\"01d\"}],\"base\":\"stations\",\"main\":{\"temp\":294.95,\"feels_like\":294.8,\"temp_min\":291.64,\"temp_max\":299.17,\"pressure\":1009,\"humidity\":62,\"sea_level\":1009,\"grnd_level\":1005},\"visibility\":10000,\"wind\":{\"speed\":7.2,\"deg\":310},\"clouds\":{\"all\":0},\"dt\":1726175858,\"sys\":{\"type\":2,\"id\":2007646,\"country\":\"US\",\"sunrise\":1726148973,\"sunset\":1726194127},\"timezone\":-25200,\"id\":5391959,\"name\":\"SanFrancisco\",\"cod\":200}",
                                   locationDataString: "[{\"name\":\"London\",\"local_names\":{\"su\":\"London\",\"tw\":\"London\",\"gu\":\"લંડન\",\"is\":\"London\",\"bg\":\"Лондон\",\"mk\":\"Лондон\",\"qu\":\"London\",\"sq\":\"Londra\",\"mi\":\"Rānana\",\"no\":\"London\",\"it\":\"Londra\",\"ml\":\"ലണ്ടൻ\",\"oc\":\"Londres\",\"or\":\"ଲଣ୍ଡନ\",\"fa\":\"لندن\",\"tg\":\"Лондон\",\"feature_name\":\"London\",\"sd\":\"لنڊن\",\"ka\":\"ლონდონი\",\"om\":\"Landan\",\"en\":\"London\",\"km\":\"ឡុងដ៍\",\"yi\":\"לאנדאן\",\"ab\":\"Лондон\",\"sl\":\"London\",\"kv\":\"Лондон\",\"et\":\"London\",\"ne\":\"लन्डन\",\"ug\":\"لوندۇن\",\"bm\":\"London\",\"be\":\"Лондан\",\"kk\":\"Лондон\",\"ps\":\"لندن\",\"nv\":\"ToohDineʼéBikinHaalʼá\",\"ur\":\"علاقہلندن\",\"vo\":\"London\",\"mg\":\"Lôndôna\",\"ga\":\"Londain\",\"fr\":\"Londres\",\"ff\":\"London\",\"fy\":\"Londen\",\"ln\":\"Lóndɛlɛ\",\"hi\":\"लंदन\",\"ta\":\"இலண்டன்\",\"pt\":\"Londres\",\"lo\":\"ລອນດອນ\",\"st\":\"London\",\"sr\":\"Лондон\",\"ny\":\"London\",\"te\":\"లండన్\",\"li\":\"Londe\",\"ar\":\"لندن\",\"wa\":\"Londe\",\"ha\":\"Landan\",\"uk\":\"Лондон\",\"el\":\"Λονδίνο\",\"tr\":\"Londra\",\"he\":\"לונדון\",\"lv\":\"Londona\",\"bs\":\"London\",\"sh\":\"London\",\"eo\":\"Londono\",\"sn\":\"London\",\"eu\":\"Londres\",\"tk\":\"London\",\"sv\":\"London\",\"hu\":\"London\",\"ig\":\"London\",\"co\":\"Londra\",\"ee\":\"London\",\"ce\":\"Лондон\",\"gn\":\"Lóndyre\",\"an\":\"Londres\",\"sk\":\"Londýn\",\"da\":\"London\",\"fi\":\"Lontoo\",\"jv\":\"London\",\"cy\":\"Llundain\",\"hy\":\"Լոնդոն\",\"mr\":\"लंडन\",\"ay\":\"London\",\"ro\":\"Londra\",\"lb\":\"London\",\"sa\":\"लन्डन्\",\"ia\":\"London\",\"sw\":\"London\",\"pa\":\"ਲੰਡਨ\",\"vi\":\"LuânĐôn\",\"de\":\"London\",\"nn\":\"London\",\"os\":\"Лондон\",\"zh\":\"伦敦\",\"lt\":\"Londonas\",\"na\":\"London\",\"uz\":\"London\",\"th\":\"ลอนดอน\",\"fj\":\"Lodoni\",\"nl\":\"Londen\",\"pl\":\"Londyn\",\"gl\":\"Londres\",\"kn\":\"ಲಂಡನ್\",\"ky\":\"Лондон\",\"ms\":\"London\",\"cv\":\"Лондон\",\"bi\":\"London\",\"bo\":\"ལོན་ཊོན།\",\"se\":\"London\",\"ku\":\"London\",\"yo\":\"Lọndọnu\",\"ba\":\"Лондон\",\"kw\":\"Loundres\",\"zu\":\"ILondon\",\"br\":\"Londrez\",\"so\":\"London\",\"bh\":\"लंदन\",\"sc\":\"Londra\",\"ko\":\"런던\",\"my\":\"လန်ဒန်မြို့\",\"ja\":\"ロンドン\",\"az\":\"London\",\"fo\":\"London\",\"io\":\"London\",\"mt\":\"Londra\",\"ascii\":\"London\",\"am\":\"ለንደን\",\"tl\":\"Londres\",\"bn\":\"লন্ডন\",\"tt\":\"Лондон\",\"sm\":\"Lonetona\",\"id\":\"London\",\"gd\":\"Lunnainn\",\"hr\":\"London\",\"wo\":\"Londar\",\"si\":\"ලන්ඩන්\",\"av\":\"Лондон\",\"ht\":\"Lonn\",\"cs\":\"Londýn\",\"mn\":\"Лондон\",\"ie\":\"London\",\"es\":\"Londres\",\"kl\":\"London\",\"gv\":\"Lunnin\",\"ca\":\"Londres\",\"af\":\"Londen\",\"ru\":\"Лондон\",\"to\":\"Lonitoni\",\"rm\":\"Londra\",\"cu\":\"Лондонъ\"},\"lat\":51.5073219,\"lon\":-0.1276474,\"country\":\"GB\",\"state\":\"England\"},{\"name\":\"CityofLondon\",\"local_names\":{\"ko\":\"시티오브런던\",\"ru\":\"Сити\",\"lt\":\"LondonoSitis\",\"he\":\"הסיטישללונדון\",\"zh\":\"倫敦市\",\"en\":\"CityofLondon\",\"pt\":\"CidadedeLondres\",\"fr\":\"CitédeLondres\",\"hi\":\"सिटीऑफ़लंदन\",\"es\":\"CitydeLondres\",\"ur\":\"لندنشہر\",\"uk\":\"ЛондонськеСіті\"},\"lat\":51.5156177,\"lon\":-0.0919983,\"country\":\"GB\",\"state\":\"England\"},{\"name\":\"London\",\"local_names\":{\"ru\":\"Лондон\",\"ga\":\"Londain\",\"ug\":\"لوندۇن\",\"fa\":\"لندن\",\"en\":\"London\",\"iu\":\"ᓚᓐᑕᓐ\",\"ar\":\"لندن\",\"ka\":\"ლონდონი\",\"oj\":\"Baketigweyaang\",\"lt\":\"Londonas\",\"ja\":\"ロンドン\",\"yi\":\"לאנדאן\",\"lv\":\"Landona\",\"be\":\"Лондан\",\"he\":\"לונדון\",\"el\":\"Λόντον\",\"ko\":\"런던\",\"hy\":\"Լոնտոն\",\"fr\":\"London\",\"cr\":\"ᓬᐊᐣᑕᐣ\",\"bn\":\"লন্ডন\",\"th\":\"ลอนดอน\"},\"lat\":42.9832406,\"lon\":-81.243372,\"country\":\"CA\",\"state\":\"Ontario\"},{\"name\":\"Chelsea\",\"local_names\":{\"es\":\"Chelsea\",\"ar\":\"تشيلسي\",\"pl\":\"Chelsea\",\"sh\":\"Chelsea,London\",\"da\":\"Chelsea\",\"no\":\"Chelsea\",\"af\":\"Chelsea,Londen\",\"ru\":\"Челси\",\"tr\":\"Chelsea,Londra\",\"ga\":\"Chelsea\",\"pt\":\"Chelsea\",\"hu\":\"Chelsea\",\"ur\":\"چیلسی،لندن\",\"az\":\"Çelsi\",\"he\":\"צ'לסי\",\"de\":\"Chelsea\",\"el\":\"Τσέλσι\",\"ko\":\"첼시\",\"zh\":\"車路士\",\"it\":\"Chelsea\",\"eu\":\"Chelsea\",\"sk\":\"Chelsea\",\"uk\":\"Челсі\",\"fr\":\"Chelsea\",\"hi\":\"चेल्सी,लंदन\",\"sv\":\"Chelsea,London\",\"ja\":\"チェルシー\",\"id\":\"Chelsea,London\",\"fa\":\"چلسی\",\"et\":\"Chelsea\",\"nl\":\"Chelsea\",\"en\":\"Chelsea\",\"vi\":\"Chelsea,LuânĐôn\"},\"lat\":51.4875167,\"lon\":-0.1687007,\"country\":\"GB\",\"state\":\"England\"},{\"name\":\"London\",\"lat\":37.1289771,\"lon\":-84.0832646,\"country\":\"US\",\"state\":\"Kentucky\"}]")
    }

}

class MockServiceProvider: DataProvider {
    
    let weatherData: Data
    let locationData: Data
    init(weatherDataString: String, locationDataString: String) {
        weatherData = weatherDataString.data(using: .utf8) ?? Data()
        locationData = weatherDataString.data(using: .utf8) ?? Data()

    }
    
    func fetchDataFrom(url: URL) -> AnyPublisher<Data, any Error> {
        if url.absoluteString.contains("2.5/weather") {
            Just(weatherData)
                .tryMap({ $0 })
                .eraseToAnyPublisher()
        } else {
            Just(locationData)
                .tryMap({ $0 })
                .eraseToAnyPublisher()
        }
        
        
    }
    
}
