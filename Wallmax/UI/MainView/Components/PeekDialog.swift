//
//  PeekDialog.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 28.01.2025.
//

import SwiftUI

struct PeekDialog: ViewModifier {
	
	private var delay: Double = 0
	private var text: LocalizedStringKey
	private let buttonText: LocalizedStringKey?
	private var state: PeekDialogState
	private let transition = AnyTransition.asymmetric(
		insertion: .move(edge: .top),
		removal: .move(edge: .top).combined(with: .opacity))
	private let animation: Animation = .interactiveSpring()
	private var action: (() -> Void)?
	
	@Binding private var isPresented: Bool
	
	@State private var offset: CGSize = .zero
	@State private var opacity: Double = 1.0
	@State private var timer: Timer?
	
	init<T>(
		item: Binding<T?>,
		text: LocalizedStringKey,
		state: PeekDialogState,
		selfDismissDelay: PeekDialogDelay? = nil,
		buttonText: LocalizedStringKey? = nil,
		action: (() -> Void)? = nil) {
			
			self.text = text
			self.state = state
			self.buttonText = buttonText
			self.action = action
			
			if let dismissDelay = selfDismissDelay {
				self.delay = dismissDelay.duration
			}
			
			self._isPresented = Binding<Bool>(
				get: { item.wrappedValue != nil },
				set: { _ in item.wrappedValue = nil })
		}
	
	init(
		isPresented: Binding<Bool>,
		text: LocalizedStringKey,
		state: PeekDialogState,
		selfDismissDelay: PeekDialogDelay? = nil,
		buttonText: LocalizedStringKey? = nil,
		action: (() -> Void)? = nil) {
			
			if let dismissDelay = selfDismissDelay {
				self.delay = dismissDelay.duration
			}
			
			self._isPresented = isPresented
			self.text = text
			self.state = state
			self.buttonText = buttonText
			self.action = action
		}
	
	func body(content: Content) -> some View {
		ZStack {
			content
			if isPresented {
				VStack {
					ZStack(alignment: .topLeading) {
						VStack {
							HStack {
								VStack {
									state.image
										.foregroundColor(state.color)
										.padding()
									Spacer()
								}
								Text(text)
									.padding(12)
								Spacer()
							}
							
							if let action = action {
								HStack {
									Spacer()
									Button(buttonText ?? "") {
										action()
										dismiss()
									}
									.buttonStyle(.borderedProminent)
									.frame(maxWidth: 160, minHeight: 42)
									.padding()
								}
							}
						}
						.background {
							RoundedRectangle(cornerRadius: 24)
								.foregroundStyle(.regularMaterial)
						}
						.shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
					}
					.fixedSize(horizontal: false, vertical: true)
					Spacer()
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding()
				.offset(y: offset.height)
				.opacity(opacity)
				.animation(animation, value: isPresented)
				.transition(transition)
				.simultaneousGesture(
					DragGesture()
						.onChanged { gesture in
							timer?.invalidate()
							timer = nil
							if gesture.translation.width < 50 && (-30...109).contains(gesture.translation.height) {
								offset = gesture.translation
							}
						}
						.onEnded { _ in
							if offset.height > 50 || offset.height < -15 {
								dismiss()
							} else {
								offset = .zero
								if delay > 0 { setTimer() }
							}
						}
				)
				.onAppear {
					opacity = 1.0
					if delay > 0 { setTimer() }
				}
			}
		}
	}
	
	private func dismiss() {
		withAnimation {
			opacity = 0.0
			offset = .zero
		}
		isPresented = false
		timer?.invalidate()
		timer = nil
	}
	
	private func setTimer() {
		timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
			dismiss()
		}
	}
}

enum PeekDialogState {
	case info, error, warning
	
	var color: Color {
		switch self {
			case .info: .black
			case .error: .error
			case .warning: .warning
		}
	}
	
	var image: Image {
		switch self {
			case .info: Image(systemName: "info.circle")
			case .error: Image(systemName: "xmark.octagon.fill")
			case .warning: Image(systemName: "exclamationmark.triangle.fill")
		}
	}
}

enum PeekDialogDelay {
	case short, medium, long, persistent
	
	fileprivate var duration: Double {
		switch self {
			case .short: 2.0
			case .medium: 5.0
			case .long: 8.0
			case .persistent: 0.0
		}
	}
}

struct PeekDialogModel {
	
	let delay: PeekDialogDelay
	let state: PeekDialogState
	let text: LocalizedStringKey
	let buttonText: LocalizedStringKey?
	var action: (() -> Void)?
	
	init(
		delay: PeekDialogDelay,
		state: PeekDialogState,
		text: LocalizedStringKey,
		buttonText: LocalizedStringKey? = nil,
		action: (() -> Void)? = nil) {
			
			self.delay = delay
			self.state = state
			self.text = text
			self.buttonText = buttonText
			self.action = action
		}
}

extension View {
	
	func peekDialog(
		isPresented: Binding<Bool>,
		text: LocalizedStringKey,
		state: PeekDialogState,
		selfDismissDelay: PeekDialogDelay? = nil,
		buttonText: LocalizedStringKey? = nil,
		action: (() -> Void)? = nil) -> some View {
			
			modifier(PeekDialog(isPresented: isPresented,
								text: text,
								state: state,
								selfDismissDelay: selfDismissDelay,
								buttonText: buttonText,
								action: action))
	}
	
	func peekDialog<T>(
		item: Binding<T?>,
		text: LocalizedStringKey,
		state: PeekDialogState, selfDismissDelay: PeekDialogDelay? = nil,
		buttonText: LocalizedStringKey? = nil,
		action: (() -> Void)? = nil) -> some View {
			
			modifier(PeekDialog(item: item,
								text: text,
								state: state,
								selfDismissDelay: selfDismissDelay,
								buttonText: buttonText,
								action: action))
		}
	
	func peekDialog(with item: Binding<PeekDialogModel?>) -> some View {
		
		modifier(PeekDialog(item: item,
							text: item.wrappedValue?.text ?? "",
							state: item.wrappedValue?.state ?? .warning,
							selfDismissDelay: item.wrappedValue?.delay,
							buttonText: item.wrappedValue?.buttonText,
							action: item.wrappedValue?.action))
	}
}

#Preview {
	
	@Previewable @State var isPresented = true
	@Previewable @State var item: PeekDialogModel? = PeekDialogModel(
		delay: .persistent,
		state: .warning,
		text: "Error Info Warning",
		buttonText: " Do Something") { /* Button action */ }
	
	EmptyView()
		.peekDialog(with: $item)
}
