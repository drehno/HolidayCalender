import SwiftUI
import UIKit

struct CalendarCreateView: View {
    @State private var calendarTitle: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var birthDate = Date()
    @State private var navigateToContentSelection = false
    @State private var showError: Bool = false
    @State private var showEmptyTitleError: Bool = false
    @State private var autocorrectingTitle: Bool = false
    @State private var showDuplicateTitleError: Bool = false
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.layeredGradient
                
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Calendar Title
                            Text("Calendar Title")
                                .font(AppTheme.secondTitleFont())
                                .foregroundColor(AppTheme.textPrimary)
                                .padding(.leading, 30)
                                .padding(.top, 40)
                            
                            TextField("Calendar title", text: $calendarTitle)
                                .padding(10)
                                .background(AppTheme.accentDark.opacity(0.3))
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                                .font(AppTheme.bodyFont())
                                .focused($isTextFieldFocused) 
                                .onChange(of: calendarTitle) { _, newValue in
                                    let filteredValue = filterTitle(newValue)
                                    if filteredValue != newValue {
                                        showError = true
                                        autocorrectingTitle = true
                                        triggerVibration()
                                    } else if !autocorrectingTitle {
                                        showError = false
                                    } else {
                                        autocorrectingTitle = false
                                    }
                                    calendarTitle = filteredValue
                                }
                            
                            // Error Message for invalid characters
                            if showError {
                                Text("Only letters, numbers, and spaces are allowed.")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 30)
                            }
                            
                            // Error Message for empty title
                            if showEmptyTitleError {
                                Text("Please enter a calendar title.")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 30)
                            }
                            // Error Message for duplicated title
                            if showDuplicateTitleError {
                                Text("There is already another calendar with the same title.")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 30)
                            }
                            // Birth Date
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Your Birthday")
                                    .font(AppTheme.secondTitleFont())
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                DatePicker("", selection: $birthDate, displayedComponents: [.date])
                                    .datePickerStyle(.wheel)
                                    .frame(height: 50)
                                    .padding(10)
                                    .cornerRadius(10)
                                    .labelsHidden()
                                    .accessibilityLabel("Select your birthday")
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 30)
                            
                            // Starting Date
                            HStack {
                                Text("Start Date")
                                    .font(AppTheme.secondTitleFont())
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Spacer()
                                
                                DatePicker("", selection: $startDate, in: Date()..., displayedComponents: [.date])
                                    .datePickerStyle(.compact)
                                    .cornerRadius(10)
                                    .accessibilityLabel("Select start date")
                                    .onChange(of: startDate) { _, newValue in
                                        startDate = max(newValue, Date())
                                    }
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 30)
                            
                            // Ending Date
                            HStack {
                                Text("End Date")
                                    .font(AppTheme.secondTitleFont())
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Spacer()
                                
                                DatePicker("", selection: $endDate, in: startDate..., displayedComponents: [.date])
                                    .datePickerStyle(.compact)
                                    .cornerRadius(10)
                                    .accessibilityLabel("Select end date")
                                    .onChange(of: endDate) { _, newValue in
                                        endDate = max(newValue, startDate)
                                    }
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 30)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            if calendarTitle.isEmpty {
                                showDuplicateTitleError = false
                                showEmptyTitleError = true
                                triggerVibration()
                            } else if getAllCalendarNames(folderName: "createdCalendars").contains(calendarTitle) {
                                showEmptyTitleError = false
                                showDuplicateTitleError = true
                                triggerVibration()
                            } else {
                                showEmptyTitleError = false
                                showDuplicateTitleError = false
                                navigateToContentSelection = true
                            }
                        } label: {
                            Text("Next")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .font(AppTheme.bodyFontBold())
                        .padding()
                        .background(calendarTitle.isEmpty ? AppTheme.accentDark.opacity(0.5) : AppTheme.accentDark)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    }
                    .padding(.trailing, 30)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Create Your Calendar")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isTextFieldFocused = false // Dismiss the keyboard
                }
                .foregroundColor(.blue)
            }
        }
        .navigationDestination(isPresented: $navigateToContentSelection) {
            CalenderContentSelectionView(calendarTitle: calendarTitle, birthDate: birthDate, startDate: startDate, endDate: endDate)
        }
    }



    
    private func filterTitle(_ input: String) -> String {
        return input.filter { $0.isLetter || $0.isNumber || $0.isWhitespace }
    }
    
    private func triggerVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
