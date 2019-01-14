# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

def pods

########### Github共有库 #############

  pod 'GetuiSDK-NoIDFA'
  pod 'WechatOpenSDK'
  # U-Share SDK UI模块（分享面板，建议添加）
  pod 'UMengUShare/UI’
  # 集成微信(精简版0.2M)
  pod 'UMengUShare/Social/ReducedWeChat'
  pod 'UMCCommon'
  pod 'UMCSecurityPlugins'
  pod 'UMCAnalytics'
  # 刷新
  pod 'MJRefresh', '~> 3.1.15.3'
  pod 'ESPullToRefresh', '~> 2.7'
  # 空页面
  pod 'DZNEmptyDataSet'
  # 扫描二维码
  pod 'swiftScan', '~> 1.1.2'
  # 提示框
  pod 'PGActionSheet', '= 1.0.10'
  pod 'SCLAlertView'
  pod 'MBProgressHUD', '~> 1.1.0'
  pod 'SVProgressHUD', '~> 2.2.5'
  # JSON解析
  pod 'ObjectMapper', '~> 3.3'
  pod 'SwiftyJSON', '~> 4.0'
  # 页面约束
  pod 'SnapKit', '~> 4.0.0'
  # 网络库
  pod 'Moya/RxSwift', '~> 11.0'
  pod 'Result', '~> 3.0.0'
  pod 'AliyunOSSiOS', '~> 2.10.4'
  pod 'Kingfisher', '~> 4.8.0'
  
  # 图表
  pod 'Charts', '~> 3.1.1'
  # rx库
  pod 'RxSwift', '~> 4.2.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'RxDataSources', '~> 3.0'
  pod 'RxTest', '~> 4.2.0'

  # others
  pod 'KMPlaceholderTextView', '~> 1.3.0'
  pod 'ESTabBarController-swift', '~> 2.6.2'
  pod 'IQKeyboardManagerSwift', '= 6.0.3'
  pod 'GuidePageView', '= 1.0.0'
  pod 'URLNavigator'
  

  ########### Private私有库 ##############
  
end


target 'WanDeBao-Merchant' do
    pods
end


target 'WanDeBao-MerchantTests' do
    pods
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = ‘4.0’ # or ‘4.0’
    end
  end
end
