//
//  ToastView.swift
//  Assignment_Stripe
//
//  Created by Roro on 14/06/24.
//

import SwiftUI

struct ToastView<Content>: View where Content: View {
    let content: () -> Content
    let dismissAfter: TimeInterval
    @Binding var isShowing: Bool
    let message: String
    var body: some View {
        ZStack {
            if isShowing {
                VStack {
                    Spacer()
                    Text(message)
                        .padding()
                        .background(Color.secondary.opacity(0.8))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .transition(.move(edge: .bottom))
                    content()
                }
                .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
                        withAnimation {
                            isShowing = false
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ToastView(content: {Text("")}, dismissAfter: 2, isShowing: .constant(false), message: "")
}
