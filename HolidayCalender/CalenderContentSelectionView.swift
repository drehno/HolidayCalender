import SwiftUI

struct CalenderContentSelectionView: View {
    let calendarTitle: String
    let startDate: Date
    let endDate: Date
    
    @State private var motivationalQuotes = false
    @State private var motivationalPictures = false
    @State private var zodiacSignFacts = false
    @State private var futureTelling = false
    @State private var tarotCards = false
    @State private var navigateToCalendarView = false
    
    private let motivationalQuotesArr = ["Believe you can and you're halfway there.", "The only way to do great work is to love what you do.", "Success is not final, failure is not fatal: It is the courage to continue that counts.", "Don't watch the clock; do what it does. Keep going.", "You are never too old to set another goal or to dream a new dream.", "It does not matter how slowly you go as long as you do not stop.", "Act as if what you do makes a difference. It does.", "Success is how high you bounce when you hit bottom.", "Your limitation—it's only your imagination.", "Push yourself, because no one else is going to do it for you.", "Great things never come from comfort zones.", "Dream it. Wish it. Do it.", "Success doesn’t just find you. You have to go out and get it.", "The harder you work for something, the greater you’ll feel when you achieve it.", "Dream bigger. Do bigger.", "Don’t stop when you’re tired. Stop when you’re done.", "Wake up with determination. Go to bed with satisfaction.", "Do something today that your future self will thank you for.", "Little things make big days.", "It’s going to be hard, but hard does not mean impossible.", "Don’t wait for opportunity. Create it.", "Sometimes we’re tested not to show our weaknesses, but to discover our strengths.", "The key to success is to focus on goals, not obstacles.", "Dream it. Believe it. Build it.", "It always seems impossible until it’s done.", "Don’t be pushed around by the fears in your mind. Be led by the dreams in your heart.", "Keep your face always toward the sunshine—and shadows will fall behind you.", "Opportunities don't happen, you create them.", "If you can dream it, you can do it.", "What you get by achieving your goals is not as important as what you become by achieving your goals.", "Happiness is not something ready made. It comes from your own actions.", "The only limit to our realization of tomorrow will be our doubts of today.", "The future belongs to those who believe in the beauty of their dreams.", "The best way to predict the future is to create it.", "Don't let yesterday take up too much of today.", "You learn more from failure than from success. Don’t let it stop you. Failure builds character.", "People who are crazy enough to think they can change the world, are the ones who do.", "We may encounter many defeats but we must not be defeated.", "Knowing is not enough; we must apply. Wishing is not enough; we must do.", "Imagine your life is perfect in every respect; what would it look like?", "We generate fears while we sit. We overcome them by action.", "Whether you think you can or think you can’t, you’re right.", "Security is mostly a superstition. Life is either a daring adventure or nothing.", "The man who has confidence in himself gains the confidence of others.", "The only limit to our realization of tomorrow will be our doubts of today.", "Creativity is intelligence having fun.", "What you lack in talent can be made up with desire, hustle, and giving 110% all the time.", "Do what you can with all you have, wherever you are.", "Develop an ‘attitude of gratitude’. Say thank you to everyone you meet for everything they do for you.", "You are never too old to set another goal or to dream a new dream.", "To see what is right and not do it is a lack of courage.", "Reading is to the mind, as exercise is to the body.", "Fake it until you make it! Act as if you had all the confidence you require until it becomes your reality.", "The future belongs to the competent. Get good, get better, be the best!", "For every reason it’s not possible, there are hundreds of people who have faced the same circumstances and succeeded.", "Things work out best for those who make the best of how things work out.", "A room without books is like a body without a soul.", "I think goals should never be easy, they should force you to work, even if they are uncomfortable at the time.", "One of the lessons that I grew up with was to always stay true to yourself and never let what somebody else says distract you from your goals.", "The pessimist sees difficulty in every opportunity. The optimist sees opportunity in every difficulty.", "Don't let what you cannot do interfere with what you can do.", "Good, better, best. Never let it rest. 'Til your good is better and your better is best.", "To accomplish great things, we must not only act, but also dream; not only plan, but also believe.", "It’s not whether you get knocked down, it’s whether you get up.", "If you are not willing to risk the usual you will have to settle for the ordinary.", "Trust because you are willing to accept the risk, not because it's safe or certain.", "All our dreams can come true if we have the courage to pursue them.", "Your time is limited, so don’t waste it living someone else’s life.", "The only way to achieve the impossible is to believe it is possible.", "Do what you love, and the money will follow.", "You miss 100% of the shots you don’t take.", "Don’t wait. The time will never be just right.", "The secret of getting ahead is getting started.", "I have not failed. I’ve just found 10,000 ways that won’t work.", "The only way to do great work is to love what you do.", "If you can dream it, you can achieve it.", "Hardships often prepare ordinary people for an extraordinary destiny.", "Success is not how high you have climbed, but how you make a positive difference to the world.", "In order to succeed, your desire for success should be greater than your fear of failure.", "If you believe it will work out, you’ll see opportunities. If you believe it won’t, you will see obstacles.", "Success usually comes to those who are too busy to be looking for it.", "I find that the harder I work, the more luck I seem to have.", "Do one thing every day that scares you.", "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.", "Success is getting what you want. Happiness is wanting what you get.", "Success is not the absence of failure; it's the persistence through failure.", "The road to success and the road to failure are almost exactly the same.", "Don’t be afraid to give up the good to go for the great.", "I wake up every morning and think to myself, ‘How far can I push this company in the next 24 hours.’", "If people are doubting how far you can go, go so far that you can’t hear them anymore.", "We need to accept that we won’t always make the right decisions, that we’ll screw up royally sometimes—understanding that failure is not the opposite of success, it’s part of success."]
    private let zodiacSignFactsArr = ["Known for being highly adaptable and quick-witted.", "Often associated with a deep sense of loyalty and emotional sensitivity.", "Recognized for their natural charm and social skills.", "Typically valued for their practical approach and reliability.", "Frequently linked to an intense and passionate nature.", "Often seen as optimistic and adventurous.", "Known for their strong determination and ambition.", "Typically admired for their creative and artistic abilities.", "Frequently associated with a sense of balance and fairness.", "Often described as independent and strong-willed.", "Recognized for their analytical minds and attention to detail.", "Known for their compassionate and empathetic nature.", "Often seen as very curious and eager to learn.", "Typically valued for their nurturing and protective instincts.", "Frequently admired for their diplomatic and harmonious nature.", "Often associated with being resourceful and strategic.", "Recognized for their enthusiastic and energetic outlook.", "Known for their disciplined and responsible attitude.", "Typically admired for their visionary and innovative ideas.", "Frequently associated with a deep intuition and spiritual connection.", "Often described as lively and spontaneous.", "Known for their ability to bring stability and security.", "Often seen as charming and persuasive communicators.", "Typically admired for their hardworking and methodical approach.", "Frequently linked to being deeply emotional and intuitive.", "Known for their strong sense of justice and equality.", "Often associated with being highly focused and goal-oriented.", "Recognized for their playful and youthful spirit.", "Typically admired for their dedication and persistence.", "Frequently associated with a love for beauty and aesthetics.", "Known for their ability to transform and regenerate.", "Often described as bold and courageous in their pursuits.", "Typically valued for their steady and dependable nature.", "Recognized for their intellectual and versatile personality.", "Often seen as having a deep sense of empathy and understanding.", "Known for their knack for storytelling and communication.", "Typically admired for their resilience and endurance.", "Frequently associated with being imaginative and dreamy.", "Often described as free-spirited and open-minded.", "Known for their strong sense of tradition and respect for rules.", "Typically admired for their unique and unconventional perspective.", "Frequently linked to being highly intuitive and perceptive.", "Often associated with a quick mind and sharp wit.", "Recognized for their generosity and warmth.", "Known for their meticulous nature and attention to small details.", "Typically valued for their commitment and reliability.", "Frequently admired for their ability to mediate and bring peace.", "Often described as determined and resourceful.", "Known for their boundless enthusiasm and zest for life.", "Typically admired for their maturity and wisdom.", "Frequently linked to being innovative and forward-thinking.", "Often associated with being deeply introspective and reflective.", "Recognized for their lively and sociable nature.", "Known for their deep-seated sense of security and comfort.", "Often seen as diplomatic and tactful in their interactions.", "Typically admired for their strong work ethic and dedication.", "Frequently associated with a deep emotional depth and sensitivity.", "Known for their ability to see the big picture and think long-term.", "Often described as adaptable and flexible in different situations.", "Typically valued for their loyalty and protective instincts.", "Recognized for their appreciation of harmony and balance.", "Often seen as strategic and resourceful in achieving goals.", "Known for their adventurous spirit and love for new experiences.", "Typically admired for their discipline and sense of responsibility.", "Frequently associated with an innovative and future-oriented mindset.", "Often described as empathetic and deeply compassionate.", "Known for their witty and engaging conversational skills.", "Typically admired for their practical and sensible approach.", "Frequently linked to being deeply emotional and nurturing.", "Often associated with a strong sense of justice and fairness.", "Recognized for their intense focus and determination.", "Known for their playful and fun-loving nature.", "Typically admired for their perseverance and hard work.", "Frequently associated with an appreciation for beauty and harmony.", "Known for their ability to undergo deep personal transformation.", "Often described as courageous and pioneering.", "Typically valued for their stability and reliability.", "Recognized for their curiosity and love for learning.", "Often seen as deeply empathetic and compassionate.", "Known for their storytelling ability and gift of gab.", "Typically admired for their resilience and determination.", "Frequently linked to being highly imaginative and creative.", "Often associated with a love for freedom and exploration.", "Recognized for their respect for rules and traditions.", "Known for their unique and independent way of thinking.", "Typically admired for their strong intuition and psychic abilities.", "Frequently associated with being quick-witted and intelligent.", "Known for their warmth and generosity.", "Often seen as detail-oriented and precise.", "Typically valued for their reliability and consistency.", "Recognized for their ability to foster peace and harmony.", "Often described as resourceful and strategic in their actions.", "Known for their enthusiastic and optimistic outlook.", "Typically admired for their sense of discipline and maturity.", "Frequently linked to being innovative and forward-thinking.", "Often associated with deep emotional insight and empathy."]
    private let futureTellingArr = ["You will find success in an unexpected opportunity.", "A significant life change will bring new perspectives.", "You will reconnect with someone from your past.", "An exciting travel adventure awaits you.", "A long-held dream will finally come true.", "You will discover a hidden talent within yourself.", "A chance encounter will lead to a meaningful friendship.", "You will make a positive impact on someone’s life.", "Your hard work will soon be recognized and rewarded.", "A new hobby will bring joy and creativity to your life.", "Financial stability is on the horizon.", "You will achieve a major personal goal.", "An unexpected mentor will provide valuable guidance.", "A new project will ignite your passion and purpose.", "You will overcome a challenge with grace and resilience.", "A spontaneous decision will lead to a memorable experience.", "Your confidence will grow, opening new doors for you.", "A cherished wish will be granted sooner than expected.", "You will find clarity and direction in your career.", "A new partnership will bring exciting opportunities.", "You will receive news that will bring happiness and relief.", "A creative idea will lead to a successful venture.", "You will find strength in a supportive community.", "A significant personal transformation is on its way.", "You will make a courageous choice that changes your path.", "A long-standing issue will finally be resolved.", "You will be inspired by a powerful and uplifting message.", "A new learning opportunity will broaden your horizons.", "You will experience a profound sense of peace and contentment.", "A major breakthrough will propel you forward in your goals.", "You will form a strong connection with someone who shares your values.", "A positive change in your living situation is imminent.", "You will discover a new passion that brings you great fulfillment.", "An unexpected gift will brighten your day.", "You will receive recognition for your kindness and generosity.", "A bold move will lead to significant personal growth.", "Your health and well-being will greatly improve.", "A new opportunity will align perfectly with your skills and ambitions.", "You will find a creative solution to a lingering problem.", "A supportive figure will play a key role in your success.", "You will experience a deep sense of gratitude and abundance.", "A long-awaited journey will soon become a reality.", "You will make a decision that leads to long-term happiness.", "A significant relationship will deepen and strengthen.", "You will gain valuable insights from a surprising source.", "A new beginning will bring renewed energy and excitement.", "You will achieve a balance between work and personal life.", "A rewarding challenge will push you to new heights.", "You will find inspiration in nature and the world around you.", "A heartfelt conversation will bring clarity and understanding.", "You will discover new ways to express your creativity.", "An unexpected windfall will bring financial relief.", "You will embrace a healthier and more active lifestyle.", "A personal milestone will be celebrated with loved ones.", "You will make a positive difference in your community.", "A new friendship will bring joy and laughter to your life.", "You will receive a long-awaited piece of good news.", "An old hobby will bring new opportunities and connections.", "You will overcome a fear and gain newfound confidence.", "A new perspective will transform the way you see the world.", "You will find the courage to pursue a lifelong dream.", "An exciting career opportunity will present itself.", "You will create something that inspires others.", "A meaningful volunteer experience will enrich your life.", "You will discover a new way to achieve your goals.", "A heartfelt gesture will strengthen an important relationship.", "You will find peace and closure from a past event.", "A personal project will gain unexpected recognition.", "You will find joy in helping others achieve their dreams.", "A spontaneous adventure will create lasting memories.", "You will receive a compliment that boosts your self-esteem.", "An old friendship will be rekindled with new energy.", "You will find the courage to make a bold life decision.", "A new skill will open doors to exciting opportunities.", "You will receive a message that changes your outlook.", "An unexpected event will lead to personal growth.", "You will find success in a collaborative effort.", "A positive shift in your finances will bring relief.", "You will discover the strength to overcome a personal challenge.", "A creative project will lead to a rewarding outcome.", "You will make a decision that aligns with your true purpose.", "A surprising opportunity will bring joy and fulfillment.", "You will find harmony in your personal relationships.", "A new adventure will bring excitement and discovery.", "You will gain recognition for your hard work and dedication.", "An unexpected ally will support you in a crucial moment.", "You will experience a moment of profound personal insight.", "A new chapter in your life will begin with great promise.", "You will cultivate a habit that brings long-term benefits.", "A heartfelt compliment will uplift your spirits.", "You will find the courage to let go of what no longer serves you.", "An opportunity for growth will come from an unexpected source.", "You will experience a surge of creative inspiration.", "A chance meeting will lead to a valuable connection.", "You will make a lasting impact through your actions.", "A new journey will lead to exciting discoveries and opportunities."]
    private let backgrounds = ["b1", "b2", "b3"]

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.layeredGradient
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Motivational Quotes")
                            .font(AppTheme.secondTitleFont())
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Toggle("", isOn: $motivationalQuotes)
                            .labelsHidden()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                    
                    HStack {
                        Text("Motivational Pictures")
                            .font(AppTheme.secondTitleFont())
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Toggle("", isOn: $motivationalPictures)
                            .labelsHidden()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                    
                    HStack {
                        Text("Zodiac Sign Facts")
                            .font(AppTheme.secondTitleFont())
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Toggle("", isOn: $zodiacSignFacts)
                            .labelsHidden()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                    
                    HStack {
                        Text("Future Telling")
                            .font(AppTheme.secondTitleFont())
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Toggle("", isOn: $futureTelling)
                            .labelsHidden()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                    
                    HStack {
                        Text("Tarot cards")
                            .font(AppTheme.secondTitleFont())
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Spacer()
                        
                        Toggle("", isOn: $tarotCards)
                            .labelsHidden()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    Button(action: {
                        createCalendar(
                            title: calendarTitle,
                            startDate: startDate,
                            endDate: endDate,
                            motivationalQuotes: motivationalQuotes,
                            motivationalPictures: motivationalPictures,
                            zodiacSignFacts: zodiacSignFacts,
                            futureTelling: futureTelling,
                            tarotCards: tarotCards
                        )
                        navigateToCalendarView = true
                    }) {
                        HStack {
                            Text("Create Calendar")
                            Image(systemName: "calendar.badge.plus")
                        }
                        .font(AppTheme.bodyFontBold())
                        .foregroundColor(.white)
                        .padding()
                        .background(AppTheme.accentDark)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    }
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Calendar Content")
            .navigationDestination(isPresented: $navigateToCalendarView) {
                MyCalendarsView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    func sanitizeFileName(_ name: String) -> String {
        return name.replacingOccurrences(of: " ", with: "")
    }
    
    func createCalendar(title: String, startDate: Date, endDate: Date, motivationalQuotes: Bool, motivationalPictures: Bool, zodiacSignFacts: Bool, futureTelling: Bool, tarotCards: Bool) {
        let sanitizedFileName = sanitizeFileName(title)
        
        var calendarDays: [CalendarDay] = []
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let adjustedStartDate = calendar.startOfDay(for: startDate)
        var currentDate = adjustedStartDate
        
        while currentDate <= endDate {
            let maxRange = motivationalQuotesArr.count
            let c = Int.random(in: 0..<3)
            let r = Int.random(in: 0..<maxRange)
            var quote: String = ""
            
            switch c {
                case 0:
                    if motivationalQuotes {
                        quote = motivationalQuotesArr[r]
                    }
                case 1:
                    if zodiacSignFacts {
                        quote = zodiacSignFactsArr[r]
                    }
                case 2:
                    if futureTelling {
                        quote = zodiacSignFactsArr[r]
                    }
                default:
                    quote = motivationalQuotesArr[r]
            }
            
            let c2 = Int.random(in: 0..<3)
            let background = backgrounds[c2]
            
            let day = CalendarDay(date: currentDate, background: background, quote: quote)
            calendarDays.append(day)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        let csvContent = generateCSVContent(for: calendarDays)
        saveCSVFile(content: csvContent, fileName: sanitizedFileName)
    }
}

