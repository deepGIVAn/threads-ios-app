import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Image("thread")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .modifier(ThreadsTextFieldModifier())

                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(ThreadsTextFieldModifier())

                TextField("Enter your full name", text: $viewModel.fullname)
                    .modifier(ThreadsTextFieldModifier())

                TextField("Enter your username", text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textContentType(.username)
                    .modifier(ThreadsTextFieldModifier())
            }
                        
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50, alignment: .init(horizontal: .center, vertical: .center))
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding(.top, 14)
            }
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(Color.black)
                .font(.footnote)
                
            }
            .padding(.vertical, 16)
        }
        .padding()

    }
}

#Preview {
    RegistrationView()
}
