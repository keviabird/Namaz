//
//  DatabaseUtil.m
//  Namaz
//
//  Created by Elena Gracheva on 05.04.15.
//  Copyright (c) 2015 Islam. All rights reserved.
//

#import "DatabaseUtil.h"
#import "CoreData+MagicalRecord.h"

#import "Event.h"
#import "Schedule.h"
#import "News.h"
#import "Tutorial.h"
#import "Part.h"

@implementation DatabaseUtil

+(void)initData {
    NSString *initFlag = @"InitCompleted";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:initFlag] != nil) {
        return;
    }
    
    NSManagedObjectContext *moc = [NSManagedObjectContext MR_contextForCurrentThread];
    
    Event *shortAblution = [Event MR_createInContext:moc];
    [shortAblution setId:@1];
    shortAblution.forSchedule = @NO;
    shortAblution.forTutorial = @YES;
    shortAblution.name = @"Краткое омовение";
    
    Event *fullAblution = [Event MR_createInContext:moc];
    [fullAblution setId:@2];
    fullAblution.forSchedule = @NO;
    fullAblution.forTutorial = @YES;
    fullAblution.name = @"Полное омовение";
    
    Event *fajr = [Event MR_createInContext:moc];
    [fajr setId:@3];
    fajr.forSchedule = @YES;
    fajr.forTutorial = @YES;
    fajr.name = @"Фаджр";
    
    Event *sunrise = [Event MR_createInContext:moc];
    [sunrise setId:@4];
    sunrise.forSchedule = @YES;
    sunrise.forTutorial = @NO;
    sunrise.name = @"Шурук";
    
    Event *zuhr = [Event MR_createInContext:moc];
    [zuhr setId:@5];
    zuhr.forSchedule = @YES;
    zuhr.forTutorial = @YES;
    zuhr.name = @"Зухр";
    
    Event *asr = [Event MR_createInContext:moc];
    [asr setId:@6];
    asr.forSchedule = @YES;
    asr.forTutorial = @YES;
    asr.name = @"Аср";
    
    Event *maghrib = [Event MR_createInContext:moc];
    [maghrib setId:@7];
    maghrib.forSchedule = @YES;
    maghrib.forTutorial = @YES;
    maghrib.name = @"Магриб";
    
    Event *isha = [Event MR_createInContext:moc];
    [isha setId:@8];
    isha.forSchedule = @YES;
    isha.forTutorial = @YES;
    isha.name = @"Иша";
    
    Event *witr = [Event MR_createInContext:moc];
    [witr setId:@9];
    witr.forSchedule = @YES;
    witr.forTutorial = @YES;
    witr.name = @"Витр";
    
    
    Tutorial *tutorial = [Tutorial MR_createInContext:moc];
    
    
    News *first = [News MR_createInContext:moc];
    first.title = @"Экспертное мнение: \"Сатановский пытается вбить клин между Россией и исламским миром\"";
    first.date = [NSDate dateWithTimeIntervalSince1970:1434910888];
    first.text = @"Главный спикер израильского лобби в России Евгений Сатановский в одной аналитической телепрограмме на днях объяснил россиянам, что такое ИГИЛ и кто такие мусульмане вообще.\n\nПо традиции, Евгений Янович смешал в кучу всех «исламистов» – ИГИЛ, Аль-Каиду, «Братьев-Мусульман», другие исламские движения по всему миру. Все это – одно и то же, объяснил Сатановский.\n\nИГ, по его утверждениям, вовсе не маргинальная структура, осуждаемая умеренными последователями ислама по всему миру, а истинный исламский «мейнстрим». Не существует умеренных исламистов, есть только исламисты, подобные ИГИЛ, отметил оратор.\n\nПри этом Сатановский обвиняет в финансировании Исламского Государства совершенно разные страны (в принципе, не заинтересованные в этом явлении) – Саудовскую Аравию, Катар, Турцию, но вот США (в версии Сатановского) абсолютно не при делах. Израиль – тем более.\n\nСатановский умышленно подменяет понятия, нарочно «забывая» о том, что расцвет ИГИЛ пришелся как раз на контрреволюционный этап развития арабского мира, в ходе которого умеренные исламские силы, пришедшие к власти на волне арабской весны, были отстранены от управления политическими процессами.\nЭти тезисы израильского лобби в исполнении Евгения Яновича звучат не в первый раз, однако вызывают ряд вопросов.\n\nКакой смысл в подобных обобщениях и чего добивается израильское лобби, делая подобные заявления и пытаясь переключить внимание страны от насущных проблем на гипотетические, выставляя главным врагом России ИГИЛ? Как известно, президент Путин не считает Исламское государство главной угрозой России, что и неудивительно: стране хватает других задач, начиная от проблем в Крыму и заканчивая противостоянием с Украиной и прочими «друзьями» РФ, плотно сжимающими кольцо вокруг страны. Но на этом фоне Россию зачем-то пытаются переориентировать совсем на иные цели и задачи, не представляющие прямой угрозы.\n\nИзвестный политолог Шамиль Султанов на просьбу IN прокомментировать ремарки вышеуказанного оратора отметил: «не надо тратить мое время на то, чтобы я комментировал какие-то высказывания, извиняюсь, Сатановского, который в определенных кругах представляется полковником ФСБ, в других кругах открытым текстом говорит, что он – полковник Моссада, это зависит от количества выпитого и антуража».\n\nОднако, отвечая все же на тезисы Сатановского о том, что все исламисты, от Аль-Каиды до «Братьев-мусульман», по сути, одно и то же, собеседник IN подчеркнул: «в определенном смысле, все мусульмане одинаковы, все полтора миллиарда стремятся к тому, чтобы идеи и принципы ислама воплотились в жизнь, что тут опровергать?»\n\n«С другой стороны, в контексте речей Сатановского все выглядит так, будто все полтора миллиарда мусульман – на одно лицо. Как это опровергнуть? Сказать – нет, они разные? Это маразм, глупость. Это типичное пропагандистское заявление Сатановского, рассчитанное на публику, которая не разбирается в этом, ничего об этом не знает, не слышала, что такое ислам, боится открыть Википедию или какую-либо книгу. Это такой пропагандистский прием, когда используется какое-либо нарицательное слово, например, «исламисты», преподносится, что все исламисты плохие, по определению, дальше подбираются те объекты, которые для пропагандистов важно дискредитировать. Если «исламисты» – это плохо, ИГИЛ – плохо, то и все остальные – в том числе, «Братья-мусульмане» – тоже ничего хорошего. Почему «Братья-мусульмане» – это плохо? Потому что, с точки зрения сионистского движения, с точки зрения Израиля, США поддерживают «Братьев-мусульман» на Ближнем Востоке. Это как бы угроза. Что говорит Сатановский? Он говорит: «умеренных в исламе не бывает, они все одинаковые, начиная от ИГИЛ и заканчивая «Братьями-мусульманами», и так далее. Я правда затрудняюсь это комментировать: пришлось бы на пальцах начать разъяснять программные установки ИГИЛ, БМ и прочих, но это будет надуманно и не интересно. Для сионистов, повторюсь, очень важно дискредитировать любое исламское движение, которое является для них врагом. Любое организованное исламское движение, с их точки зрения, это плохо, это уже политический ислам. В этом смысле для них очень важно дискредитировать политический ислам, ислам как таковой, вбить клин между Россией и исламским миром для того, чтобы какие-либо попытки Кремля играть свою игру, реализовывать свои интересы, встречались с неодобрением населения России», – отметил эксперт.\n\nВ качестве примера он привел «один из самых главных моментов, который сейчас вызывает возмущение у Израиля – намерение России продать зенитные ракетные комплексы С-300 Ирану». «Это очень тревожит Израиль», – напомнил аналитик.\n\n«Получается так: все исламские движения – враги, это плохо, продажа Россией ракет исламской республике Иран (кстати, единственному государству, кроме Пакистана, где присутствует слово «исламская») – тоже плохо. Задача таких пропагандистов, как Сатановский – дискредитировать ислам и любую коннотацию, связанную со словом «ислам», чтобы они вызывали негативную реакцию у аудитории. А главная цель состоит в том, чтобы создать такой фон, на котором любое возможное позитивное сотрудничество России, Москвы, Кремля с исламским миром или с какой-то исламской страной встречалось этой аудиторией негативно. Думаю, такова мотивация господина Сатановского, полковника ФСБ и Моссада», – подытожил аналитик.";
    first.smallImage = UIImagePNGRepresentation([UIImage imageNamed:@"1s.png"]);
    first.fullImage = UIImagePNGRepresentation([UIImage imageNamed:@"1.png"]);
    first.important = @NO;
    
    News *second = [News MR_createInContext:moc];
    second.title = @"Российские мусульмане дали интеллектуальный отпор ИГИЛ";
    second.date = [NSDate dateWithTimeIntervalSince1970:1434912895];
    second.text = @"В Чебоксарах вышла в свет книга, посвященная проблеме “джихадизма” и изданная на средства поволжских мусульман.\n\nВ основу учебного пособия легло открытое письмо исламских ученых предводителям группировки “Исламское государство” (ИГИЛ).\n\nЧитатели смогут узнать мнение авторитетных улемов по актуальным и злободневным вопросам современности, касающихся толкования Корана и хадисов, фикха, взаимоотношений с немусульманами, а также проблематики джихада.\n\nКак рассказал ИА IslamNews автор издания, муфтий Чувашии Айрат Хайбуллов, феномен “джихадизма” – это проблема не столько террора, покупной идейности и социального протеста, сколько извращенного религиозного мировоззрения и фанатизма, взращенных в условиях глобального кризиса культуры и этики, информационного и идеологического кризиса.\n\nПо словам муфтия, наряду с вооруженной антитеррористической борьбой не менее остро стоит задача противодействия террористам в их стремлении завладеть умами молодых людей.\n\nХайбуллов считает, что для решения этих задач необходимо выступить единым фронтом против попыток экстремистов любых мастей осквернять и извращать высокие нравственные принципы ислама.";
    second.smallImage = UIImagePNGRepresentation([UIImage imageNamed:@"2s.png"]);
    second.fullImage = UIImagePNGRepresentation([UIImage imageNamed:@"2.png"]);
    second.important = @YES;
    
    News *third = [News MR_createInContext:moc];
    third.title = @"Военные из США обучают и вооружают сирийских повстанцев в Турции";
    third.date = [NSDate dateWithTimeIntervalSince1970:1434902095];
    third.text = @"Американские военные численностью 123 человека прибыли в Турцию с целью боевого обучения и подготовки сирийских повстанцев, привезя с собой оружие для их снаряжения, сообщает Hurriyet Daily News.\n\n83 американских солдата направлены на военно-воздушную базу Инджирлик, а 40 – на военную базу Хирфанлы в провинции Киршехир.\n\nНа военной базе Хирфанлы в настоящее время находятся сирийские повстанцы, которых перевезут в южную провинцию Хатай и обучат использованию боевого оружия, в том числе противотанкового, а затем отправят воевать против формирований ИГИЛ.\n\nСтоит отметить, что в адрес Турции раздается немало критики по поводу ее нежелания делать свою территорию плацдармом для военной операции против ИГИЛ, однако, по всей видимости, Соединенным Штатам удалось договориться с турками о сотрудничестве в подготовке сирийских повстанцев.";
    third.smallImage = UIImagePNGRepresentation([UIImage imageNamed:@"3s.png"]);
    third.fullImage = UIImagePNGRepresentation([UIImage imageNamed:@"3.png"]);
    third.important = @NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:initFlag];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [moc MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        ;
    }];
}

@end
