//
//  setReminder.swift
//  plantsChallenge
//
//  Created by Shatha Alsharif on
//17/04/1446 AH.


//EDITE AND DELETE
import SwiftUI

struct SetReminderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var plantName: String = ""
    @State private var room: String = "Choose Room"
    @State private var light: String = "Choose Light"
    @State private var wateringDays: String = "Choose Watering Days"
    @State private var water: String = "Choose Watering Frequency"
    
    let lightOptions = ["Full Sun", "Partial Sun Light", "Low Light"]
    let wateringDaysOptions = ["Every Day", "Every 2 Days", "Every 3 Days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterOptions = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    let roomOptions = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]

    var reminder: Reminder? // The reminder to edit (if any)

    init(reminder: Reminder? = nil) {
        self.reminder = reminder
        if let reminder = reminder {
            _plantName = State(initialValue: reminder.title)
            _room = State(initialValue: reminder.location)
            _light = State(initialValue: reminder.light)
            _water = State(initialValue: reminder.water)
            _wateringDays = State(initialValue: "Choose Watering Days") // Adjust as necessary
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Form content
                Form {
                    Section(header: Text(" ").foregroundColor(.white)) {
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
                    
                    Section(header: Text(" ").foregroundColor(.white)) {
                        // Room Box
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
                        
                        // Light Box
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
                    
                    Section(header: Text(" ").foregroundColor(.white)) {
                        // Watering Days Box
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
                        
                        // Water Box
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
                
                // Delete Reminder Button
                if reminder != nil {
                    Button(action: {
                        // Handle delete action
                        deleteReminder()
                    }) {
                        Text("Delete Reminder")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                    }
                    .padding()
                }
            }
            .padding(.bottom, 150.0)
           
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.green),
            trailing: Button("Save") {
                saveReminder()
            }
            .foregroundColor(.green))
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationBarBackButtonHidden(true) // Hide the back button
        }
        .accentColor(.gray)
    }

    private func saveReminder() {
        // Logic to save reminder goes here
        print("Plant Name: \(plantName)")
        print("Room: \(room)")
        print("Light: \(light)")
        print("Watering Days: \(wateringDays)")
        print("Water: \(water)")

        // Add logic to update or save the reminder in UserDefaults or any data store you use.

        presentationMode.wrappedValue.dismiss()
    }

    private func deleteReminder() {
        // Logic to delete the reminder goes here
        print("Deleting reminder for \(plantName)")

        // Notify parent view or handle deletion logic (e.g., updating UserDefaults)
        
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    SetReminderView()
        .preferredColorScheme(.dark)
}
