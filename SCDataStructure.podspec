#
# Be sure to run `pod lib lint SCDataStructure.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SCDataStructure'
    s.version          = '0.1.0'
    s.summary          = 'SCDataStructure는 데이터 구조를 스위프트 버전으로 사용할 수 있도록 만든 라이브러리 입니다.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
    s.description      = <<-DESC
    SCDataStructure는 데이터 구조를 스위프트 버전으로 사용할 수 있도록 만든 라이브러리 입니다.
    고급 데이터 구조와 정렬 알고리즘, 트리 구조, 고급 검색 메서드, 그래프의 활용, 알고리즘의 성능과 효율성 개념도 위키에 추가할 예정입니다.
                         DESC
  
    s.homepage         = 'https://github.com/interactord/SCDataStructure'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'interactord' => 'interactord@gmail.com' }
    s.source           = { :git => 'https://github.com/interactord/SCDataStructure.git', :tag => s.version.to_s }
    s.swift_version = '5.0'
  
    s.ios.deployment_target = '12.1'
  
    s.source_files = 'SCDataStructure/**/*.swift'
    
    # s.resource_bundles = {
    #   'SCDataStructure' => ['SCDataStructure/Assets/*.png']
    # }
  
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
  end
  