//
//  TodayReminderView 2.swift
//  plantsChallenge
//
//  Created by Shatha Alsharif on 18/04/1446 AH.
//
import SwiftUI

struct TodayReminderView: View {
    @State private var reminders: [Reminder] = []
    @State private var navigateToCompletedView = false // State variable for navigation
    @State private var selectedReminder: Reminder? // State variable for the selected reminder

    var body: some View {
        NavigationView {
            VStack {
                // Title for Today Reminder View
                HStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()

                    Spacer()
                }

                Divider()
                    .background(Color.white)
                    .padding(.horizontal)

                Text("Today")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing, 278.0)

                // Reminder List
                if reminders.isEmpty {
                    // Navigate to the completed view when there are no reminders
                    NavigationLink(destination: ReminderCompletedView(), isActive: $navigateToCompletedView) {
                        EmptyView()
                    }
                } else {
                    List {
                        ForEach(reminders.indices, id: \.self) { index in
                            VStack(alignment: .leading) {
                                // Location detail above each reminder
                                HStack {
                                    Image(systemName: "location")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 5.0)
                                    Text(reminders[index].location)
                                        .foregroundColor(.gray)
                                        .padding(.leading, 2.0)
                                }
                                .padding([.top, .leading], 7.0)

                                // Button for marking as done and editing reminder
                                HStack {
                                    Button(action: {
                                        // Navigate to the SetReminderView with the selected reminder
                                        selectedReminder = reminders[index]
                                    }) {
                                        Image(systemName: reminders[index].isDone ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(reminders[index].isDone ? .green : .gray)
                                            .padding(0.0)
                                            .font(.system(size: 30))
                                    }
                                    .background(
                                        NavigationLink(destination: SetReminderView(reminder: selectedReminder), isActive: Binding<Bool>(
                                            get: { selectedReminder != nil },
                                            set: { if !$0 { selectedReminder = nil } }
                                        )) {
                                            EmptyView()
                                        }
                                        .hidden()
                                    )

                                    Text(reminders[index].title)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(7.0)

                                    Spacer()
                                }
                                .padding(.leading)

                                // Light and water requirement details combined
                                HStack(spacing: 10) {
                                    HStack {
                                        Image(systemName: "sun.max")
                                            .foregroundColor(.yellow)
                                        Text(reminders[index].light)
                                            .foregroundColor(.yellow)
                                    }
                                    .padding(7.0)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)

                                    HStack {
                                        Image(systemName: "drop")
                                            .foregroundColor(Color(red: 0.6, green: 0.8, blue: 1.0))
                                        Text(reminders[index].water)
                                            .foregroundColor(Color(red: 0.6, green: 0.8, blue: 1.0))
                                    }
                                    .padding(7.0)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                                }
                                .padding(.leading, 5)

                                Divider()
                                    .background(Color.white)
                            }
                        }
                        .onDelete(perform: deleteReminder) // Add swipe-to-delete functionality
                    }
                    .listStyle(PlainListStyle()) // Use plain list style
                }

                Spacer(minLength: 20)

                // New Reminder Button at the bottom
                NavigationLink(destination: SetReminderView()) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(red: 40/255, green: 224/255, blue: 168/255))
                            .font(.system(size: 24))

                        Text(" New Reminder")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 40/255, green: 224/255, blue: 168/255))
                            .padding(.leading, 5)

                        Spacer()
                    }
                    .padding()
                }
            }
            .padding(.leading, 3.0)
            .background(Color.black)
            .cornerRadius(10)
            .onAppear {
                loadReminders()
            }
            .navigationBarBackButtonHidden(true) // Hide the back button🔴
        }
    }

    private func loadReminders() {
        if let savedReminders = UserDefaults.standard.array(forKey: "reminders") as? [[String: String]] {
            reminders = savedReminders.compactMap { dict in
                guard let title = dict["plantName"],
                      let location = dict["room"],
                      let light = dict["light"],
                      let water = dict["water"] else { return nil }
                return Reminder(title: title, isDone: false, location: location, light: light, water: water)
            }
        }
    }

    private func deleteReminder(at offsets: IndexSet) {
        // Remove reminders from the list
        reminders.remove(atOffsets: offsets)

        // Update UserDefaults
        saveReminders()

        // Check if reminders are empty and navigate to the completed view
        if reminders.isEmpty {
            navigateToCompletedView = true
        }
    }

    private func saveReminders() {
        let remindersToSave = reminders.map { reminder in
            [
                "plantName": reminder.title,
                "room": reminder.location,
                "light": reminder.light,
                "water": reminder.water
            ]
        }
        UserDefaults.standard.set(remindersToSave, forKey: "reminders")
    }
}

// Reminder struct to hold title, done state, location, light requirement, and water requirement
struct Reminder {
    var title: String
    var isDone: Bool
    var location: String
    var light: String
    var water: String
}

#Preview {
    TodayReminderView()
}
