#source 'https://github.com/ /Specs.git'

platform :ios,'9.0'

#post_install do |installer|
#   需要指定编译版本的第三方的名称
#  myTargets = ['ObjectMapper', 'SnapKit']
#
#  installer.pods_project.targets.each do |target|
#    if myTargets.include? target.name
#      target.build_configurations.each do |config|
#        config.build_settings['SWIFT_VERSION'] = '5.0'
#      end
#    end
#  end
#end
#
#use_frameworks!

target 'MySwift' do
#frameworks	use_frameworks!
pod 'SnapKit', '~>4.2.0' #布局
pod 'Alamofire', '~> 4.8.2' #网络
#pod 'ObjectMapper'
pod 'Moya','~>13.0.0'
pod 'Moya/RxSwift'
pod 'Kingfisher', '~>4.10.1' #图像
pod 'PKHUD', '~> 5.2.1' #hud
use_frameworks!
pod 'MJRefresh', '~> 3.1.16'
end
