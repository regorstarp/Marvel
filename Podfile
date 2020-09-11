plugin 'cocoapods-keys', {
:project => "Marvel",
:keys => [
  "MarvelAPIPrivateKey",
  "MarvelAPIPublicKey"
]}

platform :ios, '13.0'

target 'Marvel' do
  use_frameworks!
  pod 'Moya/RxSwift', '~> 13.0'
  pod 'Kingfisher', '~> 4.10.1'
  pod 'Swinject', '~> 2.6.2'
  pod 'SwinjectStoryboard', '~> 2.2.0'
  # Pods for Marvel

  target 'MarvelTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
