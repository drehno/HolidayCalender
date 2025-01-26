//
//  ExplanationView.swift
//  HolidayCalender
//
//  Created by Max krupa on 26.01.25.
//

import SwiftUI

struct TarotCard: Identifiable {
    let id: String
    let name: String
    let explanation: String
    
    init(name: String, imageName: String, explanation: String) {
        self.id = imageName
        self.name = name
        self.explanation = explanation
    }
}

struct ExplanationView: View {
    @State private var selectedCard: String?
    private let cardWidth: CGFloat = 300
    private let cardHeight: CGFloat = 500
    
    private let tarotCards: [TarotCard] = [
        TarotCard(name: "The Fool",
                 imageName: "thefool",
                 explanation: "The Fool represents new beginnings, spontaneity, and a leap of faith. It signifies innocence, adventure, and unlimited potential. Upright, it encourages taking risks and embracing the unknown. Reversed, it warns of recklessness and poor judgment."),
        TarotCard(name: "The Magician",
                 imageName: "Picsart_22-05-17_01-05-30-660",
                 explanation: "The Magician symbolizes manifestation, resourcefulness, and power. It represents using your skills and talents to create your reality. Upright, it signifies confidence and taking action. Reversed, it suggests manipulation or untapped potential."),
        TarotCard(name: "The High Priestess",
                 imageName: "Picsart_22-05-17_01-04-40-636",
                 explanation: "The High Priestess embodies intuition, mystery, and hidden knowledge. She represents the subconscious mind and secrets yet to be revealed. Upright, it encourages trusting your instincts. Reversed, it indicates repressed intuition or hidden truths."),
        TarotCard(name: "The Empress",
                 imageName: "Picsart_22-05-17_01-04-00-058",
                 explanation: "The Empress represents fertility, abundance, and nurturing energy. She symbolizes creativity, growth, and the natural world. Upright, it signifies prosperity and maternal care. Reversed, it suggests stagnation or overindulgence."),
        TarotCard(name: "The Emperor",
                 imageName: "Picsart_22-05-17_01-03-17-436",
                 explanation: "The Emperor stands for authority, structure, and leadership. He represents stability, control, and the power to manifest goals. Upright, it signifies discipline and ambition. Reversed, it warns of rigidity or abuse of power."),
        TarotCard(name: "The Hierophant",
                 imageName: "Picsart_22-05-17_01-02-46-755",
                 explanation: "The Hierophant symbolizes tradition, spirituality, and conformity. It represents institutions, rituals, and established beliefs. Upright, it encourages following tradition. Reversed, it suggests rebellion or questioning authority."),
        TarotCard(name: "The Lovers",
                 imageName: "Picsart_22-05-17_01-01-55-228",
                 explanation: "The Lovers represent love, harmony, and relationships. It signifies choices, partnerships, and alignment of values. Upright, it encourages unity and commitment. Reversed, it indicates imbalance or difficult decisions."),
        TarotCard(name: "The Chariot",
                 imageName: "Picsart_22-05-17_01-00-55-244",
                 explanation: "The Chariot symbolizes determination, willpower, and victory. It represents overcoming obstacles through focus and control. Upright, it signifies progress and ambition. Reversed, it suggests lack of direction or self-doubt."),
        TarotCard(name: "Strength",
                 imageName: "Picsart_22-05-17_00-59-49-885",
                 explanation: "Strength represents courage, inner power, and compassion. It signifies mastering your emotions and taming your instincts. Upright, it encourages resilience and patience. Reversed, it suggests self-doubt or misuse of power."),
        TarotCard(name: "The Hermit",
                 imageName: "Picsart_22-05-17_00-59-20-808",
                 explanation: "The Hermit symbolizes introspection, wisdom, and solitude. It represents seeking inner guidance and withdrawing from the world. Upright, it encourages self-reflection. Reversed, it suggests isolation or avoidance."),
        TarotCard(name: "The Wheel of Fortune",
                 imageName: "Picsart_22-05-17_00-58-53-403",
                 explanation: "The Wheel of Fortune represents change, cycles, and destiny. It signifies the ups and downs of life and the influence of fate. Upright, it encourages embracing change. Reversed, it suggests resistance to change or bad luck."),
        TarotCard(name: "Justice",
                 imageName: "Picsart_22-05-17_00-58-16-442",
                 explanation: "Justice symbolizes fairness, truth, and accountability. It represents cause and effect, and the consequences of your actions. Upright, it encourages fairness and balance. Reversed, it suggests injustice or dishonesty."),
        TarotCard(name: "The Hanged Man",
                 imageName: "Picsart_22-05-17_00-57-23-440",
                 explanation: "The Hanged Man represents surrender, perspective, and letting go. It signifies seeing things from a new angle and pausing for reflection. Upright, it encourages acceptance. Reversed, it suggests resistance or delays."),
        TarotCard(name: "Death",
                 imageName: "Picsart_22-05-17_00-56-47-780",
                 explanation: "Death symbolizes transformation, endings, and new beginnings. It represents the natural cycle of life and the need to let go of the old. Upright, it encourages change and renewal. Reversed, it suggests fear of change or stagnation."),
        TarotCard(name: "Temperance",
                 imageName: "Picsart_22-05-17_00-55-50-639",
                 explanation: "Temperance represents balance, moderation, and harmony. It signifies blending opposites and finding peace. Upright, it encourages patience and self-control. Reversed, it suggests imbalance or excess."),
        TarotCard(name: "The Devil",
                 imageName: "Picsart_22-05-17_00-55-13-612",
                 explanation: "The Devil symbolizes bondage, materialism, and temptation. It represents unhealthy attachments and limiting beliefs. Upright, it warns of self-imposed restrictions. Reversed, it suggests breaking free from negativity."),
        TarotCard(name: "The Tower",
                 imageName: "Picsart_22-05-17_00-53-56-828",
                 explanation: "The Tower represents sudden change, upheaval, and revelation. It signifies the collapse of old structures and the need for transformation. Upright, it encourages embracing change. Reversed, it suggests avoiding necessary change."),
        TarotCard(name: "The Star",
                 imageName: "Picsart_22-05-17_00-53-27-051",
                 explanation: "The Star symbolizes hope, inspiration, and healing. It represents guidance, optimism, and renewal. Upright, it encourages faith and positivity. Reversed, it suggests despair or lack of direction."),
        TarotCard(name: "The Moon",
                 imageName: "Picsart_22-05-17_00-53-00-831",
                 explanation: "The Moon represents intuition, illusion, and the subconscious. It signifies confusion, dreams, and hidden fears. Upright, it encourages trusting your instincts. Reversed, it suggests deception or anxiety."),
        TarotCard(name: "The Sun",
                 imageName: "Picsart_22-05-17_00-52-25-337",
                 explanation: "The Sun symbolizes joy, success, and vitality. It represents clarity, positivity, and achievement. Upright, it encourages optimism and confidence. Reversed, it suggests temporary setbacks or self-doubt."),
        TarotCard(name: "Judgment",
                 imageName: "Picsart_22-05-17_00-51-45-739",
                 explanation: "Judgment represents rebirth, awakening, and self-evaluation. It signifies a call to rise up and embrace your purpose. Upright, it encourages transformation and renewal. Reversed, it suggests self-doubt or fear of change."),
        TarotCard(name: "The World",
                 imageName: "Picsart_22-05-17_00-50-42-638",
                 explanation: "The World represents completion, fulfillment, and wholeness. It signifies achievement, integration, and the end of a cycle. Upright, it encourages celebration and success. Reversed, it suggests unfinished business or delays."),
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.layeredGradient
                VStack {
                    Text("Tarot Card Explanations")
                        .font(AppTheme.titleFont())
                        .foregroundColor(AppTheme.textPrimary)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    ScrollView() {
                        VStack(spacing: 30) {
                            ForEach(tarotCards) { card in
                                TarotCardItem(
                                    card: card,
                                    isExplanationVisible: selectedCard == card.id,
                                    cardWidth: cardWidth,
                                    cardHeight: cardHeight
                                )
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedCard = (selectedCard == card.id) ? nil : card.id
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            //.navigationBarHidden(true)
        }
    }
}

struct TarotCardItem: View {
    let card: TarotCard
    let isExplanationVisible: Bool
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    @State private var cardScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Image(card.id)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: cardWidth, height: cardHeight)
                .scaleEffect(cardScale)
                .animation(.easeInOut(duration: 0.2), value: cardScale)
                .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
            
            if isExplanationVisible {
                ExplanationOverlay(card: card)
                    .transition(.opacity.combined(with: .offset(y: 20)))
            }
        }
        .onChange(of: isExplanationVisible) { newValue, idfk in
            cardScale = 0.95
        }
    }
}

struct ExplanationOverlay: View {
    let card: TarotCard
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(card.name)
                    .font(AppTheme.titleFont())
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Text(card.explanation)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.9))
                    .cornerRadius(15)
            }
            .padding()
        }
        .frame(width: 431, height: 719)
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}

struct TarotCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView()
    }
}
