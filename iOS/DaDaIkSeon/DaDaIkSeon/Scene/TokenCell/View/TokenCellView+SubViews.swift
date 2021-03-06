//
//  TokenCellView+SubViews.swift
//  DaDaIkSeon
//
//  Created by 정재명 on 2020/12/01.
//

import SwiftUI

struct TopButtonViews: View {
    
    @Binding var checkBoxMode: Bool
    var token: Token
    var isChecked: Bool
    var action: () -> Void
    
    var body: some View {
        
        HStack {
            token.icon?.toImage()
                .foregroundColor(.white)
                .frame(width: 20, height: 20, alignment: .top)
            Spacer()
            Group {
                if checkBoxMode {
                    isChecked ?
                        Image.check : Image.emptyCircle
                } else {
                    Button(
                        action: { action() },
                        label: { Image.ellipsis.resizable() }
                    )
                }
            }
            .frame(width: 20, height: 20, alignment: .top)
            .foregroundColor(.white)
        }
        .padding(.horizontal, 12)
        .frame(height: 50, alignment: .center)
    }
}

struct CircularProgressBar: View {
    
    var progressAmount: Double
    var totalTime: Double
    let strokeWidth = 10.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: CGFloat(strokeWidth))
                .opacity(0.3)
                .foregroundColor(Color.white)
            
            Circle()
                .trim(from: CGFloat(1 / (totalTime/progressAmount)), to: 1.0)
                .stroke(style: StrokeStyle(
                            lineWidth: CGFloat(strokeWidth),
                            lineCap: .round,
                            lineJoin: .round))
                .foregroundColor(Color.white)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.none)
        }
    }
    
}

struct TokenInfoViews: View {
    
    var name: String
    var password: String
    var leftTime: String
    
    var body: some View {
        VStack(spacing: 5) {
            Spacer()
                .frame(height: 50)
            Text(name)
                .foregroundColor(.white)
                .font(.system(size: 13))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(
                    width: 110,
                    alignment: .center)
            (Text(password.prefix(3))
                + Text(" ")
                + Text(password.suffix(3)))
                .foregroundColor(.white)
                .font(.system(size: 28))
                .fontWeight(.bold)
                .kerning(3)
            Text(leftTime)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(.white)
            Spacer()
                .frame(height: 30)
        }
    }
}

struct CopyButtonView: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                action()
            }, label: {
                Image.copy
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
            })
        }
        .padding(.horizontal, 12)
        .frame(height: 50, alignment: .center)
    }
}

struct TokenPasswordView: View {
    
    var password: String
    var isMain: Bool
    
    var body: some View {
        HStack {
            (Text(password.prefix(3))
                + Text(" ")
                + Text(password.suffix(3)))
                .foregroundColor(.white)
                .font(.system(size: isMain ? 28 : 18))
                .fontWeight(.bold)
                .kerning(3)
            isMain ? nil : Spacer()
        }
        .padding([.horizontal, .bottom], 12)
    }
    
}

struct TokenNameView: View {
    
    var tokenName: String?
    
    var body: some View {
        HStack {
            Text(tokenName ?? "")
                .font(.system(size: 11))
                .foregroundColor(.white)
                .lineLimit(2)
            Spacer()
        }
        .padding(.horizontal, 12)
    }
}
