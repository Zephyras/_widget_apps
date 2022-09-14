# flutter_json_serializable_app

A new Flutter project.

## Getting Started

## 코드 제너레이션 사용 방법
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart'; //임포트 밑에 작성
@JsonSerializable()
@JsonKey(name:'createdtime')

####_${클래스명}FromJson(json)
//formJson
####factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

_${클래스명}ToJson(this);
//ToJosn
Map<String, dynamic> toJson() => _$UserToJson(this);

## json serializable 실행 명령어
1.flutter pub run build_runner build

2.flutter pub run build_runner watch
계속 주시하게 만들어주는 명령어 코드. 클래스가 변경될때마다 자동적으로 변경해준다.
#네이밍컨벤션
json serializable은 createTime 문자형태를 선호한다
그래서 serialize 할경우 jason문자열에 맞춰서 안될경우가 있다.
jason문자열은 create_Time으로 되어 있을때는 변하길 원하는 문자열 변수 위에 @JsonKey(name: 'create_time')이라고 설정해주면 맞춰서 해준다.
명령어를 입력해주기전에 .g.dart를 삭제하고 다시 실행하라.

문제점:user클래스안에 address.g.dar 객체를 넣고 싶은데 null 예외처리가 자동으로 생성이안된다.


