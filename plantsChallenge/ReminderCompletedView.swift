//
//  ReminderCompletedView.swift
//  plantsChallenge
//
//  Created by Shatha Alsharif on 19/04/1446 AH.
//


import SwiftUI

struct ReminderCompletedView: View {
    var body: some View {
        ZStack {
            // Background Image
            Image("completedPicture")
                .resizable() // Make the image resizable
                .scaledToFit() // Maintain the aspect ratio
                .frame(width: 200, height: 200) // Set the desired size
                .padding(.top, 100) // Optional: adjust padding to center vertically
            
            VStack {
                // Title for the Completed Reminder View
                VStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.trailing, 170.0)
                    
                    Divider()
                        .background(Color.white)
                        .padding(.horizontal, 0.0)
                    
                    Spacer()
                }
                .padding()
                
                Spacer() // Push the button to the bottom
                
                // New Reminder Button
                NavigationLink(destination: SetReminderView()) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(red: 40/255, green: 224/255, blue: 168/255)) // Set custom color
                            .font(.title)
                        Text(" New Reminder")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green) // Set text color
                    }
                    .padding() // Add padding around the button
                 
                    .cornerRadius(10) // Rounded corners
                }
                .padding(.bottom) // Padding at the bottom
            }
        }
        .foregroundColor(.white) // Optional: text color
        .navigationBarTitle("Completed", displayMode: .inline)
        .navigationBarBackButtonHidden(true) // Hide the back button
    }
}

#Preview {
    ReminderCompletedView()
        .preferredColorScheme(.dark) // Optional: set preferred color scheme
}
