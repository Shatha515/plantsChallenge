//
//  SetReminderView2.swift
//  plantsChallenge
//
//  Created by Shatha Alsharif on 19/04/1446 AH.
//
// 
import SwiftUI

struct SetReminderView2: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var plantName: String = ""
    @State private var room: String = "Choose Room"
    @State private var light: String = "Choose Light"
    @State private var wateringDays: String = "Choose Watering Days"
    @State private var water: String = "Choose Watering Frequency"
    @State private var navigateToTodayReminder = false // State variable for navigation
    @State private var showAlert = false // State variable for alert

    let lightOptions = ["Full Sun", "Partial Sun Light", "Low Light"]
    let wateringDaysOptions = ["Every Day", "Every 2 Days", "Every 3 Days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterOptions = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    let roomOptions = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("").foregroundColor(.white)) {
                        HStack {
                            Text("Plant Name")
                                .foregroundColor(.white)

                            TextField("Pothos", text: $plantName)
                                .foregroundColor(.white)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(4)
                                .accentColor(.green)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(5)
                        }
                        .padding(.vertical, 4)
                    }

                    Section(header: Text("").foregroundColor(.white)) {
                        // Room Picker
                        HStack {
                            Image(systemName: "location")
                                .foregroundColor(.white)

                            Picker("Room", selection: $room) {
                                ForEach(roomOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(4)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(5)
                        .frame(height: 40)

                        // Light Picker
                        HStack {
                            Image(systemName: "sun.max")
                                .foregroundColor(.white)

                            Picker("Light", selection: $light) {
                                ForEach(lightOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(4)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(5)
                        .frame(height: 40)
                    }

                    Section(header: Text("").foregroundColor(.white)) {
                        // Watering Days Picker
                        HStack {
                            Image(systemName: "drop")
                                .foregroundColor(.white)

                            Picker("Watering Days", selection: $wateringDays) {
                                ForEach(wateringDaysOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(4)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(5)
                        .frame(height: 40)

                        // Water Picker
                        HStack {
                            Image(systemName: "drop")
                                .foregroundColor(.white)

                            Picker("Water", selection: $water) {
                                ForEach(waterOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(4)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(5)
                        .frame(height: 40)
                    }
                }
                .padding()
            }
           
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.green),
                trailing: Button("Save") {
                    saveReminder()
                }
                .foregroundColor(.green)
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Input Error"), message: Text("Please enter a plant name."), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $navigateToTodayReminder) {
                TodayReminderView() // Present TodayReminderView when navigating
            }
            .navigationBarBackButtonHidden(true) // Hide the back button
        }
        .accentColor(.gray)
    }

    private func saveReminder() {
        guard !plantName.isEmpty else {
            showAlert = true // Show alert if plant name is empty
            return
        }

        let reminderData: [String: String] = [
            "plantName": plantName,
            "room": room,
            "light": light,
            "wateringDays": wateringDays,
            "water": water
        ]

        var reminders = UserDefaults.standard.array(forKey: "reminders") as? [[String: String]] ?? []
        reminders.append(reminderData)
        UserDefaults.standard.set(reminders, forKey: "reminders")

        print("Saved Reminder: \(reminderData)")

        navigateToTodayReminder = true
    }
}

#Preview {
    SetReminderView2()
        .preferredColorScheme(.dark)
}
