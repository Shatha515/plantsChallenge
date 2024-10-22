//
//  TodayReminderView 2.swift
//  plantsChallenge
//
//  Created by Shatha Alsharif on 18/04/1446 AH.
//
import SwiftUI

struct TodayReminderView: View {
    @State private var reminders = [
        Reminder(title: "Pothos", isDone: false, location: "in Bedroom", light: "Full sun", water: "20-50 ml"),
        Reminder(title: "Monstera", isDone: false, location: "in Kitchen", light: "Full sun", water: "20-50 ml")
    ]
    
    var body: some View {
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
                        
                        HStack {
                            Button(action: {
                                reminders[index].isDone.toggle()
                            }) {
                                Image(systemName: reminders[index].isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(reminders[index].isDone ? .green : .gray)
                                    .padding(0.0)
                                    .font(.system(size: 30))
                            }
                            
                            Text(reminders[index].title)
                                .font(.title)
                                .foregroundColor(.white)
                                .strikethrough(reminders[index].isDone, color: .green)
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
            
            Spacer(minLength: 20)
            
            // New Reminder Button at the bottom
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 24))
                
                Text(" New Reminder")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.leading, 5)
                
                Spacer()
            }
            .padding()
        }
        .padding(.leading, 3.0)
        .background(Color.black)
        .cornerRadius(10)
    }
    
    private func deleteReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
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
