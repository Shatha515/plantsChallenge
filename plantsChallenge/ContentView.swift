//
//  ContentView.swift
//  plantsChallenge
//
//  Created by Shatha Alsharif on 17/04/1446 AH.
//
import SwiftUI

struct ContentView: View {
    @State private var isNewUser: Bool = UserDefaults.standard.bool(forKey: "isNewUser")
    @State private var showSetReminder = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("stickerPlant")
                    .padding(.bottom, 263.0) // Adjust as needed for your layout
                
                VStack {
                    HStack {
                        Text("My Plants 🌱") // Title
                            .font(.largeTitle) // Font size for the title
                            .fontWeight(.bold)
                            .foregroundColor(.white) // Text color
                            .padding() // Padding around the text
                        
                        Spacer() // Pushes the title to the left
                    }
                    
                    // Divider under the title
                    Divider()
                        .background(Color.white) // Set the color of the divider
                        .padding(.horizontal) // Horizontal padding for the divider
                    
                    Spacer(minLength: 20) // Space before the next elements
                    
                    Text("Start your plant journey!")
                        .font(.title) // Font style
                        .fontWeight(.bold)
                        .foregroundColor(.white) // Text color
                        .padding(.bottom, 13.0) // Padding around the text
                    
                    Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                        .font(.body)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20.0) // Adjusted padding for spacing

                    // Button to show SetReminderView
                    Button(action: {
                        showSetReminder.toggle()
                    }) {
                        Text("Set Plant Reminder")
                            .font(.headline) // Font style
                            .foregroundColor(.black) // Text color
                            .frame(maxWidth: .infinity) // Make the button fill width
                            .padding() // Add padding around the text
                            .background(Color(red: 40/255, green: 224/255, blue: 168/255)) // Custom background color
                            .cornerRadius(10) // Rounded corners
                            .padding(.horizontal) // Horizontal padding for the button
                    }
                    .padding(.top, 10.0) // Small padding to separate the button from the text
                    .sheet(isPresented: $showSetReminder) {
                        SetReminderView() // Present the SetReminderView as a sheet
                    }
                }
                .padding(.bottom, 129.0) // Adjust bottom padding as needed
            }
            .onAppear {
                // Check if the user is new on appearance
                if isNewUser {
                    // This view will show automatically for new users
                } else {
                    // Transition to the main content or next screen
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
